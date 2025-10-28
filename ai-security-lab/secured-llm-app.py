"""
Tiny secure LLM demo:
- RBAC gate on allowed actions
- simple prompt-injection filter
- env-based secrets (dotenv)
- swappable provider (OpenAI by default)

Run:
  cd ai-security-lab
  python -m venv .venv && .\.venv\Scripts\activate
  pip install -r requirements.txt
  copy .env.example .env  # then edit your key
  python secured-llm-app.py --user analyst_alice --action query --prompt "Summarize Zero Trust in one line."
"""

import argparse
import os
import sys

from security_core import (
    call_llm,
    filter_prompt,
    is_allowed,
    load_environment,
    load_rbac,
)


def main() -> None:
    load_environment()

    parser = argparse.ArgumentParser(description="Secure LLM demo with RBAC + prompt filter")
    parser.add_argument("--user", required=False, default=os.getenv("APP_USER", "viewer_vic"))
    parser.add_argument("--action", required=True, choices=["query", "summarize", "admin"])
    parser.add_argument("--prompt", required=True)
    args = parser.parse_args()

    rbac = load_rbac()
    if not is_allowed(args.user, args.action, rbac):
        print(f"[RBAC] User '{args.user}' is not allowed to perform action '{args.action}'.")
        sys.exit(1)

    allowed, sanitized, reason = filter_prompt(args.prompt)
    if not allowed:
        print(f"[FILTER] Prompt blocked: {reason}")
        sys.exit(2)

    if args.action == "summarize":
        sanitized = f"Summarize concisely (1-2 sentences): {sanitized}"

    print("[OK] Prompt passed filters. Querying LLM...")
    print()
    print(call_llm(sanitized))


if __name__ == "__main__":
    main()
