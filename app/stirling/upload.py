from httpx import AsyncClient
from app.config.settings import setting_manager
import logfire
from pathlib import Path


async def upload_pdf(file_path: str) -> bool:
    try:
        async with AsyncClient(timeout=60) as client:
            url = f"{setting_manager.STIRLING_EDITE_PDF}"
            header = {"X-API-KEY": setting_manager.STIRLING_API_KEY}
            data = {"optimizeLevel": "5"}
            path = Path(file_path)
            with open(path, "rb") as file:
                files = {
                    "file": (
                        path.name,
                        file,
                        "application/pdf"
                    )
                }
                response = await client.post(url, headers=header, data=data, files=files)
                if response.status_code >= 400:
                    logfire.debug(
                        f"Stirling said:{response.status_code}, {response.text}")
                response.raise_for_status()
            logfire.info(
                f"File uploaded successfully: {len(response.content)}")
            return True
    except Exception as error:
        logfire.error(f"Error while uploading file: {error}")
        raise Exception("Error while uploading file to stirling")
