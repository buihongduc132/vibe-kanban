-- ============================================================
-- POPULATE functionalities TABLE — exhaustive, atomic rows
-- ============================================================

-- AREA 1: Kanban Board & Issue Management (14 features)
INSERT INTO functionalities (feature_area, feature_name, description, status, priority) VALUES
('Kanban Board & Issue Management', 'Issue creation', 'Create issues with title, description, priority level (Urgent/High/Medium/Low), assignees, tags, and sub-issue hierarchy', 'implemented', 'Urgent'),
('Kanban Board & Issue Management', 'Issue editing', 'Edit all issue fields including title, description, priority, assignees, tags, and linked sub-issues', 'implemented', 'Urgent'),
('Kanban Board & Issue Management', 'Kanban board columns', 'Board displays columns: Backlog, To do, In progress, In review, Done, Cancelled — each a distinct workflow stage', 'implemented', 'Urgent'),
('Kanban Board & Issue Management', 'Drag-and-drop card movement', 'Drag and drop issues between Kanban columns to update their workflow status', 'implemented', 'Urgent'),
('Kanban Board & Issue Management', 'Column customization — add', 'Add new custom columns to the Kanban board beyond the default set', 'implemented', 'High'),
('Kanban Board & Issue Management', 'Column customization — rename', 'Rename existing Kanban columns to match team terminology', 'implemented', 'High'),
('Kanban Board & Issue Management', 'Column customization — hide/delete', 'Hide or delete columns from the Kanban board view', 'implemented', 'High'),
('Kanban Board & Issue Management', 'Column customization — reorder', 'Reorder columns via drag-and-drop to rearrange workflow sequence', 'implemented', 'High'),
('Kanban Board & Issue Management', 'Column customization — colors', 'Assign custom colors to each Kanban column for visual distinction', 'implemented', 'Medium'),
('Kanban Board & Issue Management', 'Team/Personal tab filtering', 'Toggle between Team and Personal issue views using tabbed filtering', 'implemented', 'High'),
('Kanban Board & Issue Management', 'Filter by priority', 'Filter issues displayed on the board by priority level (Urgent/High/Medium/Low)', 'implemented', 'High'),
('Kanban Board & Issue Management', 'Filter by assignee', 'Filter issues by assigned team member', 'implemented', 'High'),
('Kanban Board & Issue Management', 'Filter by tags', 'Filter issues by one or more tags', 'implemented', 'High'),
('Kanban Board & Issue Management', 'Sorting — multiple criteria', 'Sort issues by Manual (drag order), Priority, Created date, Updated date, or Title — each in asc or desc order', 'implemented', 'Medium'),
('Kanban Board & Issue Management', 'Sub-issue management', 'Create, link, and manage hierarchical sub-issues under parent issues', 'implemented', 'High');

-- AREA 2: Workspaces (10 features)
INSERT INTO functionalities (feature_area, feature_name, description, status, priority) VALUES
('Workspaces', 'Create workspace', 'Create an isolated workspace with its own git worktree for parallel AI agent task execution', 'implemented', 'Urgent'),
('Workspaces', 'Multiple repositories per workspace', 'Attach and manage multiple git repositories within a single workspace', 'implemented', 'Urgent'),
('Workspaces', 'Per-repository setup script', 'Define and execute a custom setup script when adding a repo to a workspace', 'implemented', 'High'),
('Workspaces', 'Per-repository cleanup script', 'Define and execute a custom cleanup script when removing or resetting a repo from a workspace', 'implemented', 'Medium'),
('Workspaces', 'Per-repository dev-server script', 'Define a dev-server start script per repository, launched and managed from the UI', 'implemented', 'High'),
('Workspaces', 'Coding agent configuration per workspace', 'Configure which coding agent (e.g., Claude Code, Gemini CLI, Codex) runs in this workspace', 'implemented', 'High'),
('Workspaces', 'Workspace notes', 'Free-text notes field attached to each workspace for context and instructions', 'implemented', 'Medium'),
('Workspaces', 'Workspace archive', 'Archive a workspace to declutter the active list while preserving its state', 'implemented', 'Medium'),
('Workspaces', 'Workspace pin', 'Pin frequently-used workspaces to the top of the workspace list', 'implemented', 'Medium'),
('Workspaces', 'Workspace duplicate', 'Duplicate a workspace including its repository attachments and agent configuration', 'implemented', 'Medium'),
('Workspaces', 'Workspace delete', 'Permanently delete a workspace and its associated worktree and sessions', 'implemented', 'High');

