FROM centos:7

MAINTAINER wradlib <wradlib@wradlib.org>

USER root

# Update und install needed system dependencies
RUN yum update -y && \
    yum install -y mesa-libGL mesa-dri-drivers qt5-qtbase-gui Xvfb xterm && \
    yum clean -y all

# Install su-exec from github-repo
RUN buildDeps="gcc \
               unzip \
               make" && \
    yum install -y ${buildDeps} && \
    DIR=$(mktemp -d) && cd ${DIR} && \
    curl -LO https://github.com/ncopa/su-exec/archive/master.zip && \
    unzip master.zip && cd su-exec-master && \
    make && \
    cp su-exec /usr/local/bin/su-exec && \
    cd / && \
    rm -rf ${DIR} && \
    yum history -y undo last && \
    yum clean all && \
    rm -rf /var/lib/yum/*

# Configure environment
ENV CONDA_DIR /opt/conda
ENV PATH $CONDA_DIR/bin:$PATH
ENV SHELL /bin/bash
ENV LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8 LANGUAGE=en_US.UTF-8

# Configure Miniconda3
ENV MINICONDA_VER 4.3.11
ENV MINICONDA Miniconda3-$MINICONDA_VER-Linux-x86_64.sh
ENV MINICONDA_URL https://repo.continuum.io/miniconda/$MINICONDA
ENV MINICONDA_MD5_SUM 1924c8d9ec0abf09005aa03425e9ab1a

# Install Miniconda3
RUN buildDeps="bzip2" && \
    yum install -y ${buildDeps} && \
    curl -LO $MINICONDA_URL && \
    /bin/bash $MINICONDA -f -b -p $CONDA_DIR && \
    echo "$MINICONDA_MD5_SUM  $MINICONDA" | md5sum -c && \
    rm $MINICONDA && \
    yum history -y undo last && \
    yum clean all && \
    rm -rf /var/lib/yum/* && \
    conda config --set show_channel_urls True && \
    conda config --add channels conda-forge && \
    conda update --all --yes && \
    conda clean -tipy

COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
CMD ["/bin/bash"]
