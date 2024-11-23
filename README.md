# automatic1111-docker

A dockerized version of Automatic1111.

## Relevant Command Line Arguments

From: https://github.com/AUTOMATIC1111/stable-diffusion-webui/wiki/Command-Line-Arguments-and-Settings#all-command-line-arguments

- `--exit` Allows us to install then exit during build phase
- Model overrides
  - `--ckpt-dir <path>` Checkpoints - Specific training checkpoints for Stable Diffusion
  - `--vae-dir <path>` VAE - Allows for adjustments to Checkpoints
  - `--lora-dir <path>` LoRA - Allows adding new data for specific things, like a character, art style, or pose
  - `--embeddings-dir <path>` Embeddings - Similar to LoRAs, but has some nuances I don't fully understand yet
- `--port <port>` Allows overwriting the port
- `--api` Disables the web UI and runs purely in REST API mode
- `--api-auth <auth>` Allows setting username/password auth
  - For a single user, use `username:password`
  - For multiple users, comma-delimit: `u1:p1,u2:p2,u3:p3`
- `--api-log` Allows enabling of API logging for all requests
- `--nowebui` Allows running headless (no webui)
- `--no-hashing` Skips SHA-256 hashing, which is slow and not super helpful, see [automatic1111#13577](https://github.com/AUTOMATIC1111/stable-diffusion-webui/discussions/13577)
- `--no-download-sd-model` Skips downloading the SD1.5 model, which takes a significant amount of disk space for a Docker image, and should be loaded by volume mounts anyway
- `--theme dark` Set dark theme (useful when running w/ webui to not flashbang your eyes)
- `--disable-console-progressbars` Disable the progress bars in console when generating images
- `--precision full --no-half --skip-torch-cuda-test --use-cpu all --listen --enable-insecure-extension-access` For CPU us Only
