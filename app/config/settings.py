from pydantic_settings import BaseSettings, SettingsConfigDict


class ProjectSettings(BaseSettings):
    model_config = SettingsConfigDict(
        env_file=".env", env_file_encoding="utf-8", extra="ignore")
    ENDPOINT: str
    ACCESS_KEY: str
    SECRETKEY: str
    STIRLING_EDITE_PDF: str
    STIRLING_API_KEY: str
    MODEL_NAME: str
    GOOGLE_API_KEY: str
    MCP_YML_PATH: str
    TEMP_PATH: str
    REDIRECT_URL: str


setting_manager = ProjectSettings()
