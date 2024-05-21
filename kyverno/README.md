# Kyverno

[kyverno](https://artifacthub.io/packages/helm/kyverno/kyverno) with [kyverno-policies](https://artifacthub.io/packages/helm/kyverno/kyverno-policies) and [Policy Reporter](https://kyverno.github.io/policy-reporter/) (metrics & UI).

## Usage with Kubernetes

* Read [k8s-install.sh](k8s-install.sh) and run :

```bash
bash k8s-install.sh
```

* See [Policy Reporter](https://kyverno.github.io/policy-reporter/) UI's at https://kyverno.dev.localhost or using port-forward :

```bash
# To get UI access on http://localhost:8888
kubectl -n kyverno port-forward svc/policy-reporter-ui 8888:8080

# To get API access on http://localhost:8888/metrics
kubectl -n kyverno port-forward svc/policy-reporter 8888:8080
```

* See also [Grafana](../grafana/README.md) dashboards where [PolicyReport Details (13995)](https://grafana.com/grafana/dashboards/13995-policyreport-details/) is auto-provisioned.


## Ressources

* [kyverno.io - Introduction](https://kyverno.io/docs/introduction/)
* [kyverno - helm chart](https://artifacthub.io/packages/helm/kyverno/kyverno)
  * [helm/kyverno/values.yaml](helm/kyverno/values.yaml)
* [kyverno-policies  - helm chart](https://artifacthub.io/packages/helm/kyverno/kyverno-policies)
  * [helm/kyverno-policies/values.yaml](helm/kyverno-policies/values.yaml)
* [kyverno.github.io/policy-reporter - Getting started](https://kyverno.github.io/policy-reporter/guide/getting-started)
  * [helm/policy-reporter/values.yaml](helm/policy-reporter/values.yaml)

