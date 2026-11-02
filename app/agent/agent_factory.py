from app.agent.agent_runner import AgentAbstraction
from app.agent.agent_runner import GoogleAgentRunner
from app.agent.agent_runner import GroqAgentRunner
from typing import Literal


class AgentFactoryPattern:
    @staticmethod
    def create_agent(agent_type: str, model_name: str, verbose_command: bool, api_key: str) -> AgentAbstraction:
        if agent_type == "Google":
            return GoogleAgentRunner(model_name, verbose_command, api_key)
        elif agent_type == "Groq":
            # Implement GrouqAgentRunner class and return its instance here
            return GroqAgentRunner(model_name, verbose_command, api_key)
        else:
            raise ValueError(f"Unknown agent type: {agent_type}")


class AgentService:
    """
    Factory class to create and manage different types of agents.
    """

    def __init__(
        self,
        agent_type: str = Literal["Google", "Groq"],
        model_name: str = str,
        verbose_command: bool = Literal[True, False],
        api_key: str = str
    ):
        """
        Initializes the AgentService with the specified agent type, model name, verbosity, and API key.
        """
        self.agent_type = agent_type
        self.model_name = model_name
        self.verbose_command = verbose_command
        self.api_key = api_key

        if agent_type == "Google":
            self.agent_object = AgentFactoryPattern.create_agent(
                agent_type=agent_type,
                api_key=api_key,
                model_name=model_name,
                verbose_command=verbose_command
            )
        elif agent_type == "Groq":
            self.agent_object = AgentFactoryPattern.create_agent(
                agent_type=agent_type,
                api_key=api_key,
                model_name=model_name,
                verbose_command=verbose_command
            )
        else:
            raise ValueError(f"Unknown agent type: {agent_type}")

    async def agent_runner(self, user_id: str, user_input: str, file_id: str):
        """
        Runs the agent with the specified user input and user ID, yielding responses as they are generated.
        """

        async for chunk in self.agent_object.strem_agent(
            input_text=user_input,
            user_id=user_id,
            file_id=file_id
        ):
            yield chunk
