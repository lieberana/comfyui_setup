#!/bin/bash
# ComfyUI Environment Setup Script
# Instructions for future use:
# 1. Initialize Conda in the shell: /workspace/miniconda3/bin/conda init bash
# 2. Activate the environment: conda activate comfyui
# 3. Start ComfyUI: python main.py --listen


echo "
========================================
🚀 Initializing ComfyUI Environment Setup...
========================================
"

# Step 1: Create essential directories
echo "
----------------------------------------
📁 Setting up directories...
----------------------------------------"
mkdir -p /workspace/ComfyUI
mkdir -p /workspace/miniconda3
mkdir -p /workspace/ComfyUI/models/checkpoints  # Directory for diffusion models

# Step 2: Install Miniconda if not already installed
echo "
----------------------------------------
📥 Installing Miniconda (if required)...
----------------------------------------"
if [ ! -f "/workspace/miniconda3/bin/conda" ]; then
    cd /workspace/miniconda3
    wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
    chmod +x Miniconda3-latest-Linux-x86_64.sh
    ./Miniconda3-latest-Linux-x86_64.sh -b -p /workspace/miniconda3 -f
else
    echo "Miniconda is already installed. Skipping installation..."
fi

# Step 3: Initialize Conda in the shell
echo "
----------------------------------------
🐍 Configuring Conda for the shell...
----------------------------------------"
eval "$(/workspace/miniconda3/bin/conda shell.bash hook)"

# Step 4: Clone the core ComfyUI repository
echo "
----------------------------------------
📥 Downloading ComfyUI repository...
----------------------------------------"
if [ ! -d "/workspace/ComfyUI/.git" ]; then
    git clone https://github.com/comfyanonymous/ComfyUI.git /workspace/ComfyUI
else
    echo "ComfyUI repository already exists. Skipping download..."
fi

# Step 5: Create a dedicated Conda environment for ComfyUI
echo "
----------------------------------------
🌟 Setting up the Conda environment...
----------------------------------------"
if ! conda info --envs | grep -q "comfyui"; then
    conda create -n comfyui python=3.11 -y
else
    echo "Conda environment 'comfyui' already exists. Skipping creation..."
fi

# Step 6: Install dependencies and prepare ComfyUI
echo "
----------------------------------------
🔧 Installing dependencies...
----------------------------------------"
conda activate comfyui
if [ "$CONDA_DEFAULT_ENV" != "comfyui" ]; then
    echo "❌ Failed to activate the 'comfyui' environment."
    exit 1
fi

cd /workspace/ComfyUI
pip install -r requirements.txt

echo "✅ Dependencies installed successfully."

# Step 7: Download the model
echo "
----------------------------------------
📥 Downloading diffusion model...
----------------------------------------"
MODEL_URL="<MODEL_DOWNLOAD_URL>"  # Replace with the actual model URL
MODEL_DIR="/workspace/ComfyUI/models/checkpoints"
if [ ! -f "$MODEL_DIR/<MODEL_FILENAME>" ]; then  # Replace <MODEL_FILENAME> with the actual file name
    cd $MODEL_DIR
    wget $MODEL_URL
    echo "✅ Diffusion model downloaded successfully."
else
    echo "Diffusion model already exists. Skipping download..."
fi

# Step 8: Deactivate the environment
echo "
----------------------------------------
🔄 Exiting the Conda environment...
----------------------------------------"
conda deactivate

echo "
========================================
✨ ComfyUI Setup Complete! ✨
========================================
"