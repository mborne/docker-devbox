# AnythingLLM

Container running [AnythingLLM](https://github.com/Mintplex-Labs/anything-llm) - an open-source, all-in-one RAG (Retrieval-Augmented Generation) and AI platform.

## Usage with docker

> You may start [Ollama](../ollama/README.md) before if you want to use a local model.

* Start AnythingLLM: `docker compose up -d`
* Open https://anythingllm.dev.localhost/
* Follow instructions

## Add MCP servers

See sample config [plugins/anythingllm_mcp_servers.json](plugins/anythingllm_mcp_servers.json) and use the following to copy it to `/app/server/storage/plugins/anythingllm_mcp_servers.json` in the container :

```bash
docker cp plugins/anythingllm_mcp_servers.json anythingllm:/app/server/storage/plugins/anythingllm_mcp_servers.json

# restart or refresh in https://anythingllm.dev.localhost/settings/agents
docker restart anythingllm
```

## Resources

* [Mintplex-Labs/anything-llm](https://github.com/Mintplex-Labs/anything-llm)
* [AnythingLLM Documentation](https://docs.anythingllm.com/)
* [AnythingLLM Docker Hub](https://hub.docker.com/r/mintplexlabs/anythingllm)
