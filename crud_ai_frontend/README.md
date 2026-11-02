# CRUD AI Frontend

A dependency-free HTML/CSS/JavaScript frontend for the FastAPI endpoints described in the supplied OpenAPI document.

## Run

1. Start your FastAPI backend on port 8000.
2. Open a terminal in this folder.
3. Run a static server:

   ```powershell
   uv run python -m http.server 5500
   ```

4. Open `http://localhost:5500`.
5. Set the API base URL (default `http://localhost:8000`) and your user ID.

You can also open `index.html` directly, but using a local HTTP server is recommended.

## Endpoints used

- `POST /api/v1/minio/putobject?user_id=...` — multipart field `file`
- `GET /api/v1/minio/getlistobject?user_id=...`
- `GET /api/v1/minio/getobject?user_id=...&file_name=...`
- `DELETE /api/v1/minio/deleteobject` — JSON `{ "user_id": "...", "object_name": "..." }`
- `POST /api/v1/stirling/upload?user_id=...&file_name=...`
- `GET /api/v1/stirling/download?user_id=...&file_name=...&file_id=...`
- `POST /api/v1/agent/respones` — JSON `{ "user_id": "...", "input_text": "...", "file_id": "..." }`

## Important contract notes

The supplied OpenAPI document does not define detailed response schemas for most endpoints. This UI therefore displays unknown JSON responses as returned, rather than assuming a response shape.

The Stirling upload operation has query parameters documented but no request body in the supplied OpenAPI document. This frontend calls it without a body. If your actual FastAPI route expects a file body, update the OpenAPI contract and the `stirlingUpload` handler.

The agent request requires all three fields: `user_id`, `input_text`, and `file_id`.

## CORS

If the browser blocks requests, configure CORS in FastAPI for the frontend origin, for example `http://localhost:5500`:

```python
from fastapi.middleware.cors import CORSMiddleware

app.add_middleware(
    CORSMiddleware,
    allow_origins=["http://localhost:5500"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)
```

For production, use your real frontend origin instead of `*`.

## Security

The current OpenAPI contract accepts `user_id` from the frontend. For production, authenticate users and derive the user ID from a verified JWT/session on the backend. Do not trust a client-supplied user ID for access control.
