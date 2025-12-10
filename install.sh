#!/usr/bin/env bash
set -e

repo_dir="$HOME/conf"
config_dir="$HOME/.config"
backup_dir="$HOME/.config_backup_$(date +%Y%m%d_%H%M%S)"

# Function to backup existing files/dirs
backup_if_exists() {
  local path="$1"
  if [ -e "$path" ] && [ ! -L "$path" ]; then
    mkdir -p "$backup_dir"
    echo "backing up $path → $backup_dir/"
    mv "$path" "$backup_dir/"
  fi
}

if [ ! -d "$repo_dir/.git" ]; then
  echo "cloning conf repo..."
  git clone git@github.com:hadikhamoud/conf.git "$repo_dir"
else
  echo "repo already exists — pulling latest changes..."
  git -C "$repo_dir" pull
fi

mkdir -p "$config_dir"

echo "linking configs..."
for dir in "$repo_dir"/*/; do
  name=$(basename "$dir")
  target="$config_dir/$name"
  if [ -L "$target" ]; then
    echo "skipping $name (symlink already exists)"
    continue
  fi
  backup_if_exists "$target"
  ln -s "$dir" "$target"
  echo "linked $name → $target"
done

# Link tmux.conf to home directory
if [ -f "$repo_dir/tmux.conf" ]; then
  if [ -L "$HOME/.tmux.conf" ]; then
    echo "skipping tmux.conf (symlink already exists)"
  else
    backup_if_exists "$HOME/.tmux.conf"
    ln -s "$repo_dir/tmux.conf" "$HOME/.tmux.conf"
    echo "linked tmux.conf → ~/.tmux.conf"
  fi
fi

# Install TPM (tmux plugin manager)
if [ ! -d "$HOME/.tmux/plugins/tpm" ]; then
  echo "installing tmux plugin manager..."
  mkdir -p "$HOME/.tmux/plugins"
  git clone https://github.com/tmux-plugins/tpm "$HOME/.tmux/plugins/tpm"
  echo "TPM installed. Start tmux and press C-a + I to install plugins."
else
  echo "TPM already installed"
fi

if [ -d "$backup_dir" ]; then
  echo ""
  echo "⚠️  Backups created in: $backup_dir"
fi

echo "setup complete."
