# Trivy

Container running [trivy-operator](https://github.com/aquasecurity/trivy-operator#readme).

## Usage

### See helm help

```bash
# Inspect created VulnerabilityReports by:
kubectl get vulnerabilityreports --all-namespaces -o wide

# Inspect created ConfigAuditReports by:
kubectl get configauditreports --all-namespaces -o wide

# Inspect the work log of trivy-operator by
kubectl logs -n trivy-system deployment/trivy-operator
```

### Metrics

```bash
# To explore prometheus metrics : http://127.0.0.1:5000/metrics
kubectl -n trivy-system port-forward svc/trivy-operator 5000:80
```

### Chart versions

```bash
helm repo add aqua https://aquasecurity.github.io/helm-charts/
helm repo update
helm search repo aqua/trivy-operator -l | more
```

## Resources

* [trivy-operator - Quick Start](https://github.com/aquasecurity/trivy-operator?tab=readme-ov-file#quick-start)
