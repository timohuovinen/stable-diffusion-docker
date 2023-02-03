build:
	sudo docker build . -t sdui

run:
	sudo docker run --gpus all --rm -it --network host \
		-v ${PWD}/stable-diffusion-webui:/var/home/th/stable-diffusion-webui \
		sdui bash
