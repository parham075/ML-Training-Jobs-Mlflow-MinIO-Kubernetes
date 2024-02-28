# Create Container from app

To create container you can do the following steps

1) Build the image:

```python
docker build  -t localhost/crop:latest .
```
2) Push image on your docker hub if needed
```python
# docker tag localhost/crop:latest your_username/repository:crop
docker login
docker tag localhost/crop:latest parhammbr/water-body:crop
# docker push your_username/repository:crop
docker push parhammbr/water-body:crop

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