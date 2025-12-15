use std::{
    collections::HashMap,
    path::PathBuf,
    process,
    sync::Arc,
    time::SystemTime,
};

use serde::{Deserialize, Serialize};
use tokio::sync::RwLock;

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct ServerInfo {
    pub pid: u32,
    pub port: u16,
    pub path: PathBuf,
    pub started_at: SystemTime,
}

#[derive(Clone)]
pub struct ServerManager {
    servers: Arc<RwLock<HashMap<PathBuf, ServerInfo>>>,
}

impl ServerManager {
    pub fn new() -> Self {
        Self {
            servers: Arc::new(RwLock::new(HashMap::new())),
        }
    }

    pub async fn get_server(&self, path: &PathBuf) -> Option<ServerInfo> {
        let servers = self.servers.read().await;
        if let Some(info) = servers.get(path) {
            // Check if process is still alive
            if self.is_process_alive(info.pid) {
                return Some(info.clone());
            }
        }
        None
    }

    pub async fn register_server(&self, path: PathBuf, pid: u32, port: u16) {
        let mut servers = self.servers.write().await;
        servers.insert(
            path.clone(),
            ServerInfo {
                pid,
                port,
                path,
                started_at: SystemTime::now(),
            },
        );
    }

    pub async fn unregister_server(&self, path: &PathBuf) {
        let mut servers = self.servers.write().await;
        servers.remove(path);
    }
    
    // Simple check if process is alive (Unix only for now really, but crates usually handle this)
    // We can use `nix` or just check /proc on linux.
    // For now, let's assume if it's in the map, it's alive, or we lazily clean up.
    fn is_process_alive(&self, pid: u32) -> bool {
        #[cfg(unix)]
        {
            use nix::sys::signal::{kill, Signal};
            use nix::unistd::Pid;
            
            let pid = Pid::from_raw(pid as i32);
            // Sending signal 0 checks for existence
            match kill(pid, None) {
                Ok(_) => true,
                Err(_) => false, // Process likely gone or permission denied (but we started it so...)
            }
        }
        #[cfg(not(unix))]
        {
            // Windows etc implementation omitted for brevity, assume true
            true
        }
        
    }
}
