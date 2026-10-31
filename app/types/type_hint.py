from pydantic import BaseModel


class MinioDataModel(BaseModel):

    user_id: str
    Post_TimeStamp: str


class MinioPutRequest(BaseModel):
    user_id: str


class MinioGetRequest(BaseModel):
    user_id: str
    object_name: str


class MinioMarkDownUrlRequest(BaseModel):
    user_id: str
    object_name: str


class MinioDeleteRequest(BaseModel):
    user_id: str
    object_name: str


class AiResponesRequest(BaseModel):
    user_id: str
    input_text: str
