FROM nvidia/cuda:11.8.0-base-ubuntu22.04

# install build essentials
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    wget \
    curl \
    git

# Install python
RUN apt-get update && apt-get install -y --no-install-recommends python3 python3-venv python3-pip





##
## Ubuntu - Packages - Search
## https://packages.ubuntu.com/search?suite=xenial&section=all&arch=amd64&searchon=contents&keywords=Search
##

###
### solve for
### >>> WARNING - libGL.so not found, refer to CUDA Getting Started Guide for how to find and install them. <<<
### >>> WARNING - libX11.so not found, refer to CUDA Getting Started Guide for how to find and install them. <<<
### >>> WARNING - Xlib.h not found, refer to CUDA Getting Started Guide for how to find and install them. <<<
### >>> WARNING - gl.h not found, refer to CUDA Getting Started Guide for how to find and install them. <<<
###
### 2_Graphics/volumeFiltering
### 2_Graphics/simpleGL
### 2_Graphics/bindlessTexture
### 2_Graphics/volumeRender
### 2_Graphics/Mandelbrot
### 2_Graphics/marchingCubes
### 2_Graphics/simpleTexture3D
### 3_Imaging/imageDenoising
### 3_Imaging/recursiveGaussian
### 3_Imaging/simpleCUDA2GL
### 3_Imaging/postProcessGL
### 3_Imaging/bicubicTexture
### 3_Imaging/boxFilter
### 3_Imaging/SobelFilter
### 3_Imaging/cudaDecodeGL
### 3_Imaging/bilateralFilter
### 5_Simulations/particles
### 5_Simulations/smokeParticles
### 5_Simulations/oceanFFT
### 5_Simulations/fluidsGL
### 5_Simulations/nbody
### 6_Advanced/FunctionPointers
### 7_CUDALibraries/randomFog
###
RUN apt update && apt -y install libgl1-mesa-dev

###
### solve for
### >>> WARNING - libGLU.so not found, refer to CUDA Getting Started Guide for how to find and install them. <<<
### >>> WARNING - glu.h not found, refer to CUDA Getting Started Guide for how to find and install them. <<<
### 
RUN apt update && apt -y install libglu1-mesa-dev

###
### solve for
### /usr/bin/ld: cannot find -lglut
### https://stackoverflow.com/questions/15064159/usr-bin-ld-cannot-find-lglut
###
RUN apt update && apt -y install freeglut3-dev

### 
### solve for
### >>> WARNING - egl.h not found, please install egl.h <<<
### >>> WARNING - eglext.h not found, please install eglext.h <<<
### >>> WARNING - gl31.h not found, please install gl31.h <<<
###
### 2_Graphics/simpleGLES_EGLOutput
### 2_Graphics/simpleGLES
### 2_Graphics/simpleGLES_screen
### 5_Simulations/nbody_opengles
### 5_Simulations/fluidsGLES
### 5_Simulations/nbody_screen
###
RUN apt update && apt -y install libgles2-mesa-dev


###
### You should also search 'UBUNTU_PKG_NAME = "nvidia-367"' and replace it to 'UBUNTU_PKG_NAME = "nvidia"' 
### for all matched files in the NVIDIA_CUDA-8.0_Samples folder to make it works.
###
RUN mkdir /usr/lib/nvidia && \
    ### solve for  /usr/bin/ld: cannot find -lnvcuvid \
    ### 3_Imaging/cudaDecodeGL \
    ln -s /usr/local/nvidia/lib64/libnvcuvid.so.1 /usr/lib/nvidia/libnvcuvid.so && \
    ### solve for >>> WARNING - libEGL.so not found, please install libEGL.so <<< \
    ### 3_Imaging/EGLStreams_CUDA_Interop \
    ln -s /usr/local/nvidia/lib64/libEGL.so.1 /usr/lib/nvidia/libEGL.so && \
    ### solve for >>> WARNING - libGLES.so not found, please install libGLES.so <<< \
    ### 2_Graphics/simpleGLES_EGLOutput \
    ### 2_Graphics/simpleGLES \
    ### 2_Graphics/simpleGLES_screen \
    ### 5_Simulations/nbody_opengles \
    ### 5_Simulations/fluidsGLES \
    ### 5_Simulations/nbody_screen \
    ln -s /usr/local/nvidia/lib64/libGLESv2_nvidia.so.2 /usr/lib/nvidia/libGLESv2.so

RUN apt-get install -y libglib2.0-0 libgtk2.0-dev


# Setup the user
ENV USER_NAME=th
ENV GROUP_NAME=th
ENV HOME=/var/home/$USER_NAME

# Create the home directory for the new user.
RUN mkdir -p $HOME

# Create a user so our program doesn't run as root.
# For debian based linux
RUN groupadd -r $GROUP_NAME &&\
    useradd -r -g $GROUP_NAME -d $HOME -s /sbin/nologin -c "Docker image user" $USER_NAME
    
## SETTING UP THE APP ##
WORKDIR $HOME

# (Optional) Copy in the application code.
# ADD . $HOME

# Chown all the files to the user.
RUN chown -R $USER_NAME:$GROUP_NAME $HOME

# Change to the user.
USER $USER_NAME

# Install stable diffusion UI
RUN git clone https://github.com/AUTOMATIC1111/stable-diffusion-webui

WORKDIR $HOME/stable-diffusion-webui

RUN pip3 install torch==1.13.1+cu117 torchvision==0.14.1+cu117 --extra-index-url https://download.pytorch.org/whl/cu117
#RUN ./webui.sh

ENV PATH="/var/home/th/.local/bin:${PATH}"

