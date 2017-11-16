# wradlib using docker

## What

- centos:7 based docker image
- miniconda3 python3.6 with dedicated wradlib environment
- wradlib dependencies
- notebook dependencies
- x11 stack
- su-exec

## Where

- branch `master`: python 3.6
- branch `latest_py35`: python 3.5
- branch `latest_py27`: python 2.7
- branch `training`: special image for training purposes

## Build

Checkout the wanted branch and issue:

```shell
docker build -t wradlib .
```

## Use

```shell
$ docker run -i -t -p 8888:8888 -v /host/path/to/notebooks:/home/notebooks -v /host/path/to/wradlib-data:/home/wradlib-data -e WRADLIB_DATA=/home/wradlib-data wradlib:latest_py36 /opt/conda/envs/wradlib/bin/jupyter notebook --notebook-dir=/home/notebooks --ip='*' --port=8888 --no-browser
```

This command starts a docker container with the following presets:

- open port 8888 for notebook server connections
- mounts the host `/host/path/to/notebooks` to the `/home/notebooks` folder inside the container
- mounts the host `/host/path/to/wradlib-data` to the `/home/wradlib-data` folder inside the container
- set the `WRADLIB_DATA` environment variable pointing to the specified folder
- start the notebook server


The full HTTP address including authentification token will be prompted in the notebook server log on the screen. Just connect with your local browser and you are done.