#!/bin/bash
pip install -U "huggingface_hub[cli]"
# Base directories
WORKSPACE_DIR="/workspace"
COMFYUI_DIR="${WORKSPACE_DIR}/ComfyUI"
MODELS_DIR="${COMFYUI_DIR}/models"
CLIP_DIR="${MODELS_DIR}/clip"
VAE_DIR="${MODELS_DIR}/vae"
DIFFUSION_MODELS_DIR="${MODELS_DIR}/diffusion_models"

# Create directories if they don't exist
mkdir -p "${CLIP_DIR}" "${VAE_DIR}" "${DIFFUSION_MODELS_DIR}"

# Download T5 XXL fp8 into ComfyUI/models/clip
MODEL_FILE="${CLIP_DIR}/flan-t5-xxl-fp16.safetensors"
if [ -f "$MODEL_FILE" ]; then
    echo "Skipping T5 XXL fp8 model (already exists)."
else
    echo "Downloading T5 XXL fp8 model..."
    hf download silveroxides/flan-t5-xxl-encoder-only flan-t5-xxl-fp16.safetensors --local-dir "${CLIP_DIR}"
fi

# Download FLUX VAE into ComfyUI/models/vae
MODEL_FILE="${VAE_DIR}/ae.safetensors"
if [ -f "$MODEL_FILE" ]; then
    echo "Skipping FLUX VAE model (already exists)."
else
    echo "Downloading FLUX VAE model..."
    hf download lodestones/Chroma ae.safetensors --local-dir "${VAE_DIR}"
fi

# Download Chroma checkpoint into ComfyUI/models/diffusion_models
MODEL_FILE="${DIFFUSION_MODELS_DIR}/Chroma1-HD-Flash.safetensors"
if [ -f "$MODEL_FILE" ]; then
    echo "Skipping Chroma1-HD-Flash checkpoint (already exists)."
else
    echo "Downloading Chroma1-HD-Flash checkpoint..."
    hf download lodestones/Chroma1-Flash Chroma1-HD-Flash.safetensors --local-dir "${DIFFUSION_MODELS_DIR}"
fi

MODEL_FILE="${DIFFUSION_MODELS_DIR}/Chroma1-HD.safetensors"
if [ -f "$MODEL_FILE" ]; then
    echo "Skipping Chroma1-HD checkpoint (already exists)."
else
    echo "Downloading Chroma1-HD checkpoint..."
    hf download lodestones/Chroma1-HD Chroma1-HD.safetensors --local-dir "${DIFFUSION_MODELS_DIR}"
fi

echo "All models checked/downloaded successfully!"
