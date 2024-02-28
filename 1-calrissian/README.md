# Calrissian installation 

To deploy a training job using Calrissian on minikube cluster in your localhost follow steps bellow:
This job shows how to use Calrissian to execute cwl files.

1- Start minikube cluster
```python
minikube start 
```

2- create a namespace using kubectl on your terminal


```python
NAMESPACE_NAME=test # you can replace it with your name
kubectl create namespace "$NAMESPACE_NAME"
```



3- Apply Calrissian Jobs on cluster
```python
kubectl -n "$NAMESPACE_NAME" create -f calrissian-install.yaml 
```


4- Check the resources in the namespace
```python
kubectl -n "$NAMESPACE_NAME" get all
```


6- Delete Calrissian from namespace:
```python
kubectl -n "$NAMESPACE_NAME" delete -f calrissian-install.yaml 
```
