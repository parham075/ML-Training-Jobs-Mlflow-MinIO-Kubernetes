# Create Container from app

To create container you can do the following steps

1) Build the image:

```python
docker build  -t localhost/otsu:latest .
```
2) Push image on your docker hub if needed
```python
# docker tag localhost/otsu:latest your_username/repository:otsu
docker login
docker tag localhost/otsu:latest parhammbr/water-body:otsu
# docker push your_username/repository:otsu
docker push parhammbr/water-body:otsu

```

3) You can also remove image:
```python 
docker images | grep localhost

docker rmi images <image-id>
```
- Example:
```python 
docker images | grep localhost
output:

localhost/simple-train    latest      aba46eaee95a  8 minutes ago  798 MB

docker rmi images aba46eaee95a
```