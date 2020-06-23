FROM wradlib/wradlib-docker:base

MAINTAINER wradlib <wradlib@wradlib.org>

# Install wradlib dependencies
ARG WRADLIB_DOCKER_TAG
ENV WRL_DOCKER_TAG=${WRADLIB_DOCKER_TAG}
COPY environment_${WRL_DOCKER_TAG}.yml .
RUN conda run -n base conda install --quiet --yes nb_conda_kernels && \
    conda env create -f environment_${WRL_DOCKER_TAG}.yml && \
    conda run -n wradlib ipython kernel install --user --name=wradlib && \
    conda clean -tipy

# Install wradlib
ARG WRADLIB_VER
ENV WRL_VER=$WRADLIB_VER
ENV WRADLIB git+https://github.com/wradlib/wradlib.git@${WRL_VER}
SHELL ["conda", "run", "-n", "wradlib", "/bin/bash", "-c"]
RUN python -m pip install ${WRADLIB} --no-deps --ignore-installed --no-cache-dir

EXPOSE 8888 8889

COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
CMD ["/bin/bash"]
