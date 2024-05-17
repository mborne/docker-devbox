# Kyverno

[kyverno](https://artifacthub.io/packages/helm/kyverno/kyverno) with [kyverno-policies](https://artifacthub.io/packages/helm/kyverno/kyverno-policies) and [Policy Reporter](https://kyverno.github.io/policy-reporter/) (metrics & UI).

## Usage with Kubernetes

Read [k8s-install.sh](k8s-install.sh) and run :

```bash
bash k8s-install.sh
```

To get access to [Policy Reporter](https://kyverno.github.io/policy-reporter/) :

```bash
# To get UI access on http://localhost:8888
kubectl -n kyverno port-forward svc/policy-reporter-ui 8888:8080

# To get API access on http://localhost:8888/metrics
kubectl -n kyverno port-forward svc/policy-reporter 8888:8080
```

## Ressources

* [kyverno.io - Introduction](https://kyverno.io/docs/introduction/)
* [kyverno.github.io/policy-reporter - Getting started](https://kyverno.github.io/policy-reporter/guide/getting-started)
