#FROM osgeo/proj

#ARG BASE_CONTAINER=jupyter/scipy-notebook
#ARG BASE_CONTAINER=jupyter/tensorflow-notebook
#ARG BASE_CONTAINER=pupster90/io
ARG BASE_CONTAINER=momosho/aiml
FROM $BASE_CONTAINER


######################################################################
# Graphviz and Dot 
RUN conda install -c anaconda graphviz -y

######################################################################
# Install nbgitpuller for syncing git files
RUN pip install nbgitpuller

######################################################################
# Install nbgrader and enable the extension
RUN pip install nbgrader
RUN jupyter nbextension install --sys-prefix --py nbgrader --overwrite
RUN jupyter nbextension enable --sys-prefix --py nbgrader
RUN jupyter serverextension enable --sys-prefix --py nbgrader

RUN jupyter labextension install @jupyterlab/toc

# Create exchange directory
USER root
RUN mkdir -p /srv/nbgrader/exchange && fix-permissions /srv/nbgrader/exchange

######################################################################
#FROM pvalsecc/docker-graphviz

