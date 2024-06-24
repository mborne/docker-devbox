# Open WebUI

Containers running [Open WebUI](https://github.com/open-webui/open-webui?tab=readme-ov-file#open-webui-formerly-ollama-webui-) and [ollama](https://hub.docker.com/r/ollama/ollama) to get started with LLM locally.

## Usage with docker

* Ensure that GPU support is enabled in docker (or adapt [docker-compose.yaml](docker-compose.yaml)) :

```bash
docker run --gpus all nvcr.io/nvidia/k8s/cuda-sample:nbody nbody -gpu -benchmark
```

* Start : `docker compose up -d`
* Open https://open-webui.dev.localhost
* To use [ollama API](https://github.com/ollama/ollama/blob/main/docs/api.md#api) :

```bash
# list models
curl -sS http://localhost:11434/api/tags | jq -r '.models[].name'

# pull model from https://ollama.com/library
curl http://localhost:11434/api/pull -d '{
  "name": "llama3"
}'

# use model
curl http://localhost:11434/api/generate -d '{
  "model": "llama3",
  "prompt": "Why is the sky blue?"
}'
```

## Custom model

To create custom model from [OLLAMA Modelfile](https://github.com/ollama/ollama/tree/main?tab=readme-ov-file#customize-a-prompt), a sample [models/geoassistant](models/geoassistant/README.md) is available :

```bash
docker compose exec ollama
ollama create geoassistant -f /models/geoassistant/Modelfile
ollama run geoassistant
# Do you know the most visited museums in Paris?
```


## Resources

* [Open WebUI - Getting Started](https://docs.openwebui.com/getting-started/)
* [mborne/toolbox - cuda-toolkit](https://github.com/mborne/toolbox/tree/master/cuda-toolkit#ressources)

[OLLAMA](https://github.com/ollama/ollama) :

* [ollama](https://github.com/ollama/ollama/tree/main?tab=readme-ov-file#ollama)
* [hub.docker.com - ollama/ollama](https://hub.docker.com/r/ollama/ollama)
* [ollama - API](https://github.com/ollama/ollama/blob/main/docs/api.md#api)

[Pipelines](https://docs.openwebui.com/pipelines) :

* https://docs.openwebui.com/pipelines/#-quick-start-with-docker
* https://ikasten.io/2024/06/03/getting-started-with-openwebui-pipelines/
* https://raw.githubusercontent.com/open-webui/pipelines/main/examples/filters/function_calling_filter_pipeline.py
