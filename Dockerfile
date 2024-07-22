FROM python:3.10

WORKDIR /app

RUN apt-get -yq update && apt-get -yq install git python3 python3-venv libgl1 libglib2.0-0 cmake protobuf-compiler xdg-utils

RUN git clone https://github.com/AUTOMATIC1111/stable-diffusion-webui.git .

# Disable TCMalloc warning
# TODO: Consider installing TCMalloc to see if the performance gains are significant
ENV NO_TCMALLOC="True"
ENV CKPT_DIR=/DATA/AppData/Stable-Diffusion-WebUI/models
ENV VAE_DIR=/DATA/AppData/Stable-Diffusion-WebUI/vae
ENV LORA_DIR=/DATA/AppData/Stable-Diffusion-WebUI/lora
ENV EMBEDDINGS_DIR=/DATA/AppData/Stable-Diffusion-WebUI/embeddings
ENV DATA_DIR=/DATA/AppData/Stable-Diffusion-WebUI

ENV API_ARGS="--listen --api --api-log --nowebui --disable-console-progressbars"
ENV DEFAULT_COMMANDLINE_ARGS="--data-dir ${DATA_DIR} --ckpt-dir ${CKPT_DIR} --vae-dir ${VAE_DIR} --lora-dir ${LORA_DIR} --embeddings-dir ${EMBEDDINGS_DIR} --no-hashing --do-not-download-clip --no-download-sd-model --precision full --no-half --skip-torch-cuda-test --use-cpu all --enable-insecure-extension-access"

ENV COMMANDLINE_ARGS="${DEFAULT_COMMANDLINE_ARGS} ${API_ARGS}"

COPY ./run.sh .

RUN mkdir -p /DATA/AppData/Stable-Diffusion-WebUI/models \
             /DATA/AppData/Stable-Diffusion-WebUI/vae \
             /DATA/AppData/Stable-Diffusion-WebUI/lora \
             /DATA/AppData/Stable-Diffusion-WebUI/embeddings \
             /DATA/AppData/Stable-Diffusion-WebUI

VOLUME ["/DATA/AppData/Stable-Diffusion-WebUI/models", "/DATA/AppData/Stable-Diffusion-WebUI/vae", "/DATA/AppData/Stable-Diffusion-WebUI/lora", "/DATA/AppData/Stable-Diffusion-WebUI/embeddings", "/DATA/AppData/Stable-Diffusion-WebUI"]

EXPOSE 7860

CMD ["bash", "run.sh"]
