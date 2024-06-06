

## Usage with Kubernetes

Read [k8s-install.sh](k8s-install.sh) and run to install the operator :

```bash
bash cnpg/install.sh
```

See [manifest/postgis-cluster.yaml](manifest/postgis-cluster.yaml) to create a sample cluster :

```bash
kubectl -n cnpg apply -f "cnpg/manifest/postgis-cluster.yaml"
```


See [manifest/job-import-naturalearth.yaml](manifest/job-import-naturalearth.yaml) to import sample data :

```bash
kubectl -n cnpg apply -f "cnpg/manifest/job-import-naturalearth.yaml"
```



