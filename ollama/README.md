# ollama

Containers running [Ollama](https://hub.docker.com/r/ollama/ollama)

## Usage with docker

Two compose modes are available:

* **CPU mode** (default): [compose.yaml](compose.yaml)
* **GPU mode** (NVIDIA): [compose.yaml](compose.yaml) + [compose-gpu.yaml](compose-gpu.yaml) (override)

### CPU mode (default)

* Start : `docker compose up -d`
* Stop : `docker compose down`

### GPU mode (NVIDIA)

* Ensure that GPU support is enabled in docker :

```bash
docker run --gpus all nvcr.io/nvidia/k8s/cuda-sample:nbody nbody -gpu -benchmark
```

* Start : `docker compose -f compose.yaml -f compose-gpu.yaml up -d`
* Stop : `docker compose -f compose.yaml -f compose-gpu.yaml down`

> [!TIP]
> alternative : `COMPOSE_FILE=compose.yaml:compose-gpu.yaml docker compose up -d`

### CLI and API usage

Use these commands once Ollama is started (CPU or GPU mode):

* To use Ollama CLI :

```bash
# pull models from https://ollama.com/library
docker compose exec ollama ollama pull llama3
docker compose exec ollama ollama pull gemma2
# interactive model
docker compose exec ollama ollama run llama3.1
```

* To use [Ollama API](https://github.com/ollama/ollama/blob/main/docs/api.md#api) :

```bash
# list models
curl -sS http://localhost:11434/api/tags | jq -r '.models[].name'

# pull model from https://ollama.com/library
curl http://localhost:11434/api/pull -d '{
  "name": "llama3"
}'

# use model
curl http://localhost:11434/api/generate -d '{
  "model": "llama3.2",
  "prompt": "Why is the sky blue?"
}'
```

* To create **custom model** from [OLLAMA Modelfile](https://github.com/ollama/ollama/tree/main?tab=readme-ov-file#customize-a-prompt), a sample [models/geoassistant](models/geoassistant/README.md) is available :

```bash
docker compose exec ollama /bin/bash
ollama create geoassistant -f /models/geoassistant/Modelfile
ollama run geoassistant
# Do you know the most visited museums in Paris?
```

## Ressources

Ollama :

* [ollama.com - Library](https://ollama.com/library) (**available models**)
* [ollama - API](https://github.com/ollama/ollama/blob/main/docs/api.md#api)
* [github.com - ollama/ollama](https://github.com/ollama/ollama/tree/main?tab=readme-ov-file#ollama)
* [hub.docker.com - ollama/ollama](https://hub.docker.com/r/ollama/ollama)

GPU support :

* [docker docs - GPU support](https://docs.docker.com/compose/how-tos/gpu-support/)
* [mborne.github.io/outils/cuda-toolkit](https://mborne.github.io/outils/cuda-toolkit) (*french*)

Clients :

* [Open WebUI - Starting With Ollama](https://docs.openwebui.com/getting-started/quick-start/starting-with-ollama/) / [mborne/docker-devbox - open-webui](../open-webui/README.md)
* [langchain - OllamaChat (Python)](https://python.langchain.com/docs/integrations/chat/ollama/) / [langchain - OllamaChat (JS)](https://js.langchain.com/docs/integrations/chat/ollama/)


