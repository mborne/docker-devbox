# Open WebUI

Container running [Open WebUI](https://github.com/open-webui/open-webui?tab=readme-ov-file#open-webui-formerly-ollama-webui-) for [Ollama](../ollama/README.md).

## Requirements

* [ollama](../ollama/README.md)

## Usage with docker

* Ensure that GPU support is enabled in docker (or adapt [docker-compose.yaml](docker-compose.yaml)) :

```bash
docker run --gpus all nvcr.io/nvidia/k8s/cuda-sample:nbody nbody -gpu -benchmark
```

* Start : `docker compose up -d`
* Open https://open-webui.dev.localhost


## Resources

* [Open WebUI - Getting Started](https://docs.openwebui.com/getting-started/)
* [mborne/toolbox - cuda-toolkit](https://github.com/mborne/toolbox/tree/master/cuda-toolkit#ressources)
* [Pipelines](https://docs.openwebui.com/pipelines) :
  * https://docs.openwebui.com/pipelines/#-quick-start-with-docker
  * https://ikasten.io/2024/06/03/getting-started-with-openwebui-pipelines/
  * https://raw.githubusercontent.com/open-webui/pipelines/main/examples/filters/function_calling_filter_pipeline.py

