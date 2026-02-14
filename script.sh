#!/bin/bash
set -e

echo "Updating system packages..."
sudo apt-get update
sudo apt-get upgrade -y
sudo apt-get install -y \
  git \
  wget \
  unzip \
  ffmpeg \
  build-essential \
  python3-venv

echo "Preparing NVMe directories..."
sudo mkdir -p /opt/dlami/nvme/tmp
sudo mkdir -p /opt/dlami/nvme/pip-cache

export TMPDIR=/opt/dlami/nvme/tmp
export PIP_CACHE_DIR=/opt/dlami/nvme/pip-cache

cd /opt/dlami/nvme

echo "Cloning ComfyUI..."
git clone https://github.com/Comfy-Org/ComfyUI.git
cd ComfyUI

echo "Creating Python virtual environment..."
python3 -m venv comfy-venv
source comfy-venv/bin/activate
pip install --upgrade pip
pip install --no-cache-dir -r requirements.txt

echo "Downloading WAN 2.2 models..."
wget -P models/text_encoders/ https://huggingface.co/Comfy-Org/Wan_2.1_ComfyUI_repackaged/resolve/main/split_files/text_encoders/umt5_xxl_fp8_e4m3fn_scaled.safetensors
wget -P models/vae/ https://huggingface.co/Comfy-Org/Wan_2.2_ComfyUI_Repackaged/resolve/main/split_files/vae/wan_2.1_vae.safetensors
wget -P models/diffusion_models/ https://huggingface.co/Comfy-Org/Wan_2.2_ComfyUI_Repackaged/resolve/main/split_files/diffusion_models/wan2.2_t2v_low_noise_14B_fp8_scaled.safetensors
wget -P models/diffusion_models/ https://huggingface.co/Comfy-Org/Wan_2.2_ComfyUI_Repackaged/resolve/main/split_files/diffusion_models/wan2.2_t2v_high_noise_14B_fp8_scaled.safetensors
wget -P models/loras/ https://huggingface.co/Comfy-Org/Wan_2.2_ComfyUI_Repackaged/resolve/main/split_files/loras/wan2.2_t2v_lightx2v_4steps_lora_v1.1_high_noise.safetensors
wget -P models/loras/ https://huggingface.co/Comfy-Org/Wan_2.2_ComfyUI_Repackaged/resolve/main/split_files/loras/wan2.2_t2v_lightx2v_4steps_lora_v1.1_low_noise.safetensors

echo "Downloading LTX-2 models..."
wget -P models/checkpoints/ https://huggingface.co/Lightricks/LTX-2/resolve/main/ltx-2-19b-dev-fp8.safetensors
wget -P models/text_encoders/ https://huggingface.co/Comfy-Org/ltx-2/resolve/main/split_files/text_encoders/gemma_3_12B_it_fp4_mixed.safetensors
wget -P models/latent_upscale_models/ https://huggingface.co/Lightricks/LTX-2/resolve/main/ltx-2-spatial-upscaler-x2-1.0.safetensors
wget -P models/loras/ https://huggingface.co/Lightricks/LTX-2/resolve/main/ltx-2-19b-distilled-lora-384.safetensors
wget -P models/loras/ https://huggingface.co/Lightricks/LTX-2-19b-LoRA-Camera-Control-Dolly-Left/resolve/main/ltx-2-19b-lora-camera-control-dolly-left.safetensors

echo "Downloading Hunyuan Video 1.5 models..."
wget -P models/text_encoders/ https://huggingface.co/Comfy-Org/HunyuanVideo_1.5_repackaged/resolve/main/split_files/text_encoders/qwen_2.5_vl_7b_fp8_scaled.safetensors
wget -P models/text_encoders/ https://huggingface.co/Comfy-Org/HunyuanVideo_1.5_repackaged/resolve/main/split_files/text_encoders/byt5_small_glyphxl_fp16.safetensors
wget -P models/diffusion_models/ https://huggingface.co/Comfy-Org/HunyuanVideo_1.5_repackaged/resolve/main/split_files/diffusion_models/hunyuanvideo1.5_1080p_sr_distilled_fp16.safetensors
wget -P models/vae/ https://huggingface.co/Comfy-Org/HunyuanVideo_1.5_repackaged/resolve/main/split_files/vae/hunyuanvideo15_vae_fp16.safetensors
wget -P models/diffusion_models/ https://huggingface.co/Comfy-Org/HunyuanVideo_1.5_repackaged/resolve/main/split_files/diffusion_models/hunyuanvideo1.5_720p_t2v_fp16.safetensors
wget -P models/latent_upscale_models/ https://huggingface.co/Comfy-Org/HunyuanVideo_1.5_repackaged/resolve/main/split_files/latent_upscale_models/hunyuanvideo15_latent_upsampler_1080p.safetensors

echo "Setup completed successfully."
echo "Activate the virtual environment and start ComfyUI when ready."

