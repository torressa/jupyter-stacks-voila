# Docker

The folder contains all the docker and docker-compose files,
as oppossed to having yml and docker files hidden in different places.

### Docker-compose for everything

In this project, docker image building, tagging, caching and service orchestration is done by
docker-compose.
All services (even though some are independent and not related) are in the same docker compose file.
When spinning, the specific services required are specified in the docker-compose commands, the
rest of the services are ignored.

For example in the `./run_notebook` script, to run the jupyter notebook for editing,
the `build-notebook` and `run-notebook`
services are used.

To serve voila through nginx, the `build-notebook`, `voila` and `nginx` services are all used.

### Multi-stage builds

As a matter of taste, multi-stage docker images are also used in this project.
These allow you to control the size of the final images and delete the
intermediate ones only used for building (`jupyter/notebook:builder` in this case, produced
by the `build-notebook` service).

In this case, there is no benefit since the builder image and the rest are the same size,
however, in most real cases, the builder image requires a lot more additional stuff
(e.g. download and compilation of external libraries, additional packages, building, testing, ...)
which could make it significantly larger than required for production or deployment.
