import streamlit as st

from security_core import (
    call_llm,
    filter_prompt,
    is_allowed,
    load_environment,
    load_rbac,
)

load_environment()
RBAC = load_rbac()
USERS = sorted(RBAC.get("users", {}).keys()) or ["viewer_vic"]
DEFAULT_USER = USERS[0] if USERS else "viewer_vic"
ALL_ACTIONS = sorted({action for roles in RBAC.get("users", {}).values() for action in roles} | {"query", "summarize", "admin"})

st.set_page_config(page_title="AI Security Lab Assistant", page_icon="shield")
st.title("AI Security Lab Assistant")
st.caption("RBAC-gated, prompt-filtered Streamlit front-end for the secure LLM demo.")

with st.sidebar:
    st.header("Session")
    selected_user = st.selectbox("Select user", USERS, index=USERS.index(DEFAULT_USER))
    selected_action = st.selectbox("Choose action", ALL_ACTIONS, index=ALL_ACTIONS.index("query"))

prompt = st.text_area("Your prompt", height=160, placeholder="Ask something security-related...")

if st.button("Send to LLM", use_container_width=True):
    if not prompt.strip():
        st.warning("Enter a prompt before sending.")
    elif not is_allowed(selected_user, selected_action, RBAC):
        st.error(f"RBAC: user '{selected_user}' is not allowed to perform '{selected_action}'.")
    else:
        allowed, sanitized, reason = filter_prompt(prompt)
        if not allowed:
            st.error("Prompt blocked by guardrails.")
            st.code(reason)
        else:
            st.info(f"Sanitized prompt: {sanitized}")
            final_prompt = sanitized
            if selected_action == "summarize":
                final_prompt = f"Summarize concisely (1-2 sentences): {sanitized}"

            with st.spinner("Querying LLM..."):
                response = call_llm(final_prompt)

            if response.startswith("[LLM error]"):
                st.error(response)
            else:
                st.success("Response received")
                st.markdown(response)
else:
    st.write("Fill in a prompt and press **Send to LLM** to test the guardrails.")
