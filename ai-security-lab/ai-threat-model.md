# AI Security Mini Threat Model (NIST AI RMF Mapping)

**Context:** Tiny CLI app that calls an LLM and adds guardrails:
- RBAC for allowed actions (`query`, `summarize`, `admin`)
- Prompt-injection filter (deny "ignore previous instructions", exfiltration, tool abuse)
- Secrets via `.env` (no keys in code/repo)

## System Diagram (logical)
User -> CLI (RBAC check) -> Prompt Filter -> LLM API -> Response

## Key Risks & Controls
| Risk | Control | Notes | NIST AI RMF |
|------|---------|-------|-------------|
| Prompt injection | Pattern blacklist + sanitization; minimal system prompt | Basic first line of defense | **Map/Measure:** A.1, B.2 |
| Data exfil / prompt leaks | Never echo system; refuse “reveal system prompt” | Policy enforced in system msg | **Manage:** C.2 |
| Overbroad access | RBAC via `rbac.json` | Least-privilege actions | **Govern:** G.1 |
| Secret exposure | `.env`, gitignore key files | Rotate keys, no commits | **Manage:** C.3 |
| Abuse / misuse | Action constraints (`summarize/query`) | No tool execution | **Map/Manage:** A.2, C.1 |

## Validation Ideas
- Unit tests for `filter_prompt` patterns.
- Red/purple-team prompts to improve denylist.
- Log allowed/blocked prompts for tuning (no PII).

## Roadmap
- Add context windows with retrieval; add allowlist-based DSL for tools.
- Model-specific safety (JSON schema outputs, function calling with hard constraints).
- Add policy-as-code (Open Policy Agent) for RBAC decisions.

