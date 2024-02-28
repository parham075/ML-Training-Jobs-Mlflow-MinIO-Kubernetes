# Create Container from app

To create container you can do the following steps

1) Build the image:

```python
docker build  -t localhost/norm_diff:latest .
```
2) Push image on your docker hub if needed
```python
# docker tag localhost/norm_diff:latest your_username/repository:norm_diff
docker login
docker tag localhost/norm_diff:latest parhammbr/water-body:norm_diff
# docker push your_username/repository:norm_diff
docker push parhammbr/water-body:norm_diff

```

3) You can also remove image:
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