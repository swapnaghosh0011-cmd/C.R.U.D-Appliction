from fastmcp import FastMCP
from httpx import AsyncClient
import os

mcp = FastMCP("stirling-storage")

STIRLING = "http://localhost:8080"
HEADERS = {"X-API-KEY": os.environ["STIRLING_API_KEY"]}


@mcp.tool()
async def list_stirling_files() -> list[dict]:
    """List the PDF files stored in Stirling (id and file name)."""
    async with AsyncClient(timeout=60) as c:
        r = await c.get(f"{STIRLING}/api/v1/storage/files", headers=HEADERS)
        r.raise_for_status()
        return [{"id": f["id"], "name": f["fileName"]} for f in r.json()]


@mcp.tool()
async def compress_stirling_file(file_id: int) -> str:
    """Compress a stored PDF by its id and save the result back to storage."""
    async with AsyncClient(timeout=120) as c:
        d = await c.get(f"{STIRLING}/api/v1/storage/files/{file_id}/download", headers=HEADERS)
        d.raise_for_status()

        r = await c.post(
            f"{STIRLING}/api/v1/misc/compress-pdf",
            headers=HEADERS,
            data={"optimizeLevel": "5"},
            files={"fileInput": (f"file_{file_id}.pdf",
                                 d.content, "application/pdf")},
        )
        r.raise_for_status()

        s = await c.post(
            f"{STIRLING}/api/v1/storage/files",
            headers=HEADERS,
            files={"file": (f"compressed_{file_id}.pdf",
                            r.content, "application/pdf")},
        )
        s.raise_for_status()
        return f"Compressed. New stored file: {s.json()}"

if __name__ == "__main__":
    mcp.run()   # stdio by default
