from pathlib import Path
from minio import Minio
from app.utils.erro_handeler import MinioErrorHandeler
import asyncio
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
            return respones
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
            logfire.error(f"Error while getting object from Minio: {error}")
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
            respones = await loop.run_in_executor(
                None,
                self.client.get_object,
                "defult",
                f"{user_id}/{object_name}",
            )

        except Exception as error:
            logfire.error(
                f"Error while downloading object from Minio: {error}")
            raise MinioErrorHandeler("error in minio client")
