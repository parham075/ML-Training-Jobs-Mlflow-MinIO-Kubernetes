# Simple water body job and tracking with MLFlow

To train a simple training job and track it using Mlflow alongside with MinIo to save artifacts on a minikube cluster in your localhost follow steps bellow:

## Minio & MLFLOW deployment

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


## Expose MLFLOW on port 5000 
0) open another terminal.

1) Apply `mlflow-install.yaml` on cluster
    ```python
    NAMESPACE_NAME=test
    pod_name=$(kubectl get po -n test | grep mlflow | awk '{print $1}' | xargs -I {} kubectl get pod {} -n test -o jsonpath='{.metadata.name}')
    kubectl port-forward $pod_name 5000:5000 -n "$NAMESPACE_NAME"
    ```

2) Kill the process if it's reqiured:
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
    kubectl -n "$NAMESPACE_NAME" create -f configMaps.yaml
    ```
    > Notice: to delete them execute:
    >```python
    > kubectl -n "$NAMESPACE_NAME" delete -f configMaps.yaml
    >```

4) Create training job
    ```python
    kubectl -n "$NAMESPACE_NAME" create -f app-package.yaml
    ```
    > Notice: to delete the job execute:
    >```python
    > kubectl -n "$NAMESPACE_NAME" delete -f app-package.yaml
    >```


## Check the results of training job.
1) You can check the results by executing this kubernetes Job:
    ```
    kubectl -n "$NAMESPACE_NAME" create -f check_results.yaml
    ```

2) You can find an example of results in [check-result.log](outputs/check-results.log)


3) After checking the results you may want to remove your resources.
    ```python
    kubectl delete ns "$NAMESPACE_NAME"
    ```
