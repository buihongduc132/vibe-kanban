See the way we are launching the executor. 

We are going to make another launcher but not with the worktree but in the configured project directory by itself. 

Ensure this implementation IS complete separate with the main functionalities of the VK. This can later on be use as a stand alone service as well , but also make the api of it to be compatible with the current VK. 

All the BELOW launcher should only focus on the opencode for now . for the rest just make the no-op with warning for them . 

# GOAL
Currently each of the task is launch in it separate worktree . 
UI , use the same current UI stack. 

Server / test: make another server different than the main worktree port. Then test the functionalities itself

## Executor launcher 
This feature will enable the launch inside the main project directory itself . Check if the making pr to see if it compatible with the pr and other functionalities stuff. For all the compatible , then wired it in as well . If not then leave out and make comment on how it is incompatible . 

## Serve / server mode launcher
Currently for example: `opencode` will be execute as `opencode ... run` when launch the task. 
1. Now we are making another kind of launcher that is to just run the `opencode server --host <input> --port <input>`. Also make the that to be able to replace the parameter using templating. By default  it  will  take into the port (host will be localhost). 
2. Make the manager daemon. 
IF 1 directory is already have this kind of launcher then we are NOT launching another one but just give the user the current running one. 

## Project auto discovery
See if we can get the utils from the origin implementation to   make the project / directory discovery as well. We will config the main part for the discovery. Then for ALL the repository in there that having update during last 14 days will auto get populate and shows on the UI for the user to choose the project WITHOUT having to 
type in the path themself ( though they can add it if they want). 

{{DO NOT update anything ABOVE this line. this is for the strict requirement. All the BELOW plan must be 100% covered the ABOVE plan}}

---

## Expanded scope, design notes, and scenarios

### Executor launcher (project-dir, non-worktree)
- Objective: add a launcher that runs tasks inside the configured project directory (no worktree clone), isolated from the existing VK worktree flow. Keep API-compatible where possible (process tracking, approvals, PR hooks) but guard incompatibilities with explicit warnings/no-ops.
- Target agent: opencode first; all other agents should return a no-op + warning stating that project-dir execution is unsupported.
- Inputs: project root path, task metadata (id, branch optional), profile/agent selection (opencode), optional env overrides, dev script hook.
- Behavior: reuse existing executor lifecycle (spawn, follow-up, approvals, MCP), but resolve working directory to the configured project root. If PR context is provided and compatible (branch available, git repo clean), wire in branch/PR metadata; otherwise, emit compatibility warning and skip PR integration.
- Error handling: validate path exists + is git repo; fail fast on missing executable; provide structured reasons for incompatibility (dirty working tree, detached HEAD, missing remote, missing PR number).
- Observability: log execution path, agent, branch/PR info, reuse existing MsgStore normalization where possible; tag processes with new executor type.
- Security/guardrails: forbid writing outside project root; reuse approvals flow; respect allowlist/denylist for env vars.
- Edge cases: missing .git, repo without remote, sparse checkouts, submodules, long-running tasks requiring cleanup, concurrent launches for same repo (should be serialized or rejected).

### Serve / server mode launcher (opencode server --host --port)
- Objective: allow launching opencode in server mode (`opencode server --host <host> --port <port>`), with templated host/port defaults (localhost + allocated port) and substitution support.
- Manager daemon: keep a per-directory registry; if a server is already running for a directory, return existing details instead of launching a new one. Track pid/port, health, and last-seen timestamp.
- Behavior: start server, poll for readiness, emit URL to UI; allow templating of args (e.g., `${port}`) and default port allocation via existing port-file utility.
- Compatibility: only opencode initially; other agents return no-op + warning. Expose compatibility status to UI; map to process entries for visibility/termination.
- Edge cases: port in use, crash-loop, stale pidfile/portfile, missing binary, conflicting user-supplied host/port, cleanup on shutdown, reuse after restart.

### Project auto discovery (recent repos)
- Objective: surface recent git repos (last 14 days) from configured roots and common dev dirs, populating UI for quick selection while allowing manual entry.
- Inputs: optional base path; otherwise scan home + common folders (repos/dev/work/code/projects + cwd) using existing filesystem service. Honor max-depth and skip-lists.
- Behavior: gather git repos, compute last-modified age, filter to <=14 days (configurable), sort by recency, cache results with timeout to avoid heavy rescans. Non-git dirs are ignored. Provide structured responses for UI.
- Edge cases: large trees (timeouts), network filesystems, permission errors, missing metadata, daylight savings/clock skew, empty results.

### API/UI and compatibility notes
- UI: reuse current UI stack; add process types for project-dir launcher and server-mode launcher; show compatibility warnings and reuse existing project picker flow with auto-discovered repos.
- API: expose new endpoints for project-dir execution, server-mode lifecycle (start/stop/status), and repo discovery; keep backward-compatible response envelopes. Document no-op responses for unsupported agents.
- Testing: unit tests for path validation, templating, registry reuse, discovery filtering; integration tests for spawn and server-mode lifecycle on alt port; UI checks for population + warning states.
- Non-goals: changing main worktree launcher semantics; supporting non-opencode server-mode in this phase.
