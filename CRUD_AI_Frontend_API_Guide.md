# CRUD AI – Frontend API Integration Guide

**Base URL:** `http://localhost:8000`  
**Swagger documentation:** `http://localhost:8000/docs`

This guide is based on the uploaded OpenAPI specification. It explains which inputs the frontend must send, which values should be retained, and how those values are reused by later endpoints.

> **Important:** The OpenAPI specification does not define the successful response schemas for most endpoints. Response examples below are illustrative where explicitly stated; confirm the actual backend response before relying on response property names.

## 1. Expected workflow

```text
Upload PDF to MinIO
       |
       v
List or retrieve the stored PDF
       |
       v
Upload PDF to Stirling
       |
       v
Save the returned file_id
       |
       +----------------------+
       |                      |
       v                      v
Send question to AI       Download from Stirling
Agent                     (processed PDF)
```

The frontend should retain the selected document's `user_id`, `file_name`, and—once supplied by the backend—`file_id`.

## 2. Upload a PDF to MinIO

**Endpoint:** `POST /api/v1/minio/putobject`

**Purpose:** Upload a PDF file to MinIO.

### Inputs

| Name | Location | Type | Required |
|---|---|---|---|
| `user_id` | Query parameter | String | Yes |
| `file` | Multipart form-data | File | Yes |

### Example request

```http
POST /api/v1/minio/putobject?user_id=yamyam
Content-Type: multipart/form-data
```

```javascript
const formData = new FormData();
formData.append("file", selectedFile);

const response = await fetch(
  `${BASE_URL}/api/v1/minio/putobject?user_id=${encodeURIComponent(userId)}`,
  {
    method: "POST",
    body: formData
  }
);

if (!response.ok) {
  throw new Error(await response.text());
}

const result = await response.json();
```

### Retain for later

Keep:
- `user_id`
- The uploaded file's name (`selectedFile.name`)

The OpenAPI specification does not define the successful response body, so it does not establish any response field that the frontend should save from this call.

## 3. List a user's MinIO files

**Endpoint:** `GET /api/v1/minio/getlistobject`

**Purpose:** Get the list of stored objects for a user.

### Inputs

| Name | Location | Type | Required |
|---|---|---|---|
| `user_id` | Query parameter | String | Yes |

### Example

```javascript
const response = await fetch(
  `${BASE_URL}/api/v1/minio/getlistobject?user_id=${encodeURIComponent(userId)}`
);

if (!response.ok) {
  throw new Error(await response.text());
}

const files = await response.json();
```

The OpenAPI response is described as an array, but its item properties are not specified. Confirm the actual object shape before using fields such as `file_name` or `object_name`.

### Retain for later

When the user selects a file, retain its exact filename/object name and the associated `user_id`.

## 4. Retrieve a PDF from MinIO

**Endpoint:** `GET /api/v1/minio/getobject`

**Purpose:** Retrieve an object using the user ID and filename.

### Inputs

| Name | Location | Type | Required |
|---|---|---|---|
| `user_id` | Query parameter | String | Yes |
| `file_name` | Query parameter | String | Yes |

### Example

```javascript
const params = new URLSearchParams({
  user_id: userId,
  file_name: fileName
});

const response = await fetch(
  `${BASE_URL}/api/v1/minio/getobject?${params}`
);

if (!response.ok) {
  throw new Error(await response.text());
}

// Use the parser that matches the actual backend response.
// JSON example:
const result = await response.json();
```

The OpenAPI specification describes the response as an array but does not define its item structure or confirm whether the route returns PDF bytes, metadata, or another representation. Check the actual response `Content-Type` and backend implementation before choosing `response.json()` or `response.blob()`.

### Retain for later

Keep `user_id` and the exact `file_name`.

## 5. Delete a PDF from MinIO

**Endpoint:** `DELETE /api/v1/minio/deleteobject`

**Purpose:** Delete a stored object.

### Input body

```json
{
  "user_id": "yamyam",
  "object_name": "report.pdf"
}
```

Both fields are required.

### Example

```javascript
const response = await fetch(
  `${BASE_URL}/api/v1/minio/deleteobject`,
  {
    method: "DELETE",
    headers: {
      "Content-Type": "application/json"
    },
    body: JSON.stringify({
      user_id: userId,
      object_name: objectName
    })
  }
);

if (!response.ok) {
  throw new Error(await response.text());
}

const result = await response.json();
```

After successful deletion, remove the object from the frontend's displayed file list. The OpenAPI specification does not define a response body schema.

## 6. Upload a PDF to Stirling

**Endpoint:** `POST /api/v1/stirling/upload`

**Purpose:** Upload a PDF to the backend's Stirling integration.

### Inputs

| Name | Location | Type | Required |
|---|---|---|---|
| `user_id` | Query parameter | String | Yes |
| `file_name` | Query parameter | String | Yes |

### Example

```javascript
const params = new URLSearchParams({
  user_id: userId,
  file_name: fileName
});

const response = await fetch(
  `${BASE_URL}/api/v1/stirling/upload?${params}`,
  { method: "POST" }
);

if (!response.ok) {
  throw new Error(await response.text());
}

const result = await response.json();
```

**Request-contract note:** The uploaded OpenAPI document lists these query parameters and does not define a request body for this route. Confirm with the backend developer how the PDF content is obtained (for example, whether the backend reads the file from MinIO).

### Important: `file_id`