-- AREA 3: Multi-Repository Support (3 features)
INSERT INTO functionalities (feature_area, feature_name, description, status, priority) VALUES
('Multi-Repository Support', 'Independent git state per repository', 'Each repository in a workspace maintains its own independent git working directory, branches, and status', 'implemented', 'Urgent'),
('Multi-Repository Support', 'Multi-repo PR creation', 'Create pull requests across multiple repositories simultaneously from a single unified view', 'implemented', 'High'),
('Multi-Repository Support', 'Multi-repo merge and rebase', 'Merge or rebase branches across multiple repositories in a coordinated operation', 'implemented', 'High');

-- AREA 4: Sessions (5 features)
INSERT INTO functionalities (feature_area, feature_name, description, status, priority) VALUES
('Sessions', 'Multiple sessions per workspace', 'Create and manage multiple parallel conversation sessions within a single workspace', 'implemented', 'Urgent'),
('Sessions', 'Parallel agent execution across sessions', 'Run multiple coding agents concurrently, each in its own session, from the same workspace', 'implemented', 'Urgent'),
('Sessions', 'Session state — Running', 'Active session state indicating the agent is currently executing tasks', 'implemented', 'Urgent'),
('Sessions', 'Session state — Idle', 'Session state indicating the agent is available and awaiting input', 'implemented', 'Urgent'),
('Sessions', 'Session state — Needs Attention', 'Session state indicating the agent requires human input, approval, or conflict resolution', 'implemented', 'Urgent'),
('Sessions', 'Context/token gauge', 'Visual indicator showing current context window usage and token budget for the active session', 'implemented', 'High');

-- AREA 5: Code Review & Changes (5 features)
INSERT INTO functionalities (feature_area, feature_name, description, status, priority) VALUES
('Code Review & Changes', 'Syntax-highlighted diff viewer — unified', 'Unified diff view with full syntax highlighting for all supported languages', 'implemented', 'Urgent'),
('Code Review & Changes', 'Syntax-highlighted diff viewer — side-by-side', 'Side-by-side split diff view with synchronized scrolling and syntax highlighting', 'implemented', 'Urgent'),
('Code Review & Changes', 'File tree of modified files', 'Navigable file tree listing all modified, added, and deleted files in the current change set', 'implemented', 'High'),
('Code Review & Changes', 'Inline comments on specific lines', 'Add threaded comments anchored to specific line numbers in the diff view', 'implemented', 'High'),
('Code Review & Changes', 'Review-comment-fix loop', 'Iterative workflow: review → comment → agent addresses comment → re-review until approval', 'implemented', 'High');

-- AREA 6: Browser Testing & Preview (9 features)
INSERT INTO functionalities (feature_area, feature_name, description, status, priority) VALUES
('Browser Testing & Preview', 'Built-in preview browser', 'Embedded browser within the UI to preview running applications without switching context', 'implemented', 'Urgent'),
('Browser Testing & Preview', 'Auto-detect dev server URLs', 'Automatically detect and connect to running dev server URLs (e.g., localhost:3000, :5173, :8080)', 'implemented', 'High'),
('Browser Testing & Preview', 'Start dev server from UI', 'Trigger the configured dev-server script for a repo directly from the UI controls', 'implemented', 'Urgent'),
('Browser Testing & Preview', 'Stop dev server from UI', 'Stop a running dev server process from the UI without leaving the application', 'implemented', 'High'),
('Browser Testing & Preview', 'Pause dev server from UI', 'Pause (suspend) a running dev server from the UI', 'implemented', 'Medium'),
('Browser Testing & Preview', 'Device mode — Desktop', 'Preview in default desktop viewport', 'implemented', 'High'),
('Browser Testing & Preview', 'Device mode — Mobile (390×844)', 'Preview at iPhone 14 Pro dimensions (390×844px)', 'implemented', 'High'),
('Browser Testing & Preview', 'Device mode — Custom/Responsive', 'Define and preview at custom viewport dimensions for responsive testing', 'implemented', 'High'),
('Browser Testing & Preview', 'Click-to-component inspection', 'Click any element in the preview to locate and highlight its source component in React, Vue, Svelte, Astro, or vanilla HTML', 'implemented', 'High'),
('Browser Testing & Preview', 'Built-in DevTools — Eruda console', 'Embedded Eruda console tab showing JavaScript console output, logs, errors, and warnings', 'implemented', 'High'),
('Browser Testing & Preview', 'Built-in DevTools — Eruda elements', 'Eruda DOM elements inspector for viewing and modifying HTML structure and CSS styles live', 'implemented', 'High'),
('Browser Testing & Preview', 'Built-in DevTools — Eruda network', 'Eruda network panel capturing and displaying network requests, timings, and payloads', 'implemented', 'Medium'),
('Browser Testing & Preview', 'Built-in DevTools — Eruda resources', 'Eruda resources panel for inspecting cookies, localStorage, sessionStorage, and other browser resources', 'implemented', 'Medium');

