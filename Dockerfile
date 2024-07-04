FROM python:3.10

WORKDIR /app

# Install dependencies
RUN apt-get -yq update && apt-get -yq install git python3 python3-venv libgl1 libglib2.0-0

# Clone repositories
RUN git clone https://github.com/AUTOMATIC1111/stable-diffusion-webui.git

# Set environment variables
ENV NO_TCMALLOC="True"
ENV MODELS_DIR=/DATA/AppData/Stable-Diffusion-WebUI/models
ENV OUTPUTS_DIR=/DATA/AppData/Stable-Diffusion-WebUI/outputs
ENV CONFIG_DIR=/DATA/AppData/Stable-Diffusion-WebUI/config
ENV CKPT_DIR=${MODELS_DIR}/checkpoints
ENV VAE_DIR=${MODELS_DIR}/vae
ENV LORA_DIR=${MODELS_DIR}/lora
ENV EMBEDDINGS_DIR=${MODELS_DIR}/embeddings

# Create necessary subdirectories
RUN mkdir -p ${MODELS_DIR} ${OUTPUTS_DIR} ${CONFIG_DIR} ${CKPT_DIR} ${VAE_DIR} ${LORA_DIR} ${EMBEDDINGS_DIR}

ENV API_ARGS="--listen --api --api-log"
ENV DEFAULT_COMMANDLINE_ARGS="--ckpt-dir ${CKPT_DIR} --vae-dir ${VAE_DIR} --lora-dir ${LORA_DIR} --embeddings-dir ${EMBEDDINGS_DIR} --no-hashing --do-not-download-clip --no-download-sd-model --precision full --no-half --skip-torch-cuda-test --use-cpu all --enable-insecure-extension-access --outdir ${OUTPUTS_DIR}"

# Set final command line arguments
ENV COMMANDLINE_ARGS="${DEFAULT_COMMANDLINE_ARGS} ${API_ARGS}"

# Copy run script
COPY ./run.sh .

EXPOSE 7860

CMD ["bash", "run.sh"]
