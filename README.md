# wradlib-docker

This repo consists of two docker files:

- X.Y.Z-min
    - based on `centos:7`
    - basic x11 stack
    - su-exec
    - miniforge3 4.8.3-4
    - with activated conda-forge wradlib environment

- X.Y.Z-full
    - based on `wradlib:X.Y.Z-min`
    - added wradlib build dependencies + jupyter notebook
