# AI Security Mini Threat Model

This Streamlit and command-line interface (CLI) laboratory integrates a large language model (LLM) while enforcing three primary security guardrails:
* Role-based access control (RBAC) restricts each action based on user permissions.
* A prompt filter rejects attempts to bypass established rules and prevents data exfiltration.
* Secrets, including API keys and passwords, are managed using a `.env` file to ensure sensitive values are not exposed in the repository.

## Flow
`User` → `Application` (RBAC verification) → `Prompt filter` → `LLM API` → `Response`

## Key risks and controls
| Risk | Control | Notes | NIST AI RMF |
| --- | --- | --- | --- |
| Prompt injection | Pattern checks plus prompt sanitizing with a lean system message | First line of defense | Map and Measure A.1, B.2 |
| Data exposure | System prompt did not echo and requests to reveal it are refused | Policy enforced in code | Manage C.2 |
| Over broad access | RBAC policy in `rbac.json` | Keeps actions least privilege | Govern G.1 |
| Secret exposure | `.env` with gitignore rules | Rotate keys, never commit secrets | Manage C.3 |
| Abuse of tools | Action list limited to query, summarize, admin | No tool execution or shell passthrough | Map and Manage A.2, C.1 |

## Validation ideas
* Implement unit tests for the `filter_prompt`.
* Evaluate the filter using adversarial (red team) prompts to refine detection patterns.
* Log both allowed and blocked prompts for filter tuning, ensuring no personal data is stored.
* Conduct smoke tests on the Streamlit workflow to validate RBAC functionality and ensure comprehensive scenario coverage.

## Roadmap
* Integrate retrieval mechanisms or context windows as additional guardrails are implemented.
*  Introduce tool calls governed by an allow list and enforce strict data schemas for each operation.
* Integrate policy engines, such as Open Policy Agent (OPA), to automate RBAC decision-making.
