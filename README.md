# jupyter-stacks-voila

(Minimal) working example to learn how to deploy a jupyter notebook
(ran on [jupyter/docker-stacks](https://github.com/jupyter/docker-stacks))
using [voila](https://github.com/voila-dashboards/voila/tree/stable) and [nginx](https://docs.nginx.com/).

# Requirements

- Docker and docker-compose
- bash

#  Quick start

To run and edit the notebook,

```bash
cd scripts/
./run_notebook
```

To serve your notebook on voila through nginx on `http://localhost:80`,

```bash
cd scripts/
./deploy_notebook
```

# Structure

- [`data/`](data/) - folder with data that is mounted and used inside the notebook. Contains a test csv file with the iris data set.
- [`docker/`](docker/) - all necessary docker and docker-compose files.
- [`my_module/`](my_module/) - some python module that is required in the notebook.
- [`nginx/conf.d/`](nginx/conf.d/) - configuration files for nginx.
- [`notebooks/`](notebooks/) - jupyter notebook to show.
- [`scripts/`](scripts/) - bash scripts to docker-compose up the necessary stuff.

## Scripts

- `run_notebook` - spin up a jupyter/docker-stacks container to edit the notebook (in case you don't have jupyter locally).
- `deploy_notebook` - spin up both voila (uses our jupyter/docker-stacks builder image) and nginx and reroute the voila server through nginx.

## Docker

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

## nginx

In the nginx folder there is the configuration file specified in the voila
[docs](https://voila.readthedocs.io/en/stable/deploy.html#running-voila-on-a-private-server).
