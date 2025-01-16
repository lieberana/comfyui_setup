# ComfyUI Environment Setup Script

A streamlined setup script for ComfyUI on RunPod, tested with the `pytorch:2.4.0-py3.11-cuda12.4.1` template.

## Quick Start

1. Clone and make executable:

```bash
git clone <REPO_URL>
cd <REPO_NAME>
chmod +x setup.sh
```

2. Optional: To download official FLUX models:

   - Get your [Hugging Face token](https://huggingface.co/settings/tokens)
   - Replace `YOUR_TOKEN_HERE` in the script
   - Uncomment the model download section

3. Run setup:

```bash
./setup.sh
```

## Post-Setup (Required for each new RunPod instance)

```bash
# Initialize conda
/workspace/miniconda3/bin/conda init bash

# Activate environment
conda activate comfyui

# Start ComfyUI
python main.py --listen
```

## Features

- Automated ComfyUI installation
- Miniconda environment setup
- ComfyUI-Manager integration
- Optional FLUX model downloads (commented by default)
