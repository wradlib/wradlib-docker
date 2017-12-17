# wradlib/wradlib-docker:training

## What

- wradlib/wradlib-docker:full_py36 based docker image
    - x11 stack
    - su-exec
    - miniconda3 python3.6
    - dedicated `wradlib` environment with python3.6
    - wradlib run dependencies
    - wradlib build dependencies
    - notebook
- special training dependencies

## Build

```shell
docker build -t training .
```

## Use

```shell
$ docker run -it --rm -p 8888:8888 -v /host/path/to/notebooks:/home/notebooks -v /host/path/to/wradlib-data:/home/wradlib-data -e LOCAL_USER_ID=$UID -e WRADLIB_DATA=/home/wradlib-data wradlib/wradlib-docker:training /opt/conda/envs/wradlib/bin/jupyter notebook --notebook-dir=/home/notebooks --ip='*' --port=8888 --no-browser
```

This command starts a docker container with the following presets:

- open port 8888 for notebook server connections
- mounts the host /host/path/to/notebooks to the /home/notebooks folder inside the container
- mounts the host `/host/path/to/wradlib-data` to the `/home/wradlib-data` folder inside the container
- sets the container LOCAL_USER to your current $UID which grants you write access to the mounted folders
- set the `WRADLIB_DATA` environment variable pointing to the specified folder
- start the notebook server
    - The full HTTP address including authentification token will be prompted in the notebook server log on the screen. Just connect with your local browser and you are done.
- removes the container after closing
