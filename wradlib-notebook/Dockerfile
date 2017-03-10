FROM wradlib-minimal

MAINTAINER wradlib <wradlib@wradlib.org>

# install notebook
RUN source activate wradlib && \
    conda install --yes notebook && \
    conda clean -tipy
