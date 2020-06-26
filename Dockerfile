FROM jupyter/base-notebook AS builder

COPY requirements.txt .

RUN python3 -m pip install --user --no-cache-dir -r requirements.txt

FROM jupyter/base-notebook AS run

# Copy installed python packages (they are installed in that directory)
COPY --from=builder /home/jovyan/.local/ /home/jovyan/.local
COPY . .
USER root
ENV PYTHONPATH "/home/jovyan/work/"
RUN jupyter nbextension enable --py --sys-prefix qgrid \
&& jupyter nbextension enable --py --sys-prefix widgetsnbextension
USER $NB_USER
