# Create Container from app

To create container you can do the following steps

1- Build the image:

```python
# build image insde cluster
minikube image build -t norm-diff:0.1 .
podman build --format docker -t localhost/norm-diff:latest .
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
pwd=`pwd`
podman     run     -i     --userns=keep-id     --mount=type=bind,source=$(pwd),target=$pwd     --mount=type=bind,source=$(pwd)/crop_green.tif,target=$(pwd)/crop_green.tif,readonly     --mount=type=bind,source=$(pwd)/crop_nir.tif,target=$(pwd)/crop_nir.tif,readonly     --workdir=$pwd     --read-only=true     --user=1001:100     --rm     --env=HOME=/runs     --env=PYTHONPATH=/app     localhost/norm-diff:latest     python     -m     app     $(pwd)/crop_green.tif     $(pwd)/crop_nir.tif
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