-- AREA 7: Git Operations (9 features)
INSERT INTO functionalities (feature_area, feature_name, description, status, priority) VALUES
('Git Operations', 'Branch management', 'Create, switch, rename, delete, and list branches directly from the UI', 'implemented', 'Urgent'),
('Git Operations', 'PR creation', 'Create GitHub pull requests with AI-generated descriptions based on commit diff', 'implemented', 'Urgent'),
('Git Operations', 'Merge branches', 'Merge one branch into another with conflict detection and resolution support', 'implemented', 'Urgent'),
('Git Operations', 'Rebase branches', 'Interactive and non-interactive rebase of branches with conflict resolution', 'implemented', 'High'),
('Git Operations', 'Push branches', 'Push local branches to remote origin with force-push option for rebased branches', 'implemented', 'Urgent'),
('Git Operations', 'Conflict resolution', 'Visual merge conflict editor showing both versions with accept/combine controls', 'implemented', 'Urgent'),
('Git Operations', 'GitHub CLI integration', 'Full integration with the gh CLI for auth, repo operations, PRs, and reviews', 'implemented', 'High'),
('Git Operations', 'Stash changes', 'Temporarily stash uncommitted changes with named stash entries', 'implemented', 'Medium'),
('Git Operations', 'Cherry-pick commits', 'Cherry-pick individual commits from one branch to another', 'implemented', 'Medium');

-- AREA 8: Agent Configurations & Profiles (13 features)
INSERT INTO functionalities (feature_area, feature_name, description, status, priority) VALUES
('Agent Configurations & Profiles', 'Reusable agent profiles', 'Define and save named agent configuration profiles for quick reuse across workspaces', 'implemented', 'Urgent'),
('Agent Configurations & Profiles', 'Claude Code — planning mode', 'Enable/disable Claude Code planning mode in agent profile configuration', 'implemented', 'High'),
('Agent Configurations & Profiles', 'Claude Code — Router', 'Configure Claude Code Router mode in agent profile', 'implemented', 'Medium'),
('Agent Configurations & Profiles', 'Claude Code — permissions', 'Configure permission levels (read-only, write, admin) for Claude Code agent', 'implemented', 'High'),
('Agent Configurations & Profiles', 'Gemini CLI — YOLO mode', 'Enable/disable Gemini CLI YOLO (no-prompt-approval) mode in agent profile', 'implemented', 'High'),
('Agent Configurations & Profiles', 'Codex — sandbox modes', 'Configure Codex sandbox execution modes (limited, standard, unrestricted) per profile', 'implemented', 'Medium'),
('Agent Configurations & Profiles', 'Cursor AI profile support', 'Use Cursor AI as a configured coding agent within a workspace', 'implemented', 'Medium'),
('Agent Configurations & Profiles', 'OpenCode agent support', 'Use OpenCode as a configured coding agent within a workspace', 'implemented', 'Medium'),
('Agent Configurations & Profiles', 'Droid — autonomy levels', 'Configure Droid agent autonomy levels (supervised, semi-autonomous, fully autonomous) per profile', 'implemented', 'Medium'),
('Agent Configurations & Profiles', 'Amp agent support', 'Use Amp as a configured coding agent within a workspace', 'implemented', 'Low'),
('Agent Configurations & Profiles', 'Qwen Code support', 'Use Qwen Code as a configured coding agent within a workspace', 'implemented', 'Low'),
('Agent Configurations & Profiles', 'Environment variables per profile', 'Set custom environment variables scoped to each agent profile', 'implemented', 'High'),
('Agent Configurations & Profiles', 'MCP server config per agent profile', 'Attach MCP server configurations to individual agent profiles', 'implemented', 'High');

