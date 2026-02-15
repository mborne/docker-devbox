```bash
kubectl -n argocd patch secret argocd-secret --patch='{"stringData": { "oidc.keycloak.clientSecret": "<REPLACE_WITH_CLIENT_SECRET>" }}'

kubectl -n argocd patch configmap argocd-cm --type='merge' --patch-file argocd/docs/qtw-oidc.yaml

kubectl -n argocd get deploy -o name | xargs kubectl -n argocd rollout restart
```

## Resources

- https://argo-cd.readthedocs.io/en/stable/operator-manual/user-management/keycloak/#configuring-argocd-oidc

