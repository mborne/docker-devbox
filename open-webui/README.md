# Open WebUI

Containers running [Open WebUI](https://github.com/open-webui/open-webui?tab=readme-ov-file#open-webui-formerly-ollama-webui-) and [ollama](https://hub.docker.com/r/ollama/ollama) to get started with LLM locally.

## Usage with docker

* Ensure that GPU support is enabled in docker (or adapt [docker-compose.yaml](docker-compose.yaml)) :

```bash
docker run --gpus all nvcr.io/nvidia/k8s/cuda-sample:nbody nbody -gpu -benchmark
```

* Start : `docker compose up -d`
* Open https://open-webui.dev.localhost

To use ollama API :

```bash
curl http://localhost:11434/api/generate -d '{
  "model": "llama3",
  "prompt": "Why is the sky blue?"
}'
```

## Resources

* [Open WebUI - Getting Started](https://docs.openwebui.com/getting-started/)
* [mborne/toolbox - cuda-toolkit](https://github.com/mborne/toolbox/tree/master/cuda-toolkit#ressources)

* [ollama](https://github.com/ollama/ollama/tree/main?tab=readme-ov-file#ollama)
* [hub.docker.com - ollama/ollama](https://hub.docker.com/r/ollama/ollama)
* [ollama - API](https://github.com/ollama/ollama/blob/main/docs/api.md#api)



