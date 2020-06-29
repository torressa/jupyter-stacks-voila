##################
# Building Stage #
##################
FROM jupyter/base-notebook AS builder

COPY requirements.txt .

RUN python3 -m pip install --user --no-cache-dir -r requirements.txt

#################
# Running Stage #
#################
FROM jupyter/base-notebook AS run

# Copy installed python packages (they are installed in that directory)
COPY --from=builder /home/jovyan/.local/ /home/jovyan/.local

USER root

ENV PYTHONPATH "/home/jovyan/work/"
# Install necessary jupyter packages for writing here. e.g.
RUN jupyter nbextension enable --py --sys-prefix widgetsnbextension

USER $NB_USER

####################
# Deployment Stage #
####################
FROM jupyter/base-notebook AS deploy

# Copy installed python packages (they are installed in that directory)
COPY --from=builder /home/jovyan/.local/ /home/jovyan/.local
COPY notebooks .
COPY docker/run_voila .

USER root

ENV PYTHONPATH "/home/jovyan/work/"
# Install necessary jupyter packages for deployment here. e.g.
RUN jupyter nbextension enable --py --sys-prefix widgetsnbextension

USER $NB_USER
