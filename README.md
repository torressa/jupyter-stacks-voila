# jupyter-stacks-voila

(Minimal) working example to learn how to deploy a jupyter notebook
(ran on [jupyter/docker-stacks](https://github.com/jupyter/docker-stacks))
using [voila](https://github.com/voila-dashboards/voila/tree/stable) and [nginx](https://docs.nginx.com/).

# Requirements

- Docker and docker-compose
- bash

#  Quick start

To run and edit the notebooks in `notebooks/` on a jupyter/docker-stacks container
(in case you don't have jupyter locally)

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

Please see the [docs](docs/) for more information.
