#RESOURCES
#https://hub.docker.com/r/jupyter/tensorflow-notebook/tags/
#https://zero-to-jupyterhub.readthedocs.io/en/latest/index.html#customization-guide
#https://github.com/jupyter/docker-stacks/blob/master/docs/using/selecting.md
#https://hub.docker.com/r/jupyter/tensorflow-notebook/dockerfile
#https://github.com/jupyter/docker-stacks/blob/master/datascience-notebook/Dockerfile

#ARG TAG=debugging-0.0.0
ARG GIT_COMMIT=unspecified
LABEL git_commit=$GIT_COMMIT

#FROM osgeo/proj

#ARG BASE_CONTAINER=jupyter/scipy-notebook
#ARG BASE_CONTAINER=jupyter/tensorflow-notebook
ARG BASE_CONTAINER=pupster90/io
#ARG BASE_CONTAINER=momosho/aiml
FROM $BASE_CONTAINER

# Install Tensorflow
#RUN conda install --quiet --yes \
#    'tensorflow=1.13*' \
#    'keras=2.2*' && \
#    conda clean --all -f -y && \
#    fix-permissions $CONDA_DIR && \
#    fix-permissions /home/$NB_USER

#RUN git clone https://github.com/thunderhoser/GewitterGefahr && \
#    cd GewitterGefahr && \
#    git checkout aiml2019_branch && \

RUN conda install -c conda-forge proj4 -y 
RUN conda install -c anaconda basemap

# UPDATE GewitterGefahr installation with aiml2019_branch
#RUN pip install -U pip && \
#    pip install ambhas && \
#    cd .. 
     
RUN git clone https://github.com/tkrajina/srtm.py && \
    cd srtm && \
    python setup.py install && \
    cd .. 

RUN apt-get -y update && \
    apt-get install -y libqt4-dev cmake xvfb
RUN conda install -c conda-forge pyside=1.2.4 && \
    git clone https://github.com/sharppy/SHARPpy.git && \
    cd SHARPpy  && \
    git pull origin master  && \
    python setup.py install  && \
    cd ..

RUN source activate base

RUN rm -rf GewitterGefahr && \
    git clone --single-branch --branch aiml2019_branch https://github.com/thunderhoser/GewitterGefahr && \
    cd GewitterGefahr && \
    python setup.py install && \
    cd ..

RUN git clone https://github.com/thunderhoser/GeneralExam && \
    cd GeneralExam && \
    git checkout era5_branch && \
    python setup.py install && \ 
    cd ..


RUN pip install nbgitpuller
RUN pip install nbgrader
RUN jupyter nbextension install --sys-prefix --py nbgrader --overwrite
RUN jupyter nbextension enable --sys-prefix --py nbgrader
RUN jupyter serverextension enable --sys-prefix --py nbgrader

# Set up shared data and notebook folders
#RUN sudo mkdir -p /srv/shared/data
#RUN sudo mkdir -p /srv/shared/nb
#RUN download_data.sh /srv/shared/

######################################################################
# Install git library dependencies
#mpl_toolkits matplotlib basemap
#RUN sudo apt-get install libgeos-c1v5 libgeos-dev
#RUN pip install --user git+https://github.com/matplotlib/basemap.git

