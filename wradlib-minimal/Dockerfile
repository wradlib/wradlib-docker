FROM centos:7

MAINTAINER wradlib <wradlib@wradlib.org>

USER root

# update und install needed system dependencies
RUN yum update -y
RUN yum install -y bzip2 mesa-libGL mesa-dri-drivers qt5-qtbase-gui xterm Xvfb
RUN yum clean all

# configure environment
ENV CONDA_DIR=/opt/conda
ENV PATH=$CONDA_DIR/bin:$PATH
ENV SHELL=/bin/bash
ENV LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8 LANGUAGE=en_US.UTF-8

# install latest Miniconda3
RUN curl -LO https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh && \
    /bin/bash Miniconda3-latest-Linux-x86_64.sh -b -p $CONDA_DIR && \
    rm Miniconda3-latest-Linux-x86_64.sh && \
    conda config --set show_channel_urls True && \
    conda config --add channels conda-forge && \
    conda update --all --yes && \
    conda clean -tipy

# install wradlib dependencies
RUN conda create --yes -n wradlib \
    gdal \
    numpy \
    scipy \
    matplotlib \
    netcdf4 \
    h5py \
    xmltodict && \
    conda clean -tipy

# install wradlib
RUN source activate wradlib && \
    pip install https://github.com/wradlib/wradlib/archive/v0.10.0.zip

EXPOSE 8888 8889

# configure startup
CMD ["/usr/bin/xterm"]
