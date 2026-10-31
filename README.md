# CRUD Application

An AI-powered CRUD application built with **FastAPI**. It stores user files in **MinIO**, processes PDFs with **Stirling-PDF**, and uses an AI agent connected through **MCP** (Model Context Protocol) tools.

**Developer:** Shovan Saha

---

## Features

- Upload, download, and delete user files in MinIO object storage
- PDF processing (for example compression) through Stirling-PDF
- AI agent with MCP tools, streamed through the API
- Logging and tracing with Logfire
- Interactive API docs with Swagger UI

## Tech Stack

| Component | Purpose |
|---|---|
| FastAPI | REST API backend |
| MinIO | S3-compatible file storage |
| Stirling-PDF | PDF processing engine |
| LangChain + MCP | AI agent and tool connections |
| Logfire | Logging and observability |
| Docker Compose | Runs the supporting services |

## Prerequisites

- Python 3.13 (a virtual environment is recommended)
- [uv](https://docs.astral.sh/uv/) or pip
- Docker and Docker Compose

## How to Run

### 1. Clone the project

```bash
git clone <your-repository-url>
cd crud-ai
```

### 2. Install dependencies

```bash
uv sync
```

Or with pip:

```bash
python -m venv .venv
.venv\Scripts\activate
pip install -r requirements.txt
```

### 3. Configure environment variables

Create a `.env` file in the project root:

```env
# MinIO
MINIO_ENDPOINT=localhost:9000
MINIO_ACCESS_KEY=your-access-key
MINIO_SECRET_KEY=your-secret-key
MINIO_BUCKET=defult

# Stirling-PDF
STIRLING_API_KEY=your-stirling-api-key
STIRLING_EDITE_PDF=http://localhost:8080/api/v1/misc/compress-pdf

# MCP
MCP_YML_PATH=path/to/mcp-config.yml
```

Adjust the names to match your settings file.

### 4. Start the services (MinIO and Stirling-PDF)

```bash
docker compose up -d
```

Check that the containers are running:

```bash
docker compose ps
```

### 5. Start the API

```bash
fastapi run main.py
```

For development with auto-reload:

```bash
fastapi run main.py --reload
```

## Access

| Service | URL |
|---|---|
| API | http://localhost:8000 |
| Swagger docs | http://localhost:8000/docs |
| Stirling-PDF | http://localhost:8080 |
| MinIO | http://localhost:9000 |

## Stop the Services

Press `Ctrl+C` to stop the API, then:

```bash
docker compose down
```

## Project Structure

```
crud-ai/
├── main.py                    # Application entry point
├── docker-compose.yml         # MinIO and Stirling-PDF services
├── .env                       # Environment variables (not committed)
├── app/
│   ├── agent/
│   │   ├── agent_runner.py    # AI agent and response streaming
│   │   └── router/            # Agent API routes
│   ├── config/
│   │   └── settings.py        # Settings loaded from .env
│   ├── mcp_server/
│   │   ├── mcpserver_client.py  # MCP client, loads tools
│   │   └── yml_parser.py        # MCP YAML config parser
│   ├── minio/
│   │   ├── minio_client.py    # MinIO client and file operations
│   │   └── router/            # MinIO API routes
│   ├── stirling/
│   │   ├── upload.py          # Sends PDFs to Stirling-PDF
│   │   ├── file_delete.py     # Temp file cleanup
│   │   └── routes/            # Stirling API routes
│   ├── types/                 # Type hints
│   └── utils/                 # Error handlers
├── emergency/
│   └── emergency_mcp.py       # Fallback MCP server
├── stirling-pdf/              # Stirling-PDF data (configs, logs, database)
├── temp/                      # Temporary files (cleaned after use)
└── test/                      # Test scripts
```

## Troubleshooting

- **400 from Stirling:** check the multipart field name. `compress-pdf` uses `fileInput`; `storage/files` uses `file`.
- **File not found in MinIO:** keys are stored as `user_id/file_name`. Check the bucket name and the exact file name.
- **Logs not recorded:** call `logfire.configure()` once at startup.
- **Agent cannot find a file:** the agent only sees files through its MCP tools. Files added in the Stirling browser UI are not stored on the server.

## Author

**Shovan Saha**