import yaml
import asyncio


def _propmt_yml_parser():
    with open("C:/Users/shova/Desktop/project/crud-ai/prompt.yml", encoding="utf-8") as f:
        system_prompt = yaml.safe_load(f)["system_prompt"]
        return system_prompt


async def Asynce_yml_parser():
    loop = asyncio.get_event_loop()
    system_prompt = await loop.run_in_executor(None, _propmt_yml_parser)
    return system_prompt
