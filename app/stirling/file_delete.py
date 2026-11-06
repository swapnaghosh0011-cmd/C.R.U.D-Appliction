from pathlib import Path
import asyncio
import logfire


async def delete_tmp_file(file_path: str):
    try:
        file_name = Path(file_path).name
        await asyncio.to_thread(Path(file_path).unlink, missing_ok=True)
        logfire.info(f"{file_name} deleted from temp file sucessfully")
    except Exception as error:
        logfire.error(f"Error while deleting temp file: {error}")
        raise Exception("Error while deleting temp file")
