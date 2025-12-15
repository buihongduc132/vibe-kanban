# Goal: System Resilience and State Management

Harden the resilience of the VK system by addressing server restart recovery, process crash handling, and state management.

## Merge Strategy
1. Implement **Part A** (base system) in parallel with `cwd-executor` branch
2. Merge **Part A** to `main`
3. Merge `cwd-executor` to `main`
4. Implement and merge **Part B** (CWD-specific resilience)

---

{{DO NOT update anything ABOVE this line. this is for the strict requirement. All the BELOW plan must be 100% covered the ABOVE plan}}

---

# Part A: Base System Resilience (without CWD executor)

## A1. Server Restart Recovery

### Problem
- In-memory state (`msg_stores`, `child_store`, `interrupt_senders`) is lost on restart
- Running `ExecutionProcess` records remain `Running` in DB after crash
- Worktrees may be orphaned without proper cleanup tracking

### Current Mitigations
- `cleanup_orphan_executions()` marks orphan processes as `Failed` on startup
- `check_externally_deleted_worktrees()` syncs filesystem state to DB
- `backfill_before_head_commits()` recovers missing commit OIDs

### Tasks
| ID | Task | Priority |
|----|------|----------|
| A1.1 | Add startup banner logging (version, startup time, recovered state count) | Low |
| A1.2 | Enhance `cleanup_orphan_executions` to emit structured recovery report | Medium |
| A1.3 | Persist `ServerManager` state to SQLite (for opencode server instances) | Medium |
| A1.4 | Add healthcheck endpoint `/health` returning DB connectivity and process count | High |

---

## A2. Process Crash Handling

### Problem
- Child processes may crash without exit notification (OOM, SIGKILL)
- `spawn_exit_monitor` relies on process exit; zombie processes may linger
- MsgStore is in-memory; crash before DB flush loses logs

### Current Mitigations
- `spawn_exit_monitor` task updates DB on process exit
- `spawn_stream_raw_logs_to_db` persists logs incrementally to `ExecutionProcessLogs`

### Tasks
| ID | Task | Priority |
|----|------|----------|
| A2.1 | Add periodic liveness check for tracked child processes (every 30s) | High |
| A2.2 | Implement watchdog to detect stuck processes (no stdout for N minutes) | Medium |
| A2.3 | Add graceful shutdown handler (SIGTERM) to kill tracked children | High |
| A2.4 | Flush MsgStore to DB on graceful shutdown | Medium |

---

## A3. State Management

### Problem
- `msg_stores` HashMap is ephemeral; history lost on restart
- `child_store` has no persistence; process references lost
- Config changes during runtime not persisted immediately

### Current Mitigations
- Logs persisted via `spawn_stream_raw_logs_to_db`
- Config persisted on explicit save

### Tasks
| ID | Task | Priority |
|----|------|----------|
| A3.1 | Document state recovery flow in ARCHITECTURE.md | Low |
| A3.2 | Add `last_heartbeat` column to `execution_process` for liveness tracking | Medium |
| A3.3 | Implement periodic heartbeat update for running processes | Medium |
| A3.4 | Add DB transaction for atomic process + log creation | Low |

---

# Part B: CWD Executor Resilience

## B1. CWD-Specific Restart Recovery

### Problem
- `ServerManager` for CWD servers is in-memory only
- CWD execution has no worktree to recover; relies on actual repo state
- No tracking of "concurrent vs block" execution mode state

### Tasks
| ID | Task | Priority |
|----|------|----------|
| B1.1 | Persist `ServerInfo` to `cwd_servers` table (path, pid, port, started_at) | High |
| B1.2 | On startup, validate persisted servers (check pid liveness); clean stale | High |
| B1.3 | Add `execution_mode` column to `task_attempt` (normal, cwd_concurrent, cwd_block) | Medium |
| B1.4 | Recover in-flight CWD tasks: check process liveness, update status | Medium |

---

## B2. CWD Process Crash Handling

### Problem
- CWD execution operates on live repo; crash may leave dirty state
- No rollback mechanism (unlike worktree which can be deleted)
- Opencode server may leave port bound if killed uncleanly

### Tasks
| ID | Task | Priority |
|----|------|----------|
| B2.1 | On CWD process crash, emit warning about potential dirty state | Medium |
| B2.2 | Implement port release check after server crash (retry bind after N seconds) | Medium |
| B2.3 | Add `stash_on_start` option for CWD mode (stash uncommitted changes) | Low |
| B2.4 | Log repo status (branch, dirty files) on CWD execution start | High |

---

## B3. CWD State Management

### Problem
- Concurrent CWD executions may conflict
- Block mode needs persistent lock across restarts
- No visibility into CWD execution history vs worktree history

### Tasks
| ID | Task | Priority |
|----|------|----------|
| B3.1 | Add `cwd_lock` table (path, lock_holder_attempt_id, acquired_at) | High |
| B3.2 | Check lock on CWD start; respect block mode | High |
| B3.3 | Release lock on completion/crash (use heartbeat timeout for zombies) | High |
| B3.4 | Add `is_cwd_execution` flag to `task_attempt` for filtering/reporting | Medium |

---

## Implementation Order

### Phase 1 (Part A - Critical)
1. A2.3 - Graceful shutdown handler
2. A2.1 - Periodic liveness check
3. A1.4 - Healthcheck endpoint

### Phase 2 (Part A - Medium)
4. A3.2 - last_heartbeat column
5. A3.3 - Periodic heartbeat
6. A1.3 - Persist ServerManager

### Phase 3 (Part B - Critical)
7. B1.1 - Persist CWD ServerInfo
8. B1.2 - Startup validation
9. B3.1 - cwd_lock table
10. B3.2 - Lock enforcement

### Phase 4 (Part B - Medium)
11. B2.4 - Log repo status
12. B1.3 - execution_mode column
13. B3.4 - is_cwd_execution flag
