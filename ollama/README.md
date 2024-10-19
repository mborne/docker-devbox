# ollama

Containers running [Ollama](https://hub.docker.com/r/ollama/ollama)

## Usage with docker

* Ensure that GPU support is enabled in docker (or adapt [docker-compose.yaml](docker-compose.yaml)) :

```bash
docker run --gpus all nvcr.io/nvidia/k8s/cuda-sample:nbody nbody -gpu -benchmark
```

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

* [ollama](https://github.com/ollama/ollama/tree/main?tab=readme-ov-file#ollama)
* [hub.docker.com - ollama/ollama](https://hub.docker.com/r/ollama/ollama)
* [ollama - API](https://github.com/ollama/ollama/blob/main/docs/api.md#api)
* [mborne/toolbox - cuda-toolkit](https://github.com/mborne/toolbox/tree/master/cuda-toolkit#ressources)
