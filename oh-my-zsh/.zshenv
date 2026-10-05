# ~/.zshenv — sourced by every zsh (interactive, login and scripts).
# Keep it minimal: only PATH entries that non-interactive tools also need.

# Drop duplicate PATH entries automatically (first occurrence wins).
typeset -U path PATH

path=("$HOME/.local/bin" $path)

# Rust toolchain (rustup/cargo)
[[ -f "$HOME/.cargo/env" ]] && . "$HOME/.cargo/env"

# Vite+ bin (https://viteplus.dev)
[[ -f "$HOME/.vite-plus/env" ]] && . "$HOME/.vite-plus/env"