The later Stirling download endpoint and AI Agent endpoint both require `file_id`. However, the OpenAPI document does not define the Stirling upload response schema or confirm which response property contains this identifier.

If the backend confirms that the response is:

```json
{
  "file_id": "example-file-id"
}
```

then the frontend can save it as:

```javascript
const fileId = result.file_id;
```

This is an illustrative example only. Use the actual property name returned by the backend. Do not generate a `file_id` in the frontend.

## 7. Download a PDF from Stirling

**Endpoint:** `GET /api/v1/stirling/download`

**Purpose:** Download a file using its user ID, filename, and Stirling file ID.

### Inputs

| Name | Location | Type | Required |
|---|---|---|---|
| `user_id` | Query parameter | String | Yes |
| `file_name` | Query parameter | String | Yes |
| `file_id` | Query parameter | String | Yes |

### Example

```javascript
const params = new URLSearchParams({
  user_id: userId,
  file_name: fileName,
  file_id: fileId
});

const response = await fetch(
  `${BASE_URL}/api/v1/stirling/download?${params}`
);

if (!response.ok) {
  throw new Error(await response.text());
}

// Use this if the backend returns PDF binary data.
const pdfBlob = await response.blob();

const downloadUrl = URL.createObjectURL(pdfBlob);
const link = document.createElement("a");
link.href = downloadUrl;
link.download = fileName;
link.click();
URL.revokeObjectURL(downloadUrl);
```

The OpenAPI document does not specify the response media type. Confirm that the backend returns PDF bytes before using `response.blob()` as shown.

## 8. Send a question to the AI Agent

**Endpoint:** `POST /api/v1/agent/respones`

**Purpose:** Send a user question together with the user ID and file ID.

### Required JSON body

| Name | Type | Required | Meaning |
|---|---|---|---|
| `user_id` | String | Yes | User associated with the request |
| `input_text` | String | Yes | User's question or instruction |
| `file_id` | String | Yes | File identifier expected by the agent |

### Example request

```json
{
  "user_id": "yamyam",
  "input_text": "Summarize this PDF",
  "file_id": "example-file-id"
}
```

### Example JavaScript

```javascript
const response = await fetch(
  `${BASE_URL}/api/v1/agent/respones`,
  {
    method: "POST",
    headers: {
      "Content-Type": "application/json"
    },
    body: JSON.stringify({
      user_id: userId,
      input_text: userQuestion,
      file_id: fileId
    })
  }
);

if (!response.ok) {
  throw new Error(await response.text());
}

const result = await response.json();

// Display the actual response returned by the backend.
// The OpenAPI specification does not define its response fields.
console.log(result);
```

### Values required from earlier steps

- `user_id`: retain from the user's current session.
- `file_id`: obtain from the backend's Stirling upload workflow, using the actual response field confirmed by the backend.
- `input_text`: read from the chat input.

The frontend should display the actual agent response. Do not assume the response property is named `answer`, `response`, or `message` until the backend documents it.

## 9. Suggested frontend state for the selected document

Once the backend response contract is confirmed, the frontend can keep the selected document's identifiers together:

```javascript
const selectedDocument = {
  user_id: userId,
  file_name: fileName,
  file_id: fileId
};
```

Reuse these values:
- For the AI Agent: send `user_id` and `file_id` in the JSON body, plus the current `input_text`.
- For Stirling download: send `user_id`, `file_name`, and `file_id` as query parameters.
- For MinIO retrieval: send `user_id` and `file_name` as query parameters.
- For MinIO deletion: send `user_id` and the exact object name as JSON.

Do not create or guess `file_id` on the frontend. It must come from the backend workflow.

## 10. Endpoint quick reference

| Operation | Method | Endpoint |
|---|---|---|
| Upload PDF to MinIO | POST | `/api/v1/minio/putobject` |
| List MinIO objects | GET | `/api/v1/minio/getlistobject` |
| Retrieve MinIO object | GET | `/api/v1/minio/getobject` |
| Delete MinIO object | DELETE | `/api/v1/minio/deleteobject` |
| Upload to Stirling | POST | `/api/v1/stirling/upload` |
| Download from Stirling | GET | `/api/v1/stirling/download` |
| Ask AI Agent | POST | `/api/v1/agent/respones` |

## 11. Error handling

Check `response.ok` for every request. The OpenAPI document lists `422` validation errors for these operations. The frontend should show a useful error message and avoid treating a failed request as a successful upload or processing step.

```javascript
if (!response.ok) {
  const errorText = await response.text();
  throw new Error(`API request failed (${response.status}): ${errorText}`);
}
```

## 12. Backend details to confirm before frontend integration

The current OpenAPI specification leaves these important response details unspecified:

1. What does MinIO upload return?
2. What is the exact item structure returned by MinIO list?
3. Does MinIO get return PDF bytes, JSON, or metadata?
4. What does Stirling upload return, and what is the exact `file_id` property name?
5. Does Stirling download return PDF binary data?
6. What is the exact AI Agent response JSON structure?
7. Does the Stirling upload route read the PDF from MinIO, given that its OpenAPI request has no body?

Once these response contracts are documented, the frontend can implement reliable state management and connect each endpoint without guessing.

**Security note:** The current OpenAPI specification does not show an authentication scheme. In production, the backend should authenticate the user and derive their identity from a verified session/token rather than trusting a browser-supplied `user_id`.
