#!/bin/bash
#ComfyUI single environment setup

# Note: This is a one-time setup script.
# For subsequent RunPod server starts, follow these steps:
# 1. Initialize conda:
#    /workspace/miniconda3/bin/conda init bash
# 2. Activate the environment:
#    conda activate comfyui
# 3. Launch ComfyUI:
#    python main.py --listen

echo "
========================================
🚀 Starting ComfyUI setup...
========================================
"

# Create base directories
echo "
----------------------------------------
📁 Creating base directories...
----------------------------------------"
mkdir -p /workspace/ComfyUI
mkdir -p /workspace/miniconda3

# Download and install Miniconda
echo "
----------------------------------------
📥 Downloading and installing Miniconda...
----------------------------------------"
if [ ! -f "/workspace/miniconda3/bin/conda" ]; then
    cd /workspace/miniconda3
    wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
    chmod +x Miniconda3-latest-Linux-x86_64.sh
    ./Miniconda3-latest-Linux-x86_64.sh -b -p /workspace/miniconda3 -f
else
    echo "Miniconda already installed, skipping..."
fi

# Initialize conda in the shell
echo "
----------------------------------------
🐍 Initializing conda...
----------------------------------------"
eval "$(/workspace/miniconda3/bin/conda shell.bash hook)"

# Clone ComfyUI
echo "
----------------------------------------
📥 Cloning ComfyUI repository...
----------------------------------------"
if [ ! -d "/workspace/ComfyUI/.git" ]; then
    git clone https://github.com/comfyanonymous/ComfyUI.git /workspace/ComfyUI
else
    echo "ComfyUI already exists in /workspace/ComfyUI, skipping clone..."
fi

# Clone ComfyUI-Manager
echo "
----------------------------------------
📥 Installing ComfyUI-Manager...
----------------------------------------"
if [ ! -d "/workspace/ComfyUI/custom_nodes/ComfyUI-Manager/.git" ]; then
    git clone https://github.com/ltdrdata/ComfyUI-Manager.git /workspace/ComfyUI/custom_nodes/ComfyUI-Manager
else
    echo "ComfyUI-Manager already exists, skipping clone..."
fi

# Create conda environment
echo "
----------------------------------------
🌟 Creating conda environment...
----------------------------------------"
if ! conda info --envs | grep -q "comfyui"; then
    conda create -n comfyui python=3.11 -y
else
    echo "comfyui environment already exists, skipping creation..."
fi

# Setup comfyui environment
echo "
----------------------------------------
🔧 Setting up comfyui environment...
----------------------------------------"
echo "🔄 Activating comfyui environment..."
conda activate comfyui

# Install requirements
cd /workspace/ComfyUI
echo "📦 Installing ComfyUI requirements..."
pip install -r requirements.txt

cd custom_nodes/ComfyUI-Manager
echo "📦 Installing ComfyUI-Manager requirements..."
pip install -r requirements.txt

# Optional: Model Downloads
# Uncomment the section below to download official FLUX models
# Note: FLUX models require Hugging Face token (https://huggingface.co/settings/tokens)
# Replace YOUR_TOKEN_HERE with your token before uncommenting
echo "
----------------------------------------
📥 Model downloads are commented out by default
----------------------------------------"
echo "To download official FLUX models:"
echo "1. Get your Hugging Face token from https://huggingface.co/settings/tokens"
echo "2. Replace YOUR_TOKEN_HERE in the script"
echo "3. Uncomment the model download section"

# # Download diffusion model
# echo "Downloading FLUX.1-dev diffusion model..."
# cd /workspace/ComfyUI/models/diffusion_models
# wget --header="Authorization: Bearer YOUR_TOKEN_HERE" https://huggingface.co/black-forest-labs/FLUX.1-dev/resolve/main/flux1-dev.safetensors

# # Download text encoders
# echo "Downloading text encoders..."
# cd /workspace/ComfyUI/models/text_encoders
# wget https://huggingface.co/comfyanonymous/flux_text_encoders/resolve/main/clip_l.safetensors
# wget https://huggingface.co/comfyanonymous/flux_text_encoders/resolve/main/t5xxl_fp16.safetensors

# # Download VAE
# echo "Downloading VAE..."
# cd /workspace/ComfyUI/models/vae
# wget --header="Authorization: Bearer YOUR_TOKEN_HERE" https://huggingface.co/black-forest-labs/FLUX.1-dev/resolve/main/vae/diffusion_pytorch_model.safetensors

# echo "✅ All models downloaded successfully."
# echo "Note: If any downloads failed, verify your token or check the model URLs."

# Return to base environment
echo "🔄 Deactivating comfyui environment..."
conda deactivate

echo "
========================================
✨ Setup complete! ✨
========================================
"