```bash
kubectl create configmap consul --from-file=config/server.json
kubectl apply -f consul-service.yaml
kubectl apply -f consul-service-account.yaml
kubectl apply -f consul-cluster-role.yaml
kubectl apply -f consul-statefulset.yaml
```
Clean up:
```bash
kubectl delete -f consul-statefulset.yaml
kubectl delete pvc data-consul-0 data-consul-1 data-consul-2
```
Others
```bash
kubectl create configmap consul --from-file=config/server.json -o yaml --dry-run | kubectl replace -f -
````
