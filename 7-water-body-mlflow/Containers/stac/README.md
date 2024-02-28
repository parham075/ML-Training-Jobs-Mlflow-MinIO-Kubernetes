# Create Container from app

To create container you can do the following steps

1- Build the image:

```python
# build image insde cluster
minikube image build -t stac:0.1 .
podman build --format docker -t localhost/stac:latest .
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
podman \
    run \
    -i \
    --userns=keep-id \
    --mount=type=bind,source=$(pwd),target=$(pwd) \
    --mount=type=bind,source=$(pwd)/otsu.tif,target=$(pwd)/otsu.tif,readonly \
    --workdir=$(pwd) \
    --read-only=true \
    --user=1001:100 \
    --rm \
    --env=HOME=$(pwd) \
    --env=PYTHONPATH=/app \
    localhost/stac:latest \
    python \
    -m \
    app \
    --input-item \
    https://earth-search.aws.element84.com/v0/collections/sentinel-s2-l2a-cogs/items/S2B_10TFK_20210713_0_L2A \
    --water-body \
    $(pwd)/otsu.tif
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