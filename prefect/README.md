# Prefect

Container running [Prefect](https://hub.docker.com/r/prefecthq/prefect) server.

## Usage with docker

* Start containers : `docker compose up -d --build`
* Open https://prefect.dev.localhost/

## Resources

* [docs.prefect.io - Getting started](https://docs.prefect.io/v3/get-started)
* [docs.prefect.io - Self-hosting examples - Docker](https://docs.prefect.io/v3/manage/server/examples/docker)
* [docs.prefect.io - Self-hosting examples - Helm](https://docs.prefect.io/v3/manage/server/examples/helm)

* [artifacthub.io - prefect/prefect-worker - Configuring a Base Job Template on the Worker](https://artifacthub.io/packages/helm/prefect/prefect-worker#configuring-a-base-job-template-on-the-worker)

```bash
prefect work-pool get-default-base-job-template --type docker > prefect/img/prefect-worker/base-job-template.json

prefect work-pool get-default-base-job-template --type kubernetes > prefect/helm/prefect-worker/base-job-template.json
```

