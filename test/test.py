import httpx
from app.config.settings import setting_manager


if __name__ == "__main__":
    headers = {"X-API-KEY": setting_manager.STIRLING_API_KEY}
    r = httpx.get("http://localhost:8080/api/v1/storage/files",
                  headers=headers)
    print(r.status_code, r.text)