-- AREA 9: Third-Party Provider Support (6 features)
INSERT INTO functionalities (feature_area, feature_name, description, status, priority) VALUES
('Third-Party Provider Support', 'Z.ai (GLM) provider', 'Connect Z.ai / GLM models as a coding agent backend via their API endpoint', 'implemented', 'Medium'),
('Third-Party Provider Support', 'OpenRouter provider', 'Route agent requests through OpenRouter to access multiple LLM providers via a unified API', 'implemented', 'High'),
('Third-Party Provider Support', 'Custom Anthropic endpoint', 'Configure a custom self-hosted or proxy Anthropic API endpoint', 'implemented', 'Medium'),
('Third-Party Provider Support', 'Provider API key management', 'Securely store and manage API keys for third-party LLM providers', 'implemented', 'High'),
('Third-Party Provider Support', 'Provider rate limit configuration', 'Configure rate limits per provider to avoid quota exhaustion', 'implemented', 'Medium'),
('Third-Party Provider Support', 'Fallback provider chains', 'Define ordered fallback providers that are used when the primary provider fails', 'implemented', 'Low');

-- AREA 10: MCP (Model Context Protocol) Servers (4 features)
INSERT INTO functionalities (feature_area, feature_name, description, status, priority) VALUES
('MCP Servers', 'Per-agent MCP server configuration', 'Attach one or more MCP server connections to a specific agent session or profile', 'implemented', 'High'),
('MCP Servers', 'One-click popular server installation', 'One-click installation for popular MCP servers (e.g., filesystem, git, github, slack)', 'implemented', 'High'),
('MCP Servers', 'Custom MCP server JSON config', 'Upload or paste a custom MCP server JSON configuration for user-defined servers', 'implemented', 'High'),
('MCP Servers', 'MCP server health monitoring', 'Monitor MCP server connection status and display health indicators in the UI', 'implemented', 'Medium');

-- AREA 11: Cloud Collaboration (10 features)
INSERT INTO functionalities (feature_area, feature_name, description, status, priority) VALUES
('Cloud Collaboration', 'GitHub OAuth sign-in', 'Authenticate users via GitHub OAuth for cloud collaboration features', 'implemented', 'Urgent'),
('Cloud Collaboration', 'Google OAuth sign-in', 'Authenticate users via Google OAuth as an alternative to GitHub', 'implemented', 'High'),
('Cloud Collaboration', 'Personal organization', 'Default personal org created automatically on account creation', 'implemented', 'Urgent'),
('Cloud Collaboration', 'Team organization', 'Create and manage team organizations with shared workspaces and projects', 'implemented', 'High'),
('Cloud Collaboration', 'Role — Admin', 'Admin role with full permissions: manage members, billing, settings, and all workspace operations', 'implemented', 'Urgent'),
('Cloud Collaboration', 'Role — Member', 'Member role with workspace and project access scoped by Admin assignments', 'implemented', 'Urgent'),
('Cloud Collaboration', 'Real-time sync via ElectricSQL + Postgres', 'Conflict-free real-time collaboration using ElectricSQL synced to a Postgres backend', 'implemented', 'Urgent'),
('Cloud Collaboration', 'Invite members', 'Send and manage workspace/project invitations to users by email or username', 'implemented', 'High'),
('Cloud Collaboration', 'Remove members', 'Remove members from organizations with immediate access revocation', 'implemented', 'High'),
('Cloud Collaboration', 'Transfer ownership', 'Transfer organization ownership to another Admin member', 'implemented', 'High');

-- AREA 12: Projects (5 features)
INSERT INTO functionalities (feature_area, feature_name, description, status, priority) VALUES
('Projects', 'Create project', 'Create a named project with a chosen color identifier for visual grouping', 'implemented', 'Urgent'),
('Projects', 'Custom status columns per project', 'Define a custom set of Kanban columns specific to each project', 'implemented', 'High'),
('Projects', 'Tags management', 'Create, edit, delete, and color-code tags that can be applied across all projects', 'implemented', 'High'),
('Projects', 'Project settings', 'Configure project-level settings including default branch, notification preferences, and integrations', 'implemented', 'Medium'),
('Projects', 'Project delete', 'Permanently delete a project and all associated issues and settings', 'implemented', 'Medium');

