```bash
kubectl create configmap vault --from-file=config/config.json
kubectl apply -f service.yaml
```
Others
```bash
kubectl create configmap vault --from-file=config/config.json -o yaml --dry-run | kubectl replace -f -
````
