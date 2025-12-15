use std::path::PathBuf;

use axum::{Json, extract::Query, routing::get, Router};
use serde::Deserialize;
use services::services::discovery::{DiscoveredProject, ProjectDiscoveryService};

#[derive(Deserialize)]
pub struct DiscoveryQuery {
    roots: Option<Vec<String>>,
}

pub async fn list_projects(
    Query(query): Query<DiscoveryQuery>,
) -> Json<Vec<DiscoveredProject>> {
    let mut roots: Vec<PathBuf> = Vec::new();
    
    if let Some(query_roots) = query.roots {
        for r in query_roots {
             roots.push(PathBuf::from(r));
        }
    }
    
    // Add default search paths if not provided or to supplement
    if roots.is_empty() {
        if let Some(home) = dirs::home_dir() {
            roots.push(home.join("Documents/Projects"));
            roots.push(home.join("work"));
            roots.push(home.join("code"));
            roots.push(home.join("projects"));
            roots.push(home.join("repos"));
        }
    }

    let projects = ProjectDiscoveryService::discover(roots);
    Json(projects)
}

pub fn router() -> Router<crate::DeploymentImpl> {
    Router::new().route("/discovery", get(list_projects))
}
