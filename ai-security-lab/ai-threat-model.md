# AI Security Mini Threat Model

This Streamlit and CLI lab calls an LLM while enforcing three core guardrails:
* Role based access control gating each action.
* Prompt filter that rejects ignore the rules attacks and exfiltration attempts.
* Secrets managed through `.env` so keys never sit in the repo.

## Flow
`User` → `App` (RBAC check) → `Prompt filter` → `LLM API` → `Response`

## Key risks and controls
| Risk | Control | Notes | NIST AI RMF |
| --- | --- | --- | --- |
| Prompt injection | Pattern checks plus prompt sanitizing with a lean system message | First line of defense | Map and Measure A.1, B.2 |
| Data exposure | System prompt never echoed and requests to reveal it are refused | Policy enforced in code | Manage C.2 |
| Over broad access | RBAC policy in `rbac.json` | Keeps actions least privilege | Govern G.1 |
| Secret exposure | `.env` with gitignore rules | Rotate keys, never commit secrets | Manage C.3 |
| Abuse of tools | Action list limited to query, summarize, admin | No tool execution or shell passthrough | Map and Manage A.2, C.1 |

## Validation ideas
* Add unit tests for `filter_prompt`.
* Throw red team prompts at the filter to refine patterns.
* Log allowed and blocked prompts for tuning without storing personal data.
* Smoke test the Streamlit flow to confirm RBAC and filtering both fire.

## Roadmap
* Layer in retrieval or context windows once guardrails expand.
* Introduce allow list driven tool calls with strict schemas.
* Bring in policy engines such as OPA for RBAC decisions.
