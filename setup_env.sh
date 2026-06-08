#!/bin/bash
echo "🚀 Starting Environment Setup on Cloud Instance..."

# 1. Update package list
sudo apt-get update -y

# 2. Check if 'uv' (fast package manager) is installed, if not, fallback to standard venv
if ! command -v uv &> /dev/null
then
    echo "📦 'uv' not found. Setting up standard Python venv..."
    sudo apt-get install python3-venv -y
    python3 -m venv .venv
    source .venv/bin/activate
    pip install --upgrade pip
    pip install -r requirements.txt
else
    echo "⚡ 'uv' detected! Building ultra-fast isolated environment..."
    uv venv .venv
    source .venv/bin/activate
    uv pip install -r requirements.txt
fi

echo "✅ Setup Complete! To activate your environment, run: source .venv/bin/activate"