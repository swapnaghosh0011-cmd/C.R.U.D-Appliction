from fastapi import APIRouter
from app.agent.agent_runner import AgentRunner
from app.config.settings import setting_manager
from fastapi.responses import StreamingResponse
from app.types.type_hint import AiResponesRequest
from dotenv import load_dotenv
from fastapi.exceptions import HTTPException
import logfire

load_dotenv()
agent_router_var = APIRouter()

runner = AgentRunner(
    model_name=setting_manager.MODEL_NAME,
    verbose_command=False,
    api_key=setting_manager.GOOGLE_API_KEY
)


@agent_router_var.post("/agent/respones")
async def agent_resones(request: AiResponesRequest):
    try:
        async def run_agent():
            async for chunk in runner.strem_agent(
                input_text=request.input_text,
                user_id=request.user_id
            ):
                yield chunk
        return StreamingResponse(run_agent(), media_type="text/event-stream")
    except Exception as error:
        logfire.error(f"Error while processing agent response: {error}")
        raise HTTPException(
            status_code=500, detail=f"Error while processing agent response please try again later"
        )
