#RESOURCES
#https://hub.docker.com/r/jupyter/tensorflow-notebook/tags/
#https://zero-to-jupyterhub.readthedocs.io/en/latest/index.html#customization-guide
#https://github.com/jupyter/docker-stacks/blob/master/docs/using/selecting.md
#https://hub.docker.com/r/jupyter/tensorflow-notebook/dockerfile
#https://github.com/jupyter/docker-stacks/blob/master/datascience-notebook/Dockerfile

#ARG TAG=debugging-0.0.0
#ARG GIT_COMMIT=unspecified
#LABEL git_commit=$GIT_COMMIT

#FROM osgeo/proj

#ARG BASE_CONTAINER=jupyter/scipy-notebook
#ARG BASE_CONTAINER=jupyter/tensorflow-notebook
#ARG BASE_CONTAINER=momosho/aiml
ARG BASE_CONTAINER=pupster90/io
FROM $BASE_CONTAINER

#RUN git clone https://github.com/thunderhoser/GewitterGefahr && \
#    cd GewitterGefahr && \
#    git checkout aiml2019_branch && \

# PROJ is a depenedency for Basemap 
RUN conda install -c conda-forge proj4 -y 
# Basemap is a dependency for GewitterGefahr/GeneralExam
RUN conda install -c anaconda basemap -y

# UPDATE GewitterGefahr installation with aiml2019_branch
RUN pip install -U pip && \
    pip install ambhas

# SRTM is a dependency for GewitterGefahr
RUN git clone https://github.com/tkrajina/srtm.py.git && \
    cd srtm.py && \
    python setup.py install && \
    cd .. 

RUN apt-get -y update
RUN apt-get install python3.3
RUN apt-get install -y libqt4-dev cmake xvfb
#RUN conda install -c conda-forge pyside -y && \
RUN pip install pyside && \
    git clone https://github.com/sharppy/SHARPpy.git && \
    cd SHARPpy  && \
    git pull origin master  && \
    python setup.py install  && \
    cd ..

# Activate conda environment for Basemap
RUN source activate base

# UPDATE GewitterGefahr installation with aiml2019_branch
RUN git clone --single-branch --branch aiml2019_branch https://github.com/thunderhoser/GewitterGefahr && \
    cd GewitterGefahr && \
    python setup.py install && \
    cd ..

RUN git clone https://github.com/thunderhoser/GeneralExam && \
    cd GeneralExam && \
    git checkout era5_branch && \
    python setup.py install && \ 
    cd ..

RUN pip install nbgitpuller


######################################################################
# Install git library dependencies
#mpl_toolkits matplotlib basemap
#RUN sudo apt-get install libgeos-c1v5 libgeos-dev
#RUN pip install --user git+https://github.com/matplotlib/basemap.git
