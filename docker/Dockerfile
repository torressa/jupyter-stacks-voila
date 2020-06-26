FROM jupyter/base-notebook AS builder

COPY requirements.txt .

USER root
RUN apt-get update -qq \
&& apt-get install -yq nodejs git\
&& apt-get clean \
&& rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

USER $NB_USER

RUN python3 -m pip install --user --no-cache-dir -r requirements.txt
# && git clone https://github.com/quantopian/qgrid.git \
# && cd qgrid && python3 -m pip install --user . && cd js && npm install . \
# && cd .. && rm -rf qgrid

FROM jupyter/base-notebook AS run

# Copy installed python packages (they are installed in that directory)
COPY --from=builder /home/jovyan/.local/ /home/jovyan/.local

USER root
ENV PYTHONPATH "/home/jovyan/work/"
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
RUN jupyter nbextension enable --py --sys-prefix widgetsnbextension \
&& jupyter nbextension install --py --symlink --sys-prefix qgrid \
&& jupyter nbextension enable --py --sys-prefix qgrid

USER $NB_USER
