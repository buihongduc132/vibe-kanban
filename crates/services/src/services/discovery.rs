use std::{
    path::{Path, PathBuf},
    time::{Duration, SystemTime},
};

use ignore::WalkBuilder;
use serde::{Deserialize, Serialize};
use tracing::{info, warn};
use ts_rs::TS;

#[derive(Debug, Serialize, Deserialize, Clone, TS)]
#[ts(export)]
pub struct DiscoveredProject {
    pub path: PathBuf,
    pub name: String,
    pub last_modified_ms: Option<i64>, // milliseconds since epoch
}

pub struct ProjectDiscoveryService;

impl ProjectDiscoveryService {
    pub fn discover(roots: Vec<PathBuf>) -> Vec<DiscoveredProject> {
        let mut results = Vec::new();
        let limit_duration = Duration::from_secs(14 * 24 * 60 * 60); // 14 days
        let now = SystemTime::now();

        for root in roots {
            if !root.exists() {
                continue;
            }

            // We want to find .git directories.
            // We use standard recursion but limiting depth to avoid scanning the whole world if user passes home.
            // But wait, finding ALL git repos in home might be slow.
            // We'll use WalkBuilder.
            
            // Note: We are looking for directories that *contain* a .git folder, or are bare git repos.
            // Usually standard git repo has .git dir.
            
            let walker = WalkBuilder::new(&root)
                .hidden(false) // We need to see .git
                .max_depth(Some(4)) // Limit depth to avoid scanning too deep
                .git_global(false)
                .git_ignore(false)
                .git_exclude(false)
                .follow_links(false)
                .build();

            for result in walker {
                match result {
                    Ok(entry) => {
                        let path = entry.path();
                        if path.file_name().map(|s| s == ".git").unwrap_or(false) && path.is_dir() {
                             if let Some(parent) = path.parent() {
                                 // Check modification time
                                 let metadata = match std::fs::metadata(path) {
                                     Ok(m) => m,
                                     Err(_) => continue,
                                 };
                                 
                                 let modified = metadata.modified().ok();
                                 let is_recent = if let Some(m) = modified {
                                     if let Ok(duration) = now.duration_since(m) {
                                         duration < limit_duration
                                     } else {
                                          // Future dates? include them
                                          true
                                     }
                                 } else {
                                     false
                                 };

                                 if is_recent {
                                     let name = parent.file_name()
                                         .map(|s| s.to_string_lossy().to_string())
                                         .unwrap_or_else(|| "unknown".to_string());
                                     
                                     let last_modified_ms = modified
                                         .and_then(|t| t.duration_since(SystemTime::UNIX_EPOCH).ok())
                                         .map(|d| d.as_millis() as i64);

                                     results.push(DiscoveredProject {
                                         path: parent.to_path_buf(),
                                         name,
                                         last_modified_ms,
                                     });
                                 }
                             }
                        }
                    }
                    Err(err) => {
                        warn!("Error walking directory {}: {}", root.display(), err);
                    }
                }
            }
        }
        
        // Deduplicate by path
        results.sort_by(|a, b| a.path.cmp(&b.path));
        results.dedup_by(|a, b| a.path == b.path);
        
        // Sort by recency (newest first)
        results.sort_by(|a, b| b.last_modified_ms.cmp(&a.last_modified_ms));

        results
    }
}
