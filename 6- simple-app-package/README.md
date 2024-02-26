# Simple Training job and tracking with MLFlow

To train a simple training job and track it using Mlflow alongside with MinIo to save artifacts on a minikube cluster in your localhost follow steps bellow:

## Minio deployment

1) Start minikube cluster
    ```python
    minikube start 
    ```

2) Initialize a variable for namespace on your terminal
    ```python
    NAMESPACE_NAME=test # you can replace
    kubectl create ns $NAMESPACE_NAME
    ```





3) Apply minio on cluster
    ```python
    kubectl -n "$NAMESPACE_NAME" create -f minio-install.yaml 
    ```


4) Check the resources in the namespace
    ```python
    kubectl -n "$NAMESPACE_NAME" get all
    ```

5) Access minio on a browser
    ```python
    pod_name=$(kubectl get po -n test | grep minio | awk '{print $1}' | xargs -I {} kubectl get pod {} -n test -o jsonpath='{.metadata.name}')
    kubectl port-forward $pod_name 9000 9090 -n "$NAMESPACE_NAME"
    ```

6) Kill the process if it's reqiured:
    ```python
    sudo kill -9 `sudo lsof -t -i:9090`
    ```

> Notice: You may need to create a bucket and call it `mlflow` from **MinIo Console**


## MLFLOW deployment
0) open another terminal.

1) Apply `mlflow-install.yaml` on cluster
    ```python
    NAMESPACE_NAME=test
    kubectl -n "$NAMESPACE_NAME" create -f mlflow-install.yaml 
    ```

2) Check the resources in the namespace
    ```python
    kubectl -n "$NAMESPACE_NAME" get all
    ```

3) Access mlflow on a browser
    ```python
    pod_name=$(kubectl get po -n test | grep mlflow | awk '{print $1}' | xargs -I {} kubectl get pod {} -n test -o jsonpath='{.metadata.name}')
    kubectl port-forward $pod_name 5000:5000 -n "$NAMESPACE_NAME"
    ```
4) Kill the process if it's reqiured:
    ```python
    sudo kill -9 `sudo lsof -t -i:5000`
    ```
## Training a simple classifier

0) Containarize your app. To get more information open a new terminal in [`Container`](./Container) and then follow the instructions in [`README.md`](./Container/README.md) 

1) open another terminal.

2) Initialize a variable for namespace on your terminal
    ```python
    NAMESPACE_NAME=test # you can replace
    ```



3) In oeder to mound files on k8s Create config maps for inputs.yaml and simple-training-app.cwl
    ```python
    kubectl create configmap input-conf -n test --from-file=inputs.yml

    kubectl create configmap train-conf -n test --from-file=simple-training-app.cwl


    ```
    > Notice: to delete them execute:
    >```python
    >kubectl delete configmap input-conf -n test
    >kubectl delete configmap train-conf -n test
    >```

4) Create Roles and Rolebindings
    ```python
    kubectl --namespace="$NAMESPACE_NAME" create role pod-manager-role \
      --verb=create,patch,delete,list,watch --resource=pods
    kubectl --namespace="$NAMESPACE_NAME" create role log-reader-role \
      --verb=get,list --resource=pods/log
    kubectl --namespace="$NAMESPACE_NAME" create rolebinding pod-manager-default-binding \
      --role=pod-manager-role --serviceaccount=${NAMESPACE_NAME}:default
    kubectl --namespace="$NAMESPACE_NAME" create rolebinding log-reader-default-binding \
      --role=log-reader-role --serviceaccount=${NAMESPACE_NAME}:default

    ```


5) Create training job
    ```python
    kubectl -n "$NAMESPACE_NAME" create -f app-package.yaml
    ```


6) After completing your job you may want to remove your resources.
    ```python
    kubectl delete ns "$NAMESPACE_NAME"
    ```