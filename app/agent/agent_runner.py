import uuid
import logfire
from app.config.settings import setting_manager
from contextlib import asynccontextmanager
from langchain.agents import create_agent
from langchain_google_genai.chat_models import ChatGoogleGenerativeAI
from app.mcp_server.mcpserver_client import get_tools
from langgraph.checkpoint.memory import InMemorySaver
from langchain_groq.chat_models import ChatGroq
from abc import ABC, abstractmethod
from app.agent.prompt_yml_parser import Asynce_yml_parser


class AgentAbstraction(ABC):
    @abstractmethod
    async def strem_agent(self, input_text: str, user_id: uuid.UUID, file_id: str):
        pass


class GoogleAgentRunner(AgentAbstraction):
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
            sys_prompt = await Asynce_yml_parser()
            async with get_tools(config_file=setting_manager.MCP_YML_PATH) as ai_tools:
                agent = create_agent(
                    model=self.llm,
                    tools=ai_tools,
                    system_prompt=sys_prompt,
                    debug=self.verbose,
                    checkpointer=InMemorySaver()
                )
                yield agent
        except Exception as error:
            logfire.exception(f"error in agent{error}")
            raise RuntimeError("error in agent")

    async def strem_agent(self, input_text: str, user_id: uuid.UUID, file_id: str):
        try:
            async with self.__agent_run() as agent:
                async for chunk in agent.astream(
                    {
                        "messages": [
                            {
                                "role": "user",
                                "content": f"user_id={user_id}, fileId={file_id}. {input_text}",
                            },
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


class GroqAgentRunner(AgentAbstraction):
    def __init__(self, model_name, verbose_command, api_key):
        self.model = model_name
        self.verbose = verbose_command
        self.api = api_key
        self.llm = ChatGroq(
            model=self.model,     # use an exact name from the list above
            api_key=self.api,
            temperature=0.0
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

    async def strem_agent(self, input_text: str, user_id: uuid.UUID, file_id: str):
        try:
            async with self.__agent_run() as agent:
                async for chunk in agent.astream(
                    {
                        "messages": [
                            {
                                "role": "user",
                                "content": f"user_id={user_id}, fileId={file_id}. {input_text}",
                            },
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
