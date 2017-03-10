# wradlib notebook

Small working miniconda3 python3.6 with functional wradlib installation and jupyter notebook.

# Build

You would need to build wradlib-minimal first.

```shell
cd wradlib-notebook
docker build -t wradlib-notebook
```

# Use

```shell
$ docker run -i -t -p 8888:8888 -v /host/path/to/notebooks:/home/notebooks -v /host/path/to/wradlib-data:/home/wradlib-data -e WRADLIB_DATA=/home/wradlib-data wradlib-notebook /bin/bash -c "/opt/conda/envs/wradlib/bin/jupyter notebook --notebook-dir=/home/notebooks --ip='*' --port=8888 --no-browser"
```

This command starts a docker container with the following presets:

- open port 8888 for notebook server connections
- mounts the host `/host/path/to/notebooks` to the `/home/notebooks` folder inside the container
- mounts the host `/host/path/to/wradlib-data` to the `/home/wradlib-data` folder inside the container
- set the `WRADLIB_DATA` environment variable pointing to the specified folder
- start the notebook server


The full HTTP address including authentification token will be prompted in the notebook server log on the screen. Just connect with your local browser and you are done.