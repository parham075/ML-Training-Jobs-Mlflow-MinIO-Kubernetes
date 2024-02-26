# Create Container from app

To create container you can do the following steps

1- Build the image:

```python
# build image insde cluster
minikube image build -t docker.io/pippo/training-container:0.1 .
podman build --format docker -t localhost/simple-train:latest .
```

2- Run mlflow ui using terminal
```python
conda create --name env_5
conda install -c conda-forge mlflow
conda activate env_5s
mlflow ui
```
3- Test the image
```python
podman run -i --userns=keep-id --user=1001:100 --rm --env=PYTHONPATH=/app --env SCIKIT_LEARN_DATA=/tmp/scikit_learn_data --network="host" localhost/simple-train:latest python -m app --n_estimators=300 --max_depth=10 --random_state=17
```
3- You can also remove image:
```python 
podman images | grep localhost

podman rmi images <image-id>
```
- Example:
```python 
podman images | grep localhost
output:

localhost/simple-train    latest      aba46eaee95a  8 minutes ago  798 MB

podman rmi images aba46eaee95a
```

5- you can also kill the proccess on port 5000

```python
sudo fuser -k 5000/tcp
```