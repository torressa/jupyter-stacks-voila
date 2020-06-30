# jupyter-stacks-voila

(Minimal) working example to learn how to deploy a jupyter notebook
(ran on [jupyter/docker-stacks](https://github.com/jupyter/docker-stacks))
using [voila](https://github.com/voila-dashboards/voila/tree/stable) and [nginx](https://docs.nginx.com/).

# Requirements

- Docker
- python
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
as oppossed to having yml and docker file hidden in different places.

1. Jupyter/doker-stacks (`Dockerfile`, `docker-compose.build.yml`, `docker-compose.run.yml`)
2. voila [`docker-compose.voila.yml`](docker/docker-compose.voila.yml) and [`run_voila`](docker/run_voila) script with to run voila with custom flags and things (ran inside a jupyter/docker-stack docker image)
3. nginx (`*nginx*`)

To overcomplicate things, I've split the different components into different files. However,
some of them are share and/or are dependent.
When spinning, the docker compose command concatenates the specified files.
The same result can be achieved by copying and pasting.

For example, to run the jupyter notebook, the `build` and `run` compose files are used. For voila, the `build` and the `voila` compose files are used. And for the final case, the `build`, `voila` and `nginx` files are all used.

Also, multi-stage docker files.
