#FROM osgeo/proj

#ARG BASE_CONTAINER=jupyter/scipy-notebook
#ARG BASE_CONTAINER=jupyter/tensorflow-notebook
#ARG BASE_CONTAINER=pupster90/io
ARG BASE_CONTAINER=momosho/aiml
FROM $BASE_CONTAINER


RUN apt-get -y update


######################################################################
# Graphviz and Dot 
# download source https://graphviz.gitlab.io/_pages/Download/Download_source.html
RUN git clone https://github.com/MomoSho/aiml_sym_dockerfile.git && \
	mv aiml_sym_dockerfile/graphviz.tar.gz . && \
	tar -xvf graphviz.tar.gz && \
	ls && \
	cd graphviz-2.40.1/ && \
	make && make install && \
	cd ..
#FROM alpine:3.8 RUN apk add --no-cache --update graphviz ttf-freefont


######################################################################
# Install nbgitpuller for syncing git files
RUN pip install nbgitpuller

######################################################################
# Install nbgrader and enable the extension
RUN pip install nbgrader
RUN jupyter nbextension install --sys-prefix --py nbgrader --overwrite
RUN jupyter nbextension enable --sys-prefix --py nbgrader
RUN jupyter serverextension enable --sys-prefix --py nbgrader


######################################################################
#FROM pvalsecc/docker-graphviz

