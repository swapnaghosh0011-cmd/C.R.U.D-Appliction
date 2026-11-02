from yaml import safe_load
import logfire
import asyncio


def __read_and_parse_yaml(file_path):
    with open(file_path, "r") as file:
        return safe_load(file)


async def ymlfile_parser(file_path):
    """
    Asynchronously reads and parses a YAML file.
    """
    try:
        loop = asyncio.get_event_loop()
        respones = await loop.run_in_executor(None, __read_and_parse_yaml, file_path)
        return respones
    except Exception as error:
        logfire.exception(
            f"Error while reading and parsing YAML file: {error}")
        raise RuntimeError(error)
        # re-raise the original error unchanged
        # re-raise the original error unchanged
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
