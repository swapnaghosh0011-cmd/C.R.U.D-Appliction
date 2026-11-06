from fastapi import FastAPI
from app.agent.router.agent_router import agent_router_var
from app.minio.router.minio_routes import minio_router_var
from app.stirling.routes.stiriling_route import stirling_router_var
import logfire
from dotenv import load_dotenv

logfire.configure()

load_dotenv()
app = FastAPI()

app.include_router(
    router=agent_router_var,
    prefix="/api/v1",
    tags=["Agent properties routs"]
)


app.include_router(
    router=minio_router_var,
    prefix="/api/v1",
    tags=["Data base properties routs"]
)

app.include_router(
    router=stirling_router_var,
    prefix="/api/v1",
    tags=["Stirling properties routs"]
)
