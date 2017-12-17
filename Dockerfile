FROM wradlib/wradlib-docker:base

MAINTAINER wradlib <wradlib@wradlib.org>

USER root

# Install wradlib + runtime dependencies
RUN conda create --yes -n wradlib \
    python=3.6 \
    wradlib=0.11.* \
    gdal \
    numpy \
    scipy \
    matplotlib \
    netcdf4 \
    h5py \
    xmltodict && \
    conda clean -tipy

# Install wradlib build dependencies
RUN source activate wradlib && \
    conda install --yes nbconvert \
    sphinx \
    numpydoc \
    sphinx_rtd_theme \
    pandoc \
    nbsphinx \
    flake8 \
    coverage \
    codecov \
    unzip && \
    pip install sphinxcontrib-bibtex && \
    conda clean -tipy

# Install jupyter and dependencies
RUN source activate wradlib && \
    conda install --yes notebook \
    jupyter \
    jupyter_contrib_nbextensions && \
    conda clean -tipy

# Install additional dependencies
RUN source activate wradlib && \
    conda install --yes opencv \
    pandas \
    scikit-image && \
    conda clean -tipy

EXPOSE 8888 8889

COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
CMD ["/bin/bash"]
