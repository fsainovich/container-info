# flask-env-var
Show info for the container

## Run image
```
# docker run -d -p 8080:5000 --name container-info fsainovich/container-info:TAG
```

## Customize image
### Build image container

After clone repo and made your changes, run the commands bellow (replace path and tag for your docker registry)
```
# docker build -t fsainovich/container-info:0.1 .
# docker login
# docker push fsainovich/container-info:0.1`