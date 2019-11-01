#FROM osgeo/proj

#ARG BASE_CONTAINER=jupyter/scipy-notebook
#ARG BASE_CONTAINER=jupyter/tensorflow-notebook
#ARG BASE_CONTAINER=momosho/aiml
ARG BASE_CONTAINER=pupster90/io
FROM $BASE_CONTAINER


RUN apt-get -y update


######################################################################
# Graphviz and Dot 
# download source https://graphviz.gitlab.io/_pages/Download/Download_source.html
#RUN git clone https://github.com/MomoSho/aiml_sym_dockerfile.git
#RUN mv aiml_sym_dockerfile/graphviz.tar.gz .
# untar 
#RUN tar -xvf graphviz.tar.gz && ls
#RUN cd graphviz-2.40.1/ && make && make install
#RUN cd ..
#FROM alpine:3.8 RUN apk add --no-cache --update graphviz ttf-freefont


######################################################################
# PROJ is a depenedency for Basemap 
RUN conda install -c conda-forge proj4 -y 
# Basemap is a dependency for GewitterGefahr/GeneralExam
RUN conda install -c anaconda basemap -y
# Activate conda environment for Basemap
#RUN source activate base

# UPDATE GewitterGefahr installation with aiml2019_branch
#RUN git clone https://github.com/thunderhoser/GewitterGefahr && \
#    cd GewitterGefahr && \
#    git checkout aiml2019_branch && \
RUN pip install -U pip && \
    pip install ambhas

# SRTM is a dependency for GewitterGefahr
RUN git clone https://github.com/tkrajina/srtm.py.git && \
    cd srtm.py && \
    python setup.py install && \
    cd .. 

RUN apt-get install -y libqt4-dev cmake xvfb
#RUN apt-get install -y python3.3
#RUN conda install -c conda-forge pyside -y && \
#RUN pip install pyside && \
#    git clone https://github.com/sharppy/SHARPpy.git && \
#    cd SHARPpy  && \
#    git pull origin master  && \
#    python setup.py install  && \
#    cd ..

# UPDATE GewitterGefahr installation with aiml2019_branch
RUN git clone --single-branch --branch aiml2019_branch https://github.com/thunderhoser/GewitterGefahr && \
    cd GewitterGefahr && \
    python setup.py install && \
    cd ..

# Install Ryan's GeneralExam with era5_branch
RUN git clone --single-branch --branch era5_branch https://github.com/thunderhoser/GeneralExam && \
    cd GeneralExam && \
    python setup.py install && \ 
    cd ..

RUN pip install nbgitpuller

######################################################################
# Install nbgrader and enable the extension
RUN pip install nbgrader
RUN jupyter nbextension install --sys-prefix --py nbgrader --overwrite
RUN jupyter nbextension enable --sys-prefix --py nbgrader
RUN jupyter serverextension enable --sys-prefix --py nbgrader


######################################################################
FROM pvalsecc/docker-graphviz

# Set up shared data and notebook folders
#RUN sudo mkdir -p /srv/shared/data
#RUN sudo mkdir -p /srv/shared/nb
#RUN download_data.sh /srv/shared/

######################################################################
# Install git library dependencies
#RUN sudo apt-get install libgeos-c1v5 libgeos-dev
#RUN pip install --user git+https://github.com/matplotlib/basemap.git
