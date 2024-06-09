FROM python:3.10

WORKDIR /app

# Install dependencies
RUN apt-get -yq update && apt-get -yq install git python3 python3-venv libgl1 libglib2.0-0

# HACK: Isn't this a bad practice?
RUN git clone https://github.com/AUTOMATIC1111/stable-diffusion-webui.git .

# Disable TCMalloc warning
# TODO: Consider installing TCMalloc to see if the performance gains are significant
ENV NO_TCMALLOC="True"
ENV CKPT_DIR=/model/checkpoints
ENV VAE_DIR=/model/vae
ENV LORA_DIR=/model/lora
ENV EMBEDDINGS_DIR=/model/embeddings
ENV DEFAULT_COMMANDLINE_ARGS="--no-download-sd-model --listen --ckpt-dir ${CKPT_DIR} --vae-dir ${VAE_DIR} --lora-dir ${LORA_DIR} --embeddings-dir ${EMBEDDINGS_DIR} --api --api-log --no-hashing"
# Consider --disable-console-progressbars
# Also consider --nowebui

# Set flags to install and exit, do not download default model, use CPU
# Unused due to install step being disabled to save on image size
# ENV INSTALL_COMMANDLINE_ARGS="--exit --use-cpu all --precision full --no-half --skip-torch-cuda-test"

# Run automatic1111 in installation mode
# TODO: Disabled to save ~5GB on image size. See if there's a reasonable compromise here.
# ENV COMMANDLINE_ARGS="${INSTALL_COMMANDLINE_ARGS} ${DEFAULT_COMMANDLINE_ARGS}"
# RUN bash ./webui.sh -f

# Reset ENVs for production usage
ENV COMMANDLINE_ARGS=${DEFAULT_COMMANDLINE_ARGS}

# Copy our run script to the working directory to deal with issues such as venv initialization
COPY ./run.sh .

EXPOSE 7860

CMD ["bash", "run.sh"]
