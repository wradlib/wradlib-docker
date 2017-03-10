# wradlib minimal

Small working miniconda3 python3.6 with functional wradlib installation.

# Build

```shell
cd wradlib-minimal
docker build -t wradlib-minimal
```

# Use

```shell
$ docker run -it wradlib-minimal
[root@containerId /]# source activate wradlib
[root@containerId /]# python
```