from pypdf import PdfReader
from io import BytesIO
from minio import Minio
from app.utils.erro_handeler import MinioErrorHandeler
import asyncio
from app.config.settings import setting_manager
from app.minio.parse_pdf_minio import parse_pdf_from_minio
from pyresilience import resilient, RetryConfig, TimeoutConfig
import logfire


class MinioClient:
    """
    A client for interacting with a Minio server.
    """

    def __init__(self, endpoint: str, access_key: str, secret_key: str):
        """
        Initializes the MinioClient with the given endpoint, access key, and secret key.
        Args:
            endpoint (str): The Minio server endpoint.
            access_key (str): The access key for authentication.
            secret_key (str): The secret key for authentication.
        """
        self.client = Minio(
            endpoint=endpoint,
            access_key=access_key,
            secret_key=secret_key,
            secure=False
        )
        if self.client.bucket_exists(bucket_name="defult") is True:
            logfire.debug("Minio bucket exists.")
        else:
            self.client.make_bucket(bucket_name="defult")
            logfire.debug("Minio bucket created sucessfully.")

    @resilient(
        timeout=TimeoutConfig(
            seconds=60
        ),
        retry=RetryConfig(
            max_attempts=3,
            backoff_factor=20
        )
    )
    async def PutObject(self, user_id: str, bucket_name: str, data, object_name: str, length, content_type: str):
        """
        # Implement the logic to put an object into Minio
        loop = asyncio.get_event_loop()
        respones = await loop.run_in_executor(None, self.client.fput_object, bucket_name, f"{user_id}/{object_name}", file_path)
        return respones
        """
        # Implement the logic to put an object into Minio
        try:
            loop = asyncio.get_event_loop()
            respones = await loop.run_in_executor(
                None,
                self.client.put_object,
                bucket_name,
                f"{user_id}/{object_name}",
                data,
                length,
                content_type
            )
            return user_id, respones.object_name
        except Exception as error:
            logfire.error(f"Error while putting object into Minio: {error}")
            raise MinioErrorHandeler("error  in minio client")

    @resilient(
        timeout=TimeoutConfig(
            seconds=60
        ),
        retry=RetryConfig(
            max_attempts=3,
            backoff_factor=20
        )
    )
    async def directPutObject(self, user_id: str, bucket_name: str, file_name: str):
        """
        # Implement the logic to put an object into Minio
        loop = asyncio.get_event_loop()
        respones = await loop.run_in_executor(None, self.client.fput_object, bucket_name, f"{user_id}/{object_name}", file_path)
        return respones
        """
        # Implement the logic to put an object into Minio
        try:
            loop = asyncio.get_event_loop()
            respones = await loop.run_in_executor(
                None,
                self.client.fput_object,
                bucket_name,
                f"{user_id}/{file_name}",
                f"{setting_manager.TEMP_PATH}/{file_name}"
            )
            return user_id, respones.object_name
        except Exception as error:
            logfire.error(f"Error while putting object into Minio: {error}")
            raise MinioErrorHandeler("error  in minio client")

    @resilient(
        timeout=TimeoutConfig(
            seconds=60
        ),
        retry=RetryConfig(
            max_attempts=3,
            backoff_factor=20
        )
    )
    async def getObject(self, user_id: str, bucket_name: str, file_path: str, object_name: str) -> bool:
        """
        # Implement the logic to put an object into Minio
        loop = asyncio.get_event_loop()
        respones = await loop.run_in_executor(None, self.client.fput_object, bucket_name, f"{user_id}/{object_name}", file_path)
        return respones
        """
        # Implement the logic to put an object into Minio
        try:
            loop = asyncio.get_event_loop()
            await loop.run_in_executor(None, self.client.fget_object, bucket_name, f"{user_id}/{object_name}", file_path)
            return True
        except Exception as error:
            logfire.exception(
                f"Error while getting object from Minio: {error}")
            raise MinioErrorHandeler("error  in minio client")

    @resilient(
        timeout=TimeoutConfig(
            seconds=60
        ),
        retry=RetryConfig(
            max_attempts=3,
            backoff_factor=20
        )
    )
    async def delete_file(self, user_id: str, object_name: str):
        """
        # Implement the logic to delete an object from Minio
        loop = asyncio.get_event_loop()
        """
        try:
            loop = asyncio.get_event_loop()
            respones = await loop.run_in_executor(None, self.client.remove_object, "defult", f"{user_id}/{object_name}",)
            return respones
        except Exception as error:
            logfire.error(f"Error while deleting object from Minio: {error}")
            raise MinioErrorHandeler("error  in minio client")

    @resilient(
        timeout=TimeoutConfig(
            seconds=60
        ),
        retry=RetryConfig(
            max_attempts=3,
            backoff_factor=20
        )
    )
    async def download_file(self, user_id: str, object_name: str) -> str:
        """
        Generates a presigned URL for downloading an object from Minio.
        Args:
            user_id (str): The user ID associated with the object.
            object_name (str): The name of the object to download.
        Returns:
            str: A presigned URL for downloading the object.
        """
        try:
            loop = asyncio.get_event_loop()
            await loop.run_in_executor(
                None,
                self.client.get_object,
                "defult",
                f"{user_id}/{object_name}",
            )

        except Exception as error:
            logfire.error(
                f"Error while downloading object from Minio: {error}")
            raise MinioErrorHandeler("error in minio client")

    @resilient(
        timeout=TimeoutConfig(
            seconds=60
        ),
        retry=RetryConfig(
            max_attempts=3,
            backoff_factor=20
        )
    )
    async def get_all_object_list(self, bucket_name: str, user_id: str):
        """
        Retrieves a list of all objects in the specified bucket.
        Args:
            bucket_name (str): The name of the bucket to retrieve objects from.
        Returns:
            list: A list of object names in the specified bucket.
        """
        try:
            loop = asyncio.get_event_loop()
            objects = await loop.run_in_executor(
                None,
                self.client.list_objects,
                bucket_name,
                f"{user_id.rstrip('/')}/",
                True
            )
            return [
                {
                    "file_name": obj.object_name.split("/")[-1],
                    "object_name": obj.object_name,
                    "size": obj.size
                }
                for obj in objects
                if obj.object_name.lower().endswith(".pdf")
            ]
        except Exception as error:
            logfire.error(
                f"Error while retrieving object list from Minio: {error}")
            raise MinioErrorHandeler("error in minio client")
