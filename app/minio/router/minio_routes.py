from fastapi import Response
from fastapi import APIRouter
from app.types.type_hint import MinioPutRequest, MinioDeleteRequest, MinioMarkDownUrlRequest
from app.minio.minio_client import MinioClient
from app.config.settings import setting_manager
from pathlib import Path
from fastapi import File, UploadFile
from fastapi.exceptions import HTTPException
import json
import logfire

minio_router_var = APIRouter()

minio_client = MinioClient(
    endpoint=setting_manager.ENDPOINT,
    access_key=setting_manager.ACCESS_KEY,
    secret_key=setting_manager.SECRETKEY
)


@minio_router_var.post("/minio/putobject")
async def putobject(user_id: str, file: UploadFile = File()):
    try:
        respones = await minio_client.PutObject(
            bucket_name="defult",
            user_id=user_id,
            data=file.file,
            object_name=file.filename,
            length=file.size,
            content_type=file.content_type
        )
        return respones
    except Exception as error:
        logfire.error(f"Error while putting object into Minio: {error}")
        raise HTTPException(
            status_code=500, detail=f"Error while putting object into data base please try again later")


@minio_router_var.get("/minio/getobject")
async def getobject(file_name: str, user_id: str):
    try:
        respones = await minio_client.download_file(
            user_id=user_id,
            object_name=file_name
        )
        data = respones.read()
        return Response(
            content=data,
            media_type="application/pdf",
            headers={
                "Content-Disposition": f'attachment; filename="{Path(file_name).name}"'},
        )
    except Exception as error:
        logfire.error(f"Error while getting object from Minio: {error}")
        raise HTTPException(
            status_code=500, detail=f"Error while getting object from data base please try again later"
        )


@minio_router_var.delete("/minio/deleteobject")
async def deleteobject(request: MinioDeleteRequest) -> object:
    try:
        respones = await minio_client.delete_file(
            user_id=request.user_id,
            object_name=request.object_name
        )
        return respones
    except Exception as error:
        logfire.error(f"Error while deleting object from Minio: {error}")
        raise HTTPException(
            status_code=500, detail=f"Error while deleting object from data base please try again later"
        )
