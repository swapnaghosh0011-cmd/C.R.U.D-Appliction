from langchain.mcp import MCPAdapter
from app.mcp_server.yml_parser import ymlfile_parser
from app.config.settings import setting_manager
from app.mcp_server.base64_decoder import Async_decoder
from app.types.type_hint import McpServerDownloadReaspones
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
async def download_file_from_server(user_id: str = str, file_id: str = str, file_name: str = str) -> True:
    """
    Downloads a file from the server using the MCPAdapter.
    """
    try:

        config = await ymlfile_parser(file_path=setting_manager.MCP_YML_PATH)
        config = config["mcpServers"]
        config["stirling-pdf"]["headers"]["X-API-KEY"] = setting_manager.STIRLING_API_KEY
        logfire.debug("yml file parsed succesfully")
        async with MCPAdapter(config) as adapter:
            json_respones = await adapter.client.call_tool(
                name="stirling_download",
                arguments={
                    "fileId": file_id,
                },
                raise_on_error=True
            )
            logfire.info("File Downloaded successfully")
            respones = json_respones.content[1].resource.blob
            await Async_decoder(b64_string=respones, file_name=file_name)
            logfire.info("File stored in servers sucessfully")
            return True, user_id
    except Exception as error:
        logfire.error(f"Error while uploading file: {error}")
        raise Exception("Error while uploading file")

if __name__ == "__main__":
    import asyncio

    async def main():
        json_respones = await download_file_from_server(user_id="shovan saha", file_id="aacf3226-1dcd-4c7d-b5ca-db7821903cd0")
        print(json_respones)

    asyncio.run(main())
