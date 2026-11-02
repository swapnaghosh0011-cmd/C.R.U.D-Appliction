import base64
from pathlib import Path
import asyncio
from contextlib import asynccontextmanager


def __encoder(file_path: str):

    b64 = base64.b64encode(Path(file_path).read_bytes()).decode()
    return b64


@asynccontextmanager
async def Async_encoeder(file_pth: str):
    """
    Asynchronously encodes a file to base64.

    """
    loop = asyncio.get_event_loop()
    respones = await loop.run_in_executor(None, __encoder, file_pth)
    yield respones
