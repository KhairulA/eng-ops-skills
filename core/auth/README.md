# Enterprise Authentication Patterns

Handling credentials securely is the biggest barrier to deploying AI agents in the enterprise. The EngOps Suite follows these horizontal auth standards.

## 1. Environment Variable Injection
The primary method for local or short-lived agents.
- **Rules**: Never hardcode. Use `.env` files (git-ignored) or direct shell exports.
- **Prefixing**: Use vertical-specific prefixes to avoid collisions: `OUTLINE_XXX`, `JIRA_XXX`, `GITHUB_XXX`.

## 2. Secret Management (Paperclip & CI/CD)
When deploying in a platform like Paperclip:
- Use the **Platform Secrets Manager**.
- Avoid passing raw tokens in function calls if the platform supports "Secure Environment Injection."

## 3. Least Privilege (Scoping)
Every EngOps skill should define its **Minimum Scopes**:

| Skill | Recommended Scopes | Reason |
| :--- | :--- | :--- |
| **Outline** | Read/Write (limited to collections) | Managing docs. |
| **Jira** | `read:jira-work`, `write:jira-work` | Modifying statuses. |
| **GitHub** | `repo:status`, `public_repo` | Auditing PRs. Avoid `admin`. |

## 4. IP Allowlisting
For high-trust environments, ensure your agent infrastructure (where it runs) is allowlisted in the target tool's administration panel.

## 5. Token Rotation
We recommend using **Rotate-Every-30-Days** policies for PATs. 

---

*Securing the keys to the kingdom.*