-- AREA 13: Settings & Configuration (5 features)
INSERT INTO functionalities (feature_area, feature_name, description, status, priority) VALUES
('Settings & Configuration', 'Global settings — default agent', 'Set a system-wide default coding agent used when creating new workspaces', 'implemented', 'High'),
('Settings & Configuration', 'Global settings — workspace directory', 'Configure the root directory on disk where workspaces and worktrees are created', 'implemented', 'High'),
('Settings & Configuration', 'Global settings — remote SSH', 'Configure default SSH key and remote host settings for remote development', 'implemented', 'Medium'),
('Settings & Configuration', 'Per-project settings', 'Override global defaults with settings scoped to individual projects', 'implemented', 'Medium'),
('Settings & Configuration', 'Agent profiles and MCP server settings', 'UI for managing all agent profiles, their environment variables, and MCP server attachments', 'implemented', 'High');

-- AREA 14: Command Bar (2 features)
INSERT INTO functionalities (feature_area, feature_name, description, status, priority) VALUES
('Command Bar', 'Quick actions via Cmd/Ctrl+K', 'Global keyboard shortcut opens a command palette for fast navigation and action execution', 'implemented', 'Urgent'),
('Command Bar', 'Search across repos and sessions', 'Search issues, files, commit messages, and session history from the command bar', 'implemented', 'High');

-- AREA 15: Remote Access (2 features)
INSERT INTO functionalities (feature_area, feature_name, description, status, priority) VALUES
('Remote Access', 'Pairing codes for remote device access', 'Generate time-limited pairing codes to securely connect remote devices to the local instance', 'implemented', 'High'),
('Remote Access', 'Mobile workspace access', 'Access and interact with workspaces from a mobile browser or app via the remote tunnel', 'implemented', 'Medium');

-- AREA 16: Desktop Application (Tauri) (5 features)
INSERT INTO functionalities (feature_area, feature_name, description, status, priority) VALUES
('Desktop Application (Tauri)', 'Native OS integration', 'Native window management, menus, and OS-level integration via Tauri/Rust backend', 'implemented', 'Urgent'),
('Desktop Application (Tauri)', 'System tray icon', 'Minimize to system tray with tray menu for quick workspace switching and status indicators', 'implemented', 'High'),
('Desktop Application (Tauri)', 'System notifications', 'Native OS notifications for session state changes, build completions, and mentions', 'implemented', 'High'),
('Desktop Application (Tauri)', 'Offline support', 'Continue working offline with local data; sync when connectivity is restored', 'implemented', 'High'),
('Desktop Application (Tauri)', 'Auto-update mechanism', 'Background auto-update downloads and installs new desktop app versions', 'implemented', 'Medium');

-- AREA 17: Self-Hosting / Docker (5 features)
INSERT INTO functionalities (feature_area, feature_name, description, status, priority) VALUES
('Self-Hosting / Docker', 'Docker Compose deployment', 'Deploy the full stack (app + Postgres + ElectricSQL) via Docker Compose with a single config file', 'implemented', 'Urgent'),
('Self-Hosting / Docker', 'PostgreSQL database configuration', 'Configurable PostgreSQL connection string and credentials for self-hosted deployments', 'implemented', 'Urgent'),
('Self-Hosting / Docker', 'ElectricSQL sync service', 'Self-hosted ElectricSQL sync engine for real-time collaboration without relying on the managed cloud', 'implemented', 'High'),
('Self-Hosting / Docker', 'nginx reverse proxy config', 'Production nginx reverse proxy configuration example for SSL termination and load balancing', 'implemented', 'Medium'),
('Self-Hosting / Docker', 'Caddy reverse proxy config', 'Production Caddy reverse proxy configuration as an alternative to nginx (automatic HTTPS)', 'implemented', 'Medium'),
('Self-Hosting / Docker', 'Traefik reverse proxy config', 'Traefik reverse proxy configuration for containerized self-hosted deployments', 'implemented', 'Low');

