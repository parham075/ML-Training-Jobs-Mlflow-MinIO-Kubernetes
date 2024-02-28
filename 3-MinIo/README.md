# MinIo installation 

To deploy MinIo on minikube cluster in your localhost follow steps bellow:

1- Start minikube cluster
```python
minikube start 
```

2- create a namespace using kubectl on your terminal


```python
NAMESPACE_NAME=test # you can replace it with your name
kubectl create namespace "$NAMESPACE_NAME"
```



3- Apply MinIo on cluster
```python
kubectl -n "$NAMESPACE_NAME" create -f minio-install.yaml 
```


4- Check the resources in the namespace
```python
kubectl -n "$NAMESPACE_NAME" get all
```

5- Access MinIO on a browser
```python
pod_name=$(kubectl get po -n test | grep minio | awk '{print $1}' | xargs -I {} kubectl get pod {} -n test -o jsonpath='{.metadata.name}')
kubectl -n "$NAMESPACE_NAME" port-forward $pod_name 9090:9090
```

6- Kill the process if it's reqiured:
```python
sudo fuser -k 9090/tcp
```
