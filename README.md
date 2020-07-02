# jupyter-stacks-voila

(Minimal) working example to learn how to deploy a jupyter notebook
(ran on [jupyter/docker-stacks](https://github.com/jupyter/docker-stacks))
using [voila](https://github.com/voila-dashboards/voila/tree/stable) and [nginx](https://docs.nginx.com/).

# Requirements

- Docker and docker-compose
- bash

# Get started

To run and edit the notebook, run

```bash
cd scripts/
./run_notebook
```

To run voila, run

```bash
cd scripts/
./deploy_notebook
```

This will serve your notebook on voila through nginx on `http://localhost:80`.

# Structure

- [`data/`](data/) - folder with data that is mounted and used inside the notebook. Contains a test csv file with the iris data set.
- [`docker/`](docker/) - all necessary docker and docker-compose files.
- [`my_module/`](my_module/) - some python module that is required in the notebook.
- [`nginx/conf.d/`](nginx/conf.d/) - configuration files for nginx.
- [`notebooks/`](notebooks/) - jupyter notebook to show.
- [`scripts/`](scripts/) - bash scripts to docker-compose up the necessary stuff.

## Scripts

- `run_notebook` - spin up a jupyter/docker-stack container to edit the notebook (in case you don't want to have jupyter locally).
- `deploy_notebook` - spin up both voila (uses a jupyter/docker-stack image) and nginx and reroute the voila server through nginx.

## nginx

In the nginx folder there are some configuration files, as per specified in the voila
[docs](https://voila.readthedocs.io/en/stable/deploy.html#running-voila-on-a-private-server)
and another one to configure the voila container (note the server name is the same as the name in the docker compose) as an "upstream server".

## Docker

The folder contains all the docker and docker-compose files,
as oppossed to having yml and docker files hidden in different places.

In this project, docker image building, tagging and service orchestration is done by docker-compose.
All services (even though some are independent and not related) are in the same docker compose file.
When spinning, the specific services required are specified in the docker-compose commands, the
rest of the services are ignored.

For example, to run the jupyter notebook, the `build-notebook` and `run-notebook` services are used.
To serve voila through nginx, the `build-notebook`, `voila` and `nginx` services are all used.

Also, multi-stage docker images allow you to control the size of the final images and delete the
intermediate ones only used for building (`build-notebook` in this case).
