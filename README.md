# ComfyUI Environment Setup Script

This script automates the setup of ComfyUI. It wasprimarily tested on RunPod using the `pytorch:2.4.0-py3.11-cuda12.4.1` template. It can also work on other Linux-based systems with GPU support.

## Features

- Automates directory creation and environment setup
- Installs and configures Miniconda
- Creates a dedicated Conda environment for ComfyUI
- Installs dependencies for ComfyUI
- Optionally downloads diffusion models

## Usage Instructions

### RunPod Setup

1. Deploy a RunPod instance with the `pytorch:2.4.0-py3.11-cuda12.4.1` template
2. Connect via JupyterLab or SSH

### Script Execution

1. Clone the repository and make the script executable:

   ```bash
   git clone <REPO_URL>
   cd <REPO_NAME>
   chmod +x setup.sh
   ```

2. Run the setup script:
   ```bash
   ./setup.sh
   ```

### Post-Setup

1. Initialize Conda in the shell (once per new instance):

   ```bash
   /workspace/miniconda3/bin/conda init bash
   ```

2. Activate the environment:

   ```bash
   conda activate comfyui
   ```

3. Start ComfyUI:
   ```bash
   python main.py --listen
   ```

## Model Management

### Downloading Models

To download a diffusion model:

1. Update the `MODEL_URL` and `MODEL_FILENAME` variables in the script
2. The model will be downloaded to `/workspace/ComfyUI/models/checkpoints`

### Moving Models

To move models to a different directory:

```bash
mkdir -p /workspace/ComfyUI/models/checkpoints
mv /workspace/ComfyUI/models/diffusion_models/<MODEL_NAME>.safetensors /workspace/ComfyUI/models/checkpoints/<MODEL_NAME>.safetensors
```

## Notes

- This script is designed for RunPod but can be adapted for other environments
- For compatibility, ensure you use the correct RunPod template: `pytorch:2.4.0-py3.11-cuda12.4.1`
