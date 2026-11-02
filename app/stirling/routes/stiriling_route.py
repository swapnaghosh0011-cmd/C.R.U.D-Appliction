from fastapi import APIRouter
from app.mcp_server.mcpserver_upload import upload_file_to_server
from app.mcp_server.mcpserver_download import download_file_from_server
from app.minio.minio_client import MinioClient
from app.stirling.file_delete import delete_tmp_file
from app.config.settings import setting_manager
from fastapi.exceptions import HTTPException
from app.stirling.file_delete import delete_tmp_file
import logfire

stirling_router_var = APIRouter()
minio_client = MinioClient(
    endpoint=setting_manager.ENDPOINT,
    access_key=setting_manager.ACCESS_KEY,
    secret_key=setting_manager.SECRETKEY
)


@stirling_router_var.post("/stirling/upload")
async def upload_file(user_id: str, file_name: str):
    try:
        respones = await minio_client.getObject(
            user_id=user_id,
            object_name=file_name,
            bucket_name="defult",
            file_path=f"{setting_manager.TEMP_PATH}/{file_name}"
        )
        logfire.info('file stored in to tmp file')
        if respones is True:
            upload_respones = await upload_file_to_server(
                user_id=user_id,
                pdf_name=file_name
            )
            await delete_tmp_file(
                file_path=f"{setting_manager.TEMP_PATH}/{file_name}"
            )
            print(f"sever respones :{upload_respones}")
            return upload_respones
        else:
            raise HTTPException(
                status_code=404, detail=f"File not found in Minio bucket"
            )
    except Exception as error:
        logfire.error(f"Error while uploading file to MCP server: {error}")
        raise HTTPException(
            status_code=500, detail=f"Error while uploading file to MCP server please try again later"
        )


@stirling_router_var.get("/stirling/download")
async def download_file(user_id: str, file_name: str, file_id: str):
    try:
        respones = await download_file_from_server(
            file_id=file_id,
            file_name=file_name
        )
        respones = await minio_client.directPutObject(
            user_id=user_id,
            bucket_name="defult",
            file_name=file_name
        )
        logfire.info("reuploded to minio succefylly")
        path = f"{setting_manager.TEMP_PATH}/{file_name}"
        await delete_tmp_file(file_path=path)
        logfire.info("downloded file deleted from tmp succefylly")
        print(respones)
        return respones

    except Exception as error:
        logfire.error(f"Error while downloading file from MCP server: {error}")
        raise HTTPException(
            status_code=500, detail=f"Error while downloading file from MCP server please try again later"
        )
