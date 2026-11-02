import base64
import asyncio
from app.config.settings import setting_manager


def __encoder(b64_string, file_name: str):

    pdf_bytes = base64.b64decode(b64_string)
    with open(f"{setting_manager.TEMP_PATH}/{file_name}", "wb") as f:
        f.write(pdf_bytes)


async def Async_decoder(b64_string, file_name: str):
    """
    Asynchronously encodes a file to base64.

    """
    loop = asyncio.get_event_loop()
    respones = await loop.run_in_executor(None, __encoder, b64_string, file_name)
    return respones
