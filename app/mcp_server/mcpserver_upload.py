import re
from langchain.mcp import MCPAdapter
from app.mcp_server.yml_parser import ymlfile_parser
from app.config.settings import setting_manager
from app.types.type_hint import McpServerUploadReaspones
from app.mcp_server.base64_encoder import Async_encoeder
from pyresilience import resilient, TimeoutConfig, RetryConfig
import logfire


@resilient(
    timeout=TimeoutConfig(
        seconds=60
    ),
    retry=RetryConfig(
        max_attempts=3,
        backoff_factor=20
    )
)
async def upload_file_to_server(user_id, pdf_name) -> McpServerUploadReaspones:
    """
    Uploads a file to the server using the MCPAdapter.
    """
    try:

        config = await ymlfile_parser(file_path=setting_manager.MCP_YML_PATH)
        config = config["mcpServers"]
        config["stirling-pdf"]["headers"]["X-API-KEY"] = setting_manager.STIRLING_API_KEY
        logfire.debug("yml file parsed succesfully")
        async with Async_encoeder(file_pth=f"{setting_manager.TEMP_PATH}/{pdf_name}") as base64_encoded:
            logfire.debug("file encoded succesfully")
            async with MCPAdapter(config) as adapter:
                json_respones = await adapter.client.call_tool(
                    name="stirling_upload",
                    arguments={
                        "file": f"{base64_encoded}",
                         "fileName": f"{pdf_name}"
                    },
                    raise_on_error=True
                )
                logfire.info("File uploaded successfully")
                text = json_respones.content[0].text
                match = re.search(r"fileId=([0-9a-fA-F-]{36})", text)
                file_id = match.group(1) if match else None
                return user_id, file_id, pdf_name

    except Exception as error:
        logfire.error(f"Error while uploading file: {error}")
        raise Exception("Error while uploading file")


if __name__ == "__main__":
    import asyncio

    async def main():
        json_respones = await upload_file_to_server(user_id="shovan saha", pdf_name="my_resume.pdf")
        print(json_respones)

    asyncio.run(main())
