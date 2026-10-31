from fastapi import APIRouter
from app.stirling.upload import upload_pdf
from app.minio.minio_client import MinioClient
from app.config.settings import setting_manager
from app.types.type_hint import MinioGetRequest
from app.stirling.file_delete import delete_tmp_file
from fastapi.exceptions import HTTPException
from fastapi.responses import RedirectResponse
import logfire

minio_client = MinioClient(
    endpoint=setting_manager.ENDPOINT,
    access_key=setting_manager.ACCESS_KEY,
    secret_key=setting_manager.SECRETKEY
)
stirling_router_var = APIRouter()


@stirling_router_var.post("/stirling/upload")
async def edite_file(request: MinioGetRequest):
    try:
        file_path = f"{setting_manager.TEMP_PATH}/{request.object_name}"
        print(file_path)
        # Retrieve the file from MinIO
        respones = await minio_client.getObject(
            bucket_name="defult",  # Replace with your bucket name
            user_id=request.user_id,          # Replace with your user ID
            object_name=request.object_name,   # Replace with your object name
            file_path=f"{setting_manager.TEMP_PATH}/{request.object_name}"
        )
        if respones is True:
            # Upload the file to Stirling
            respones = await upload_pdf(file_path)
            if respones is True:
                await delete_tmp_file(file_path=file_path)
                return RedirectResponse(
                    url=setting_manager.REDIRECT_URL,
                    status_code=307
                )

            else:
                raise HTTPException(
                    status_code=500, detail=f"Error while uploading file to Stirling please try again later"
                )
        else:
            raise HTTPException(
                status_code=500, detail=f"Error while retrieving file from MinIO please try again later"
            )
    except Exception as e:
        logfire.exception(f"Error while uploading file to Stirling: {e}")
        raise HTTPException(
            status_code=500, detail=f"Error while uploading file to Stirling please try again later"
        )
