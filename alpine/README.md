# Supported tags and respective Dockerfile links
- [3.10, latest](https://github.com/benzBrake/Dockerfiles/blob/master/alpine/3.10/Dockerfile)
- [3.9](https://github.com/benzBrake/Dockerfiles/blob/master/alpine/3.9/Dockerfile)
- [3.8](https://github.com/benzBrake/Dockerfiles/blob/master/alpine/3.8/Dockerfile)
- [3.7](https://github.com/benzBrake/Dockerfiles/blob/master/alpine/3.7/Dockerfile)
- [3.9-travis-demo](https://github.com/benzBrake/Travis-Demo-Dockerfile/blob/master/alpine/3.9/Dockerfile), It's demo of building image by Travis CI

# Description

This is possible thanks to the work from [uggedal](https://github.com/uggedal) on packaging Alpine Linux for Docker.

This project is now build on top of official [Alpine Linux](https://hub.docker.com/_/alpine/) image, only including a few convenience packages.


## Included packages

To get you started, a set of packages have been integrated:

- curl
- ca-certificates

## Time Zone

China Standard Time

# How to use this image
## Usage
Use like you would any other base image:
```
FROM benzbrake/alpine:3.7
RUN apk add --no-cache mysql-client
ENTRYPOINT ["mysql"]
```