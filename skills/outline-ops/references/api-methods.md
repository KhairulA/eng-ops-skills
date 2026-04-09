# Outline Ops API Methods

Complete reference for the RPC-style Outline API used by this skill. All methods are `POST` requests to `https://app.getoutline.com/api/:method`.

## Authentication
Use Bearer token in the `Authorization` header:
```http
Authorization: Bearer YOUR_API_TOKEN
Content-Type: application/json
```

## Documents

### `documents.search`
Search workspace documents with keywords.

| Parameter | Type | Required | Description |
| :--- | :--- | :--- | :--- |
| `query` | string | Yes | The search terms. |
| `collectionId` | string | No | Filter by collection UUID. |
| `documentId` | string | No | Filter by parent document UUID. |
| `statusFilter` | string | No | `draft`, `archived`, or `published`. |
| `dateFilter` | string | No | `day`, `week`, `month`, `year`. |
| `sort` | string | No | `relevance`, `createdAt`, `updatedAt`, `title`. |
| `limit` | integer | No | Default 15. |
| `offset` | integer | No | Default 0. |

### `documents.list`
List published and draft documents.

| Parameter | Type | Required | Description |
| :--- | :--- | :--- | :--- |
| `collectionId` | string | No | Filter by collection UUID. |
| `parentDocumentId`| string | No | Filter by parent document UUID. |
| `statusFilter` | string | No | `draft`, `archived`, or `published`. |
| `sort` | string | No | `createdAt`, `updatedAt`, `title`. |
| `limit` | integer | No | Default 25. |

### `documents.info`
Retrieve a single document by ID.

| Parameter | Type | Required | Description |
| :--- | :--- | :--- | :--- |
| `id` | string | Yes | Document UUID or `urlId`. |

### `documents.create`
Create a new document.

| Parameter | Type | Required | Description |
| :--- | :--- | :--- | :--- |
| `title` | string | Yes | Document title. |
| `text` | string | No | Markdown content. |
| `collectionId` | string | Yes | Target collection UUID. |
| `parentDocumentId`| string | No | Nest under another document. |
| `publish` | boolean | No | Default false. |
| `icon` | string | No | Emoji or icon name (e.g., `🎉`, `Book`). |
| `color` | string | No | Hex color code (e.g., `#FF0000`). |

### `documents.update`
Modify an existing document.

| Parameter | Type | Required | Description |
| :--- | :--- | :--- | :--- |
| `id` | string | Yes | Document UUID. |
| `title` | string | No | New title. |
| `text` | string | No | New Markdown content. |
| `editMode` | string | No | `append`, `prepend`, or `replace` (default). |

### `documents.delete`
Move document to trash or delete permanently.

| Parameter | Type | Required | Description |
| :--- | :--- | :--- | :--- |
| `id` | string | Yes | Document UUID. |
| `permanent` | boolean | No | Default false (move to trash/archive). |

## Collections

### `collections.list`
List all accessible collections.

| Parameter | Type | Required | Description |
| :--- | :--- | :--- | :--- |
| `sort` | string | No | `name`, `createdAt`, `updatedAt`. |
| `limit` | integer | No | Default 25. |

### `collections.info`
Retrieve collection details.

| Parameter | Type | Required | Description |
| :--- | :--- | :--- | :--- |
| `id` | string | Yes | Collection UUID. |

### `collections.create`
Create a new organization folder.

| Parameter | Type | Required | Description |
| :--- | :--- | :--- | :--- |
| `name` | string | Yes | Collection name. |
| `description` | string | No | Markdown description. |
| `icon` | string | No | Icon name or emoji. |
| `color` | string | No | Hex color code. |

## Comments

### `comments.create`
Add a comment or reply to a document.

| Parameter | Type | Required | Description |
| :--- | :--- | :--- | :--- |
| `documentId` | string | Yes | Target document UUID. |
| `text` | string | Yes | Markdown content. |
| `parentCommentId`| string | No | Reply to an existing comment. |

## Data Attributes

### `dataAttributes.list`
List all custom data attributes.

| Parameter | Type | Required | Description |
| :--- | :--- | :--- | :--- |
| `limit` | integer | No | Default 50. |

### `dataAttributes.create`
Define a new custom data attribute.

| Parameter | Type | Required | Description |
| :--- | :--- | :--- | :--- |
| `name` | string | Yes | Attribute name. |
| `dataType` | string | Yes | `string`, `number`, `boolean`, `list`. |
| `description` | string | No | Attribute description. |
| `options` | array | No | Only for `list` type. Array of `{ label, value, color }`. |
| `pinned` | boolean | No | Default false. |

---

For and in-depth guide, see [SKILL.md](../SKILL.md).
