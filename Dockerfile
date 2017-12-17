FROM wradlib/wradlib-docker:full_py36

MAINTAINER wradlib <wradlib@wradlib.org>

USER root

# Install additional dependencies
RUN source activate wradlib && \
    conda install --yes opencv \
    pandas \
    scikit-image && \
    conda clean -tipy

COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
CMD ["/bin/bash"]
