

build image

```sh
make build
```

Run

```
make run
```

Verify it works:

```sh
cd stable-diffusion-webui/
./webui.sh
```



other attempts:
```
sudo docker run -ti --device /dev/nvidia0:/dev/nvidia0 --device /dev/nvidiactl:/dev/nvidiactl --device /dev/nvidia-uvm:/dev/nvidia-uvm tleyden5iwx/ubuntu-cuda /bin/bash





sudo docker run --rm --gpus all nvidia/cuda:11.8.0-base-ubuntu22.04 nvidia-smi
```



sources:
* https://stackoverflow.com/a/46362272/175071
* https://stackoverflow.com/questions/22360771/missing-recommended-library-libglu-so
* https://stackoverflow.com/questions/25185405/using-gpu-from-a-docker-container 
* https://github.com/NVIDIA/nvidia-docker
* https://towardsdatascience.com/how-to-properly-use-the-gpu-within-a-docker-container-4c699c78c6d1 
* https://github.com/NVIDIA/nvidia-docker/issues/1711
