# build-nanogpt-from-scratch

A PyTorch-based, from-scratch implementation of the GPT-2 architecture, closely following the design patterns from Andrej Karpathy's `build-nanogpt` series. This repository serves as a foundational playground for understanding modern autoregressive language models, shifting from basic components to scaling on high-performance cloud compute.

## Core Features Implemented

- **Causal Self-Attention**: Native multi-head attention block leveraging PyTorch's `F.scaled_dot_product_attention` for FlashAttention efficiency.
- **Weight Sharing Scheme**: Linked the token embedding (`wte`) and language model head (`lm_head`) weights to reduce memory footprint and improve generalization.
- **Custom Parameter Initialization**: Proper normal distribution initialization ($\sigma = 0.02$) with special residual scaling factor ($1 / \sqrt{2 \times \text{n\_layer}}$) for blocks following GPT-2 specifications.
- **Pretrained Weights Alignment**: Built-in mechanism (`GPT.from_pretrained`) to seamlessly pull and transpose weights from Hugging Face's OpenAI GPT-2 checkpoints (124M up to 1.5B params).
- **Lightweight DataLoader**: Streamlined local token batching mechanism (`DataLoaderLite`) via `tiktoken` BPE encoding.

---

## Getting Started (Cloud & Local Setup)

This repository is optimized to run smoothly using `uv` (Rust-based ultra-fast package manager) without bloated environment commits.

### 1. Setup on Cloud (e.g., Lambda Labs A100/H100)

If you chose the **Lambda Stack** base image, foundational dependencies like CUDA and PyTorch are pre-installed globally. You can run the training loop instantly.

Clone the repository and spin up the script using `uv` to abstract dependencies on the fly:

```bash
# Clone this repository
git clone <your-repository-url>
cd build-nanogpt-from-scratch

# (Optional) Ensure input.txt is located under your specified path:
# e.g., mkdir -p v6-gpt && mv input.txt ./v6-gpt/

# Run via uv without messy global pip adjustments
uv run --with tiktoken train.py