FROM pytorch/pytorch:nightly-devel-cuda10.0-cudnn7

RUN apt-get update -y

ADD . /app

RUN pip install -r /app/requirements.txt

# For Apex to install correctly, a GPU device is required, and the default Docker
# runtime must be set to "nvidia".
# Follow these instructions to change the default runtime:
# https://lukeyeager.github.io/2018/01/22/setting-the-default-docker-runtime-to-nvidia.html
RUN cd /app/apex && \
    pip install -v \
        --no-cache-dir \
        --global-option="--cpp_ext" \
        --global-option="--cuda_ext" \
        .
