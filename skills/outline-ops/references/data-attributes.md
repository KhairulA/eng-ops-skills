# Outline Ops Custom Data Attributes

Custom data attributes allow you to store structured metadata on documents. This is essential for Paperclip AI agents to track status, ownership, and other business-specific fields.

## Supported Data Types

| Type | Description | Values |
| :--- | :--- | :--- |
| `string` | Free text field | Any string |
| `number` | Numeric values | Integers or decimals |
| `boolean`| Checkbox | `true` or `false` |
| `list` | Single-select dropdown | Must match one of the defined `options` |

## The `list` Type and Options
When creating a `list` attribute, you must provide an `options` array:
```json
{
  "name": "Status",
  "dataType": "list",
  "options": [
    { "label": "Draft", "value": "draft", "color": "#999999" },
    { "label": "In Review", "value": "in-review", "color": "#FFCC00" },
    { "label": "Published", "value": "published", "color": "#00CC00" }
  ]
}
```

## Assigning Attributes to Documents
Attributes are assigned during `documents.create` or `documents.update` using the `dataAttributes` property:

```json
{
  "id": "doc-uuid",
  "dataAttributes": [
    {
      "dataAttributeId": "attr-uuid-for-status",
      "value": "published"
    },
    {
      "dataAttributeId": "attr-uuid-for-owner",
      "value": "Agent Zero"
    }
  ]
}
```

## Recommended Workflow for Agents
1. **List existing attributes**: Call `dataAttributes.list` to find the UUIDs for standard fields (e.g., "Status").
2. **Handle missing attributes**: If a required attribute (like "AI-Verified") doesn't exist, call `dataAttributes.create` to set it up for the workspace.
3. **Keep it Consistent**: Always check the `options` of a `list` attribute before assigning a value to avoid "Invalid value" errors.

---

See [api-methods.md](./api-methods.md) for the full API specification.
