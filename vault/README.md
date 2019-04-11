## Deploy Vault cluster on Kubernetes
This guide will walk you through deploying a three (3) nodes Vault cluster on Kubernetes.

### Create the Vault Configmap
```bash
kubectl create configmap vault --from-file=config/config.json
```

### Create the Vault Service
```bash
kubectl apply -f service.yaml
```

### Create the Vault Deployment
```bash
kubectl apply -f deployment
```
### Unseal Vault cluster
Todo

### Accessing Web UI
Todo

### Others
Update configmap when changing config file
```bash
kubectl create configmap vault --from-file=config/config.json -o yaml --dry-run | kubectl replace -f -
````
