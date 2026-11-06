import uuid
import logfire
from app.config.settings import setting_manager
from contextlib import asynccontextmanager
from langchain.agents import create_agent
from langchain_google_genai.chat_models import ChatGoogleGenerativeAI
from app.mcp_server.mcpserver_client import get_tools
from langgraph.checkpoint.memory import InMemorySaver


class AgentRunner:
    def __init__(self, model_name, verbose_command, api_key):
        self.model = model_name
        self.verbose = verbose_command
        self.api = api_key
        self.llm = ChatGoogleGenerativeAI(
            model=self.model,     # use an exact name from the list above
            google_api_key=self.api,
            temperature=0.7
        )

    @asynccontextmanager
    async def __agent_run(self):
        try:
            async with get_tools(config_file=setting_manager.MCP_YML_PATH) as ai_tools:
                agent = create_agent(
                    model=self.llm,
                    tools=ai_tools,
                    debug=self.verbose,
                    checkpointer=InMemorySaver()
                )
                yield agent
        except Exception as error:
            logfire.exception(f"error in agent{error}")
            raise RuntimeError("error in agent")

    async def strem_agent(self, input_text: str, user_id: uuid.UUID):
        try:
            async with self.__agent_run() as agent:
                async for chunk in agent.astream(
                    {"messages": [
                        {
                            "role": "user",
                            "content": input_text
                        }
                    ]
                    },
                    config={
                        "configurable": {
                            "thread_id": user_id
                        }
                    },
                ):
                    if isinstance(chunk, dict) and "model" in chunk:
                        messages = chunk["model"]["messages"]
                        content = messages[-1].content if messages else None

                        if isinstance(content, str):
                            respones = content
                        elif isinstance(content, list) and content:
                            respones = content[0].get("text")
                        else:
                            respones = None
                        if respones:
                            yield respones
        except Exception as error:
            logfire.exception(f"error in agent{error}")
            raise RuntimeError("error in agent")
