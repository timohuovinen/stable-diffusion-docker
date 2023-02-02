build:
	sudo docker build . -t sdui

run:
	sudo docker run --gpus all -it --network host -v ${PWD}/models:/var/home/th/stable-diffusion-webui/models/Stable-diffusion sdui bash
