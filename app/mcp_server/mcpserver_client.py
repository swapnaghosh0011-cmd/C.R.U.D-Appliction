import logfire
from contextlib import asynccontextmanager
from app.config.settings import setting_manager
from app.mcp_server.yml_parser import ymlfile_parser
from langchain.mcp import MCPAdapter


@asynccontextmanager
async def get_tools(config_file: str):
    try:

        config = await ymlfile_parser(file_path=config_file)
        config = config["mcpServers"]
        config["stirling-pdf"]["headers"]["X-API-KEY"] = setting_manager.STIRLING_API_KEY
        async with MCPAdapter(config) as adapter:
            tools = await adapter.list_tools()

            """for t in tools:
                    if t.name == "stirling_download":
                        print(t.args_schema)
                logfire.info("tools parsed sucessfully")
                """
            yield tools
    except Exception as error:
        logfire.error(f"Error while getting tools: {error}")
        raise Exception("Error while getting tools:", error)

if __name__ == "__main__":
    import asyncio

    async def main():
        async with get_tools(config_file="C:/Users/shova/Desktop/project/crud-ai/.mcp.yml") as tools:
            print(tools)
    asyncio.run(main())
