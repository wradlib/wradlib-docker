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

# Configure Mambaforge
ENV MINIFORGE_VER 4.10.1-4
ENV MINIFORGE Mambaforge-${MINIFORGE_VER}-Linux-x86_64.sh
ENV MINIFORGE_URL https://github.com/conda-forge/miniforge/releases/download/${MINIFORGE_VER}/${MINIFORGE}
ENV MINIFORGE_SHA256_SUM 9eb335cb559644a6e462c077ebc129af51b7329817574fb707b994dafdddf2af

# Install Miniconda3
RUN buildDeps="bzip2" && \
    yum install -y ${buildDeps} && \
    curl -LO ${MINIFORGE_URL} && \
    /bin/bash ${MINIFORGE} -b -p ${CONDA_DIR} && \
    echo "$MINIFORGE_SHA256_SUM  $MINIFORGE" | sha256sum -c && \
    rm ${MINIFORGE} && \
    yum history -y undo last && \
    yum clean all && \
    rm -rf /var/lib/yum/* && \
    conda config --set show_channel_urls True && \
    conda config --add channels conda-forge && \
    conda config --set channel_priority strict && \
    conda update --all --yes && \
    conda clean -tipy && \
    find ${CONDA_DIR} -follow -type f -name '*.a' -delete && \
    find ${CONDA_DIR} -follow -type f -name '*.pyc' -delete && \
    conda clean -afy

COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
CMD ["/bin/bash"]