-- AREA 18: CLI (npx vibe-kanban) (4 features)
INSERT INTO functionalities (feature_area, feature_name, description, status, priority) VALUES
('CLI (npx vibe-kanban)', 'One-command launch', 'Launch the full application with a single npx vibe-kanban command', 'implemented', 'Urgent'),
('CLI (npx vibe-kanban)', 'Auto-assign available ports', 'Automatically detect and bind to the first available port when the default is occupied', 'implemented', 'High'),
('CLI (npx vibe-kanban)', 'Cross-platform support', 'CLI runs identically on Linux, macOS, and Windows via Node.js/pnpm', 'implemented', 'High'),
('CLI (npx vibe-kanban)', 'CLI config flag support', 'Pass configuration overrides via CLI flags (--port, --dir, --db-url, etc.)', 'implemented', 'Medium');

-- AREA 19: Relay & Tunneling (4 features)
INSERT INTO functionalities (feature_area, feature_name, description, status, priority) VALUES
('Relay & Tunneling', 'Tunnel mode', 'Expose local instance to the internet via a relay tunnel for remote access without port forwarding', 'implemented', 'High'),
('Relay & Tunneling', 'WebRTC peer-to-peer connection', 'Direct P2P browser-to-browser connection for low-latency remote access when both parties are online', 'implemented', 'Medium'),
('Relay & Tunneling', 'WebSocket bridging', 'WebSocket-based relay bridge for environments where direct P2P is blocked by firewalls', 'implemented', 'Medium'),
('Relay & Tunneling', 'Tunnel access logging', 'Log all tunnel connections with timestamps, client IPs, and session durations for audit purposes', 'implemented', 'Low');

-- ============================================================
-- POPULATE acceptance_criteria TABLE
-- ============================================================

-- AC for Kanban Board & Issue Management
INSERT INTO acceptance_criteria (functionality_id, criterion) SELECT id, 'User can create an issue with title, description, priority, assignees, tags, and sub-issues and see it appear in the correct Kanban column' FROM functionalities WHERE feature_name = 'Issue creation';
INSERT INTO acceptance_criteria (functionality_id, criterion) SELECT id, 'Dragging an issue card from one column to another persists the new column assignment in the database' FROM functionalities WHERE feature_name = 'Drag-and-drop card movement';
INSERT INTO acceptance_criteria (functionality_id, criterion) SELECT id, 'All five filter types (Team/Personal, priority, assignee, tags) can be combined and correctly narrow the visible issue set' FROM functionalities WHERE feature_name = 'Filter by priority';

-- AC for Workspaces
INSERT INTO acceptance_criteria (functionality_id, criterion) SELECT id, 'Creating a workspace spawns a new git worktree at the configured path with its own .git file' FROM functionalities WHERE feature_name = 'Create workspace';
INSERT INTO acceptance_criteria (functionality_id, criterion) SELECT id, 'Per-repo setup script executes successfully when a repository is first added, and its output is visible in the UI' FROM functionalities WHERE feature_name = 'Per-repository setup script';
INSERT INTO acceptance_criteria (functionality_id, criterion) SELECT id, 'At least two sessions can be running in parallel within the same workspace, each executing a separate agent' FROM functionalities WHERE feature_name = 'Parallel agent execution across sessions';

-- AC for Browser Testing & Preview
INSERT INTO acceptance_criteria (functionality_id, criterion) SELECT id, 'The built-in browser loads a local dev server URL and renders the application correctly' FROM functionalities WHERE feature_name = 'Built-in preview browser';
INSERT INTO acceptance_criteria (functionality_id, criterion) SELECT id, 'Switching to Mobile device mode (390×844) resizes the iframe to the correct pixel dimensions' FROM functionalities WHERE feature_name = 'Device mode — Mobile (390×844)';
INSERT INTO acceptance_criteria (functionality_id, criterion) SELECT id, 'Clicking a DOM element in the Eruda elements panel highlights its source component in the editor pane' FROM functionalities WHERE feature_name = 'Click-to-component inspection';

-- AC for Git Operations
INSERT INTO acceptance_criteria (functionality_id, criterion) SELECT id, 'A PR created from the UI opens on GitHub with an AI-generated description based on the branch diff' FROM functionalities WHERE feature_name = 'PR creation';
INSERT INTO acceptance_criteria (functionality_id, criterion) SELECT id, 'Merge conflicts are rendered visually with both versions and allow the user to accept, reject, or combine changes before committing' FROM functionalities WHERE feature_name = 'Conflict resolution';
INSERT INTO acceptance_criteria (functionality_id, criterion) SELECT id, 'The gh CLI is detected on PATH and all gh auth, pr, and repo commands succeed without additional configuration' FROM functionalities WHERE feature_name = 'GitHub CLI integration';

