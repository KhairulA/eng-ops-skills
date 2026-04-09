# PII & Secret Guard (Instructional)

This horizontal layer defines the **Hardened Privacy Policy** that all EngOps agents must follow before interacting with any vertical skill (Outline, Jira, GitHub).

## Mandatory Scrubbing Rules

Before any text is submitted to a tool or saved to a documentation base, the agent must check for and mask the following:

### 1. Credentials & Secrets
- **Pattern**: `[A-Za-z0-9_-]{20,}` following words like `key`, `password`, `secret`, `token`.
- **Action**: Replace with `[SECRET_MASKED]`.

### 2. Personal Identifiable Information (PII)
- **Emails**: Replace with `[USER_EMAIL]`.
- **Phone Numbers**: Replace with `[PHONE_MASKED]`.
- **IP Addresses**: Replace with `[IP_MASKED]` (especially helpful when processing SRE/Log data).

### 3. Internal System Paths (Optional)
- **Pattern**: Absolute paths like `/Users/person/...` or AWS ARNs.
- **Action**: Replace with `[SYSTEM_PATH]`.

## Implementation for Agents
When configured as a Paperclip skill, this file provides the **Constraints** for any tool invocation.

```json
{
  "skill": "pii-guard",
  "instructions": "Before calling any tool that saves data (e.g., documents.create, issues.comment), ensure the input content has been scrubbed of secrets and PII according to core/security standards."
}
```

## Policy Strictly Levels

- **Level RED (Enterprise Private)**: Mask everything including names of external partners.
- **Level YELLOW (Default)**: Mask secrets, emails, IPs, and passwords.
- **Level GREEN (Internal Development)**: Mask only absolute secrets (API Keys).

---

*Securing the Engineering Operations pipeline.*
