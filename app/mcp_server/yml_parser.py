from yaml import safe_load
from contextlib import asynccontextmanager
import logfire
import asyncio


def __read_and_parse_yaml(file_path):
    with open(file_path, "r") as file:
        return safe_load(file)


@asynccontextmanager
async def ymlfile_parser(file_path):
    """
    Asynchronously reads and parses a YAML file.

    """
    try:
        respones = await asyncio.to_thread(__read_and_parse_yaml, file_path)
        yield respones
    except Exception as error:
        print(error)
        logfire.error(f"Error while parsing YAML file: {error}")
        raise Exception("Error while parsing YAML file:", error)
"""
if __name__ == "__main__":
    async def main():
        async with ymlfile_parser(
            file_path="C:/Users/shova/Desktop/project/crud-ai/.mcp.yml"
        ) as respones:
            print(respones)
            return respones
    asyncio.run(main())
"""