-- AC for Agent Configurations & Profiles
INSERT INTO acceptance_criteria (functionality_id, criterion) SELECT id, 'A saved agent profile with custom env vars, MCP servers, and agent-specific options can be applied to a workspace and the agent respects those settings' FROM functionalities WHERE feature_name = 'Reusable agent profiles';
INSERT INTO acceptance_criteria (functionality_id, criterion) SELECT id, 'Switching between Claude Code, Gemini CLI, Codex, and OpenCode in the same workspace correctly changes the active agent binary and prompt template' FROM functionalities WHERE feature_name = 'Reusable agent profiles';

-- AC for Cloud Collaboration
INSERT INTO acceptance_criteria (functionality_id, criterion) SELECT id, 'Two users signed into the cloud can see each other's real-time cursor movements and card edits within 500ms' FROM functionalities WHERE feature_name = 'Real-time sync via ElectricSQL + Postgres';
INSERT INTO acceptance_criteria (functionality_id, criterion) SELECT id, 'Inviting a new member by email sends an invitation link that, when accepted, grants the correct role-based access' FROM functionalities WHERE feature_name = 'Invite members';
INSERT INTO acceptance_criteria (functionality_id, criterion) SELECT id, 'Transferring ownership to another Admin correctly revokes owner privileges from the previous owner and grants them to the new one' FROM functionalities WHERE feature_name = 'Transfer ownership';

-- AC for Desktop Application
INSERT INTO acceptance_criteria (functionality_id, criterion) SELECT id, 'The Tauri app launches from the system app launcher and the system tray icon appears with a functional context menu' FROM functionalities WHERE feature_name = 'System tray icon';
INSERT INTO acceptance_criteria (functionality_id, criterion) SELECT id, 'Closing the main window minimizes the app to the tray (if tray is enabled) and it can be restored from the tray icon' FROM functionalities WHERE feature_name = 'Native OS integration';
INSERT INTO acceptance_criteria (functionality_id, criterion) SELECT id, 'With network disabled, all local workspace operations (create, edit, move cards, run agents) work without errors; sync errors appear when reconnected' FROM functionalities WHERE feature_name = 'Offline support';

-- AC for Self-Hosting / Docker
INSERT INTO acceptance_criteria (functionality_id, criterion) SELECT id, 'docker compose up starts all services (app, postgres, electricsql) and the app is accessible at the configured HTTP port' FROM functionalities WHERE feature_name = 'Docker Compose deployment';
INSERT INTO acceptance_criteria (functionality_id, criterion) SELECT id, 'Replacing the docker-compose.yml with a production nginx site config and reloading nginx successfully serves the app over HTTPS' FROM functionalities WHERE feature_name = 'nginx reverse proxy config';

-- AC for Relay & Tunneling
INSERT INTO acceptance_criteria (functionality_id, criterion) SELECT id, 'Enabling tunnel mode generates a public URL that is accessible from a different network and renders the app correctly' FROM functionalities WHERE feature_name = 'Tunnel mode';
INSERT INTO acceptance_criteria (functionality_id, criterion) SELECT id, 'A WebRTC P2P connection between two browsers shows sub-200ms latency for basic interactions' FROM functionalities WHERE feature_name = 'WebRTC peer-to-peer connection';

-- AC for CLI
INSERT INTO acceptance_criteria (functionality_id, criterion) SELECT id, 'npx vibe-kanban starts the application on an auto-assigned port when the default port is already in use' FROM functionalities WHERE feature_name = 'Auto-assign available ports';
INSERT INTO acceptance_criteria (functionality_id, criterion) SELECT id, 'The CLI flag --db-url correctly overrides the database connection string' FROM functionalities WHERE feature_name = 'CLI config flag support';

-- AC for MCP Servers
INSERT INTO acceptance_criteria (functionality_id, criterion) SELECT id, 'Installing a popular MCP server (e.g., GitHub MCP) from the one-click UI successfully connects and the server appears in the agent tools list' FROM functionalities WHERE feature_name = 'One-click popular server installation';
INSERT INTO acceptance_criteria (functionality_id, criterion) SELECT id, 'Attaching a custom MCP server via JSON config makes its tools available to the agent without restart' FROM functionalities WHERE feature_name = 'Custom MCP server JSON config';
