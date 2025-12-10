#!/usr/bin/env bash
set -e

repo_dir="$HOME/conf"
config_dir="$HOME/.config"
backup_dir="$HOME/.config_backup_$(date +%Y%m%d_%H%M%S)"

# Check for required dependencies
echo "checking dependencies..."
missing_deps=()

command -v git >/dev/null 2>&1 || missing_deps+=("git")
command -v tmux >/dev/null 2>&1 || missing_deps+=("tmux")
command -v nvim >/dev/null 2>&1 || missing_deps+=("nvim")
command -v fish >/dev/null 2>&1 || missing_deps+=("fish")

if [ ${#missing_deps[@]} -gt 0 ]; then
  echo "⚠️  Missing dependencies: ${missing_deps[*]}"
  echo ""
  
  install_cmd=""
  if [[ "$OSTYPE" == "darwin"* ]]; then
    if command -v brew >/dev/null 2>&1; then
      install_cmd="brew install ${missing_deps[*]}"
    else
      echo "Homebrew not found. Please install it first:"
      echo "  /bin/bash -c \"\$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)\""
      exit 1
    fi
  elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
    if command -v apt >/dev/null 2>&1; then
      install_cmd="sudo apt update && sudo apt install -y ${missing_deps[*]}"
    elif command -v yum >/dev/null 2>&1; then
      install_cmd="sudo yum install -y ${missing_deps[*]}"
    elif command -v pacman >/dev/null 2>&1; then
      install_cmd="sudo pacman -S --noconfirm ${missing_deps[*]}"
    fi
  fi
  
  if [ -n "$install_cmd" ]; then
    echo "Install command: $install_cmd"
    echo ""
    read -p "Install missing dependencies? (Y/n) " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Nn]$ ]]; then
      eval "$install_cmd"
    else
      read -p "Continue without installing? (y/N) " -n 1 -r
      echo
      if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        exit 1
      fi
    fi
  else
    read -p "Continue anyway? (y/N) " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
      exit 1
    fi
  fi
fi

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

echo ""
echo "✅ setup complete!"
echo ""
echo "Next steps:"
if command -v tmux >/dev/null 2>&1; then
  echo "  1. Start tmux and press C-a + I to install plugins"
fi
if command -v nvim >/dev/null 2>&1; then
  echo "  2. Open nvim - plugins will install automatically"
fi
