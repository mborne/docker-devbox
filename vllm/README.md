# vllm

> [!CAUTION]
> This page and the related compose files were **generated with AI** ([Claude Code](https://claude.com/claude-code)) and have not been fully tested yet.

Container running [vLLM](https://docs.vllm.ai/) to serve an open LLM model through an [OpenAI-compatible API](https://docs.vllm.ai/en/stable/serving/openai_compatible_server.html).

Compared to [ollama](../ollama/README.md), vLLM serves **one model per container** (no `pull` at runtime) and supports [tool calling](https://docs.vllm.ai/en/stable/features/tool_calling.html), which is useful to build and test LLM agents.

## Requirements

An **NVIDIA GPU** is required with [NVIDIA Container Toolkit](https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/latest/install-guide.html) (see also [mborne.github.io/outils/cuda-toolkit](https://mborne.github.io/outils/cuda-toolkit) - *french*).

> [!NOTE]
> A CPU mode with [vllm/vllm-openai-cpu](https://hub.docker.com/r/vllm/vllm-openai-cpu) was tried but is too slow for a dev environment (several minutes of `torch.compile` at startup, slow generation with `--enforce-eager`). Use [ollama](../ollama/README.md) without GPU.

Ensure that GPU support is enabled in docker :

```bash
docker run --gpus all nvcr.io/nvidia/k8s/cuda-sample:nbody nbody -gpu -benchmark
```

## Usage with docker

* Start : `docker compose up -d`
* Stop : `docker compose down`

> [!NOTE]
> The first start downloads the model from [Hugging Face](https://huggingface.co/models) to the `vllm` volume and compiles it (`torch.compile`, cached in the `vllm-compile-cache` volume). Use `docker compose logs -f vllm` and wait for `Application startup complete` (~2 minutes with the default model on a 6 GB GPU).

## Configuration

Parameters are defined in [.env](.env) :

| Variable                      | Default                      | Description                                                    |
| ----------------------------- | ---------------------------- | -------------------------------------------------------------- |
| `VLLM_VERSION`                | `v0.33.0`                    | Version of the vLLM image                                      |
| `VLLM_MODEL`                  | `Qwen/Qwen3.5-0.8B`          | [Hugging Face](https://huggingface.co/models) model to serve   |
| `VLLM_SERVED_MODEL_NAME`      | `qwen3.5-0.8b`               | Model name to use in API requests (`model` field)              |
| `VLLM_MAX_MODEL_LEN`          | `8192`                       | Maximum context length (tokens)                                |
| `VLLM_MAX_NUM_SEQS`           | `16`                         | Maximum number of concurrent requests                          |
| `VLLM_TOOL_CALL_PARSER`       | `qwen3_coder`                | Tool call parser matching `VLLM_MODEL`                         |
| `VLLM_GPU_MEMORY_UTILIZATION` | `0.75`                       | Fraction of the GPU memory used by vLLM                        |
| `HF_TOKEN`                    | (empty)                      | Hugging Face token, required only for gated models             |

> [!WARNING]
> When changing `VLLM_MODEL`, check the `vllm serve` command given in the model card and adapt `VLLM_TOOL_CALL_PARSER` (see [vLLM - Tool calling](https://docs.vllm.ai/en/stable/features/tool_calling.html)).

### Choosing a model

> Last update : 2026-11-11

The default model ([Qwen/Qwen3.5-0.8B](https://huggingface.co/Qwen/Qwen3.5-0.8B), ~1.8 GB in BF16) is chosen to start on small GPUs (tested with 6 GB of VRAM : ~4.1 GB used). Models from the same family can be used depending on the available VRAM (BF16 weights, add some memory for the KV cache) :

| Model                                                          | Weights | Target                         |
| -------------------------------------------------------------- | ------- | ------------------------------ |
| [Qwen/Qwen3.5-0.8B](https://huggingface.co/Qwen/Qwen3.5-0.8B) | ~1.8 GB | GPU with 6+ GB of VRAM         |
| [Qwen/Qwen3.5-2B](https://huggingface.co/Qwen/Qwen3.5-2B)     | ~4.6 GB | GPU with 8+ GB of VRAM         |
| [Qwen/Qwen3.5-4B](https://huggingface.co/Qwen/Qwen3.5-4B)     | ~9.3 GB | GPU with 12+ GB of VRAM        |
| [Qwen/Qwen3.5-9B](https://huggingface.co/Qwen/Qwen3.5-9B)     | ~19 GB  | GPU with 24+ GB of VRAM        |

> [!NOTE]
> Qwen3.5 models are multimodal (text and images). Qwen3.5-0.8B and 2B answer without thinking by default, while 4B and above think by default : add `--reasoning-parser=qwen3` to the `command` to get the reasoning in a separate `reasoning_content` field.

## API usage

Use these commands once vLLM is started :

```bash
# list models
curl -sS http://localhost:8000/v1/models | jq -r '.data[].id'

# chat completion
curl -sS http://localhost:8000/v1/chat/completions \
  -H "Content-Type: application/json" \
  -d '{
    "model": "qwen3.5-0.8b",
    "messages": [{"role": "user", "content": "Why is the sky blue?"}]
  }' | jq -r '.choices[0].message.content'
```

The API is also available through traefik at https://vllm.dev.localhost/v1/models.

Any OpenAI client can be used, for instance with Python :

```python
from openai import OpenAI

client = OpenAI(base_url="http://localhost:8000/v1", api_key="not-needed")
response = client.chat.completions.create(
    model="qwen3.5-0.8b",
    messages=[{"role": "user", "content": "Why is the sky blue?"}],
)
print(response.choices[0].message.content)
```

## Troubleshooting

* **Out of memory at startup** : reduce `VLLM_MAX_MODEL_LEN` (ex : `4096`) or `VLLM_GPU_MEMORY_UTILIZATION`, or use a smaller model.
* **`max_num_seqs (...) exceeds available Mamba cache blocks (...)`** : models with linear attention layers such as Qwen3.5 reserve one cache block per concurrent request. Lower `VLLM_MAX_NUM_SEQS` or increase `VLLM_GPU_MEMORY_UTILIZATION`.
* **`could not select device driver "nvidia"`** : GPU support is not enabled in docker (see [mborne.github.io/outils/cuda-toolkit](https://mborne.github.io/outils/cuda-toolkit)).
* **`404` with `The model ... does not exist`** : the `model` field must match `VLLM_SERVED_MODEL_NAME`, not the Hugging Face model name.

## Resources

vLLM :

* [docs.vllm.ai - Using Docker](https://docs.vllm.ai/en/stable/deployment/docker/)
* [docs.vllm.ai - OpenAI-compatible server](https://docs.vllm.ai/en/stable/serving/openai_compatible_server.html)
* [docs.vllm.ai - Tool calling](https://docs.vllm.ai/en/stable/features/tool_calling.html)
* [hub.docker.com - vllm/vllm-openai](https://hub.docker.com/r/vllm/vllm-openai)

GPU support :

* [docker docs - GPU support](https://docs.docker.com/compose/how-tos/gpu-support/)
* [mborne.github.io/outils/cuda-toolkit](https://mborne.github.io/outils/cuda-toolkit) (*french*)

Clients :

* [Open WebUI - OpenAI-compatible servers](https://docs.openwebui.com/getting-started/quick-start/starting-with-openai-compatible/) / [mborne/docker-devbox - open-webui](../open-webui/README.md)
* [langchain - ChatOpenAI (Python)](https://python.langchain.com/docs/integrations/chat/openai/)
