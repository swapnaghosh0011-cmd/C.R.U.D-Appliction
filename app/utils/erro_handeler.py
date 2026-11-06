class MinioErrorHandeler(Exception):
    """
    Custom exception class for handling errors related to Minio operations.
    Attributes:
        message (str): A descriptive error message.
    """

    def __init__(self, message: str):
        self.message = message
        super().__init__(self.message)
