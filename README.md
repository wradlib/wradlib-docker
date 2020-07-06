# wradlib-docker

This repo consists of two docker files:

- base/Dockerfile
    - builds the base image with the conda-forge installation (only if missing on docker-hub)
    - based on `centos:7`
    - basic x11 stack
    - su-exec
    - miniforge3 4.8.3-4

- Dockerfile
    - builds tags `min` and `full`
    - builds wradlib releases (prepending `X.Y.Z`) on tagged builds as well as latest `master` (prepending `master`) on non-tagged builds (via `cron`)
         - min
            - based on `base`
            - with activated conda-forge wradlib environment
        - full
            - based on `base`
            - added wradlib build dependencies + jupyter notebook
