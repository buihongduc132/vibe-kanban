use std::path::PathBuf;

use axum::{Json, extract::State, response::{Json as ResponseJson}, routing::{post}, Router};
use serde::{Deserialize, Serialize};
use services::services::container::ContainerError;

use crate::{DeploymentImpl, error::ApiError};

#[derive(Deserialize)]
pub struct StartServerRequest {
    pub path: String,
    pub port: Option<u16>,
}

#[derive(Serialize)]
pub struct StartServerResponse {
    pub port: u16,
    pub message: String,
}

pub async fn start_server(
    State(deployment): State<DeploymentImpl>,
    Json(payload): Json<StartServerRequest>,
) -> Result<ResponseJson<StartServerResponse>, ApiError> {
    let path = PathBuf::from(payload.path);
    if !path.exists() {
         return Err(ApiError::Container(ContainerError::Other(anyhow::anyhow!("Path does not exist"))));
    }

    let port = deployment.local_container()
        .launch_server_mode(&path, payload.port)
        .await
        .map_err(|e| ApiError::Container(e))?;

    Ok(ResponseJson(StartServerResponse {
        port,
        message: format!("Server running on port {}", port),
    }))
}

pub fn router(_deployment: &DeploymentImpl) -> Router<DeploymentImpl> {
    Router::new()
        .route("/start", post(start_server))
}
