#!/bin/sh
set -eu

repo_dir="$HOME/conf"
config_dir="$HOME/.config"
backup_dir="$HOME/.config_backup_$(date +%Y%m%d_%H%M%S)"
repo_url="https://github.com/hadikhamoud/conf.git"
os=$(uname -s)
missing_deps=""

run_root() {
  if [ "$(id -u)" -eq 0 ]; then
    "$@"
  else
    sudo "$@"
  fi
}

add_missing() {
  if [ -z "$missing_deps" ]; then
    missing_deps=$1
  else
    missing_deps="$missing_deps $1"
  fi
}

prompt_to_install() {
  if [ "${CONF_INSTALL_NONINTERACTIVE:-0}" = "1" ] || [ ! -r /dev/tty ]; then
    return 0
  fi

  printf 'Install missing dependencies? (Y/n) ' >/dev/tty
  IFS= read -r reply </dev/tty || reply=""
  case $reply in
    n|N|no|NO|No) return 1 ;;
    *) return 0 ;;
  esac
}

download_and_run() {
  installer_url=$1
  shift
  installer_file=$(mktemp)
  trap 'rm -f "$installer_file"' EXIT HUP INT TERM
  curl -fsSL "$installer_url" -o "$installer_file"
  sh "$installer_file" "$@"
  rm -f "$installer_file"
  trap - EXIT HUP INT TERM
}

install_atuin() {
  download_and_run https://setup.atuin.sh --non-interactive
}

install_zoxide() {
  download_and_run https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh
}

install_netbird() {
  if [ "$os" = "Darwin" ]; then
    brew install netbirdio/tap/netbird
  else
    SKIP_UI_APP=true download_and_run https://pkgs.netbird.io/install.sh
  fi
}

install_with_brew() {
  for dep in $missing_deps; do
    case $dep in
      nvim) brew install neovim ;;
      netbird) install_netbird ;;
      *) brew install "$dep" ;;
    esac
  done
}

install_with_apt() {
  run_root apt-get update
  for dep in $missing_deps; do
    case $dep in
      nvim) run_root apt-get install -y neovim ;;
      atuin)
        if apt-cache show atuin >/dev/null 2>&1; then
          run_root apt-get install -y atuin
        else
          install_atuin
        fi
        ;;
      zoxide)
        if apt-cache show zoxide >/dev/null 2>&1; then
          run_root apt-get install -y zoxide
        else
          install_zoxide
        fi
        ;;
      netbird) install_netbird ;;
      *) run_root apt-get install -y "$dep" ;;
    esac
  done
}

install_with_pacman() {
  for dep in $missing_deps; do
    case $dep in
      nvim) run_root pacman -S --needed --noconfirm neovim ;;
      netbird) install_netbird ;;
      *) run_root pacman -S --needed --noconfirm "$dep" ;;
    esac
  done
}

install_dependencies() {
  case $os in
    Darwin)
      if ! command -v brew >/dev/null 2>&1; then
        printf '%s\n' 'Homebrew is required on macOS: https://brew.sh' >&2
        exit 1
      fi
      install_with_brew
      ;;
    Linux)
      if command -v apt-get >/dev/null 2>&1; then
        install_with_apt
      elif command -v pacman >/dev/null 2>&1; then
        install_with_pacman
      else
        printf '%s\n' 'Unsupported Linux package manager (expected apt-get or pacman).' >&2
        exit 1
      fi
      ;;
    *)
      printf 'Unsupported operating system: %s\n' "$os" >&2
      exit 1
      ;;
  esac
}

backup_if_exists() {
  path=$1
  if [ -e "$path" ] && [ ! -L "$path" ]; then
    mkdir -p "$backup_dir"
    printf 'backing up %s to %s/\n' "$path" "$backup_dir"
    mv "$path" "$backup_dir/"
  fi
}

link_config() {
  source_path=$1
  target_path=$2
  label=$3

  if [ -L "$target_path" ]; then
    printf 'skipping %s (symlink already exists)\n' "$label"
    return
  fi

  backup_if_exists "$target_path"
  ln -s "$source_path" "$target_path"
  printf 'linked %s to %s\n' "$label" "$target_path"
}

set_fish_as_login_shell() {
  fish_path=$(command -v fish 2>/dev/null || true)
  [ -n "$fish_path" ] || return

  if ! grep -Fqx "$fish_path" /etc/shells 2>/dev/null; then
    run_root sh -c "printf '%s\\n' '$fish_path' >> /etc/shells"
  fi

  current_shell=${SHELL:-}
  if [ "$current_shell" != "$fish_path" ]; then
    run_root chsh -s "$fish_path" "$(id -un)"
    printf 'set %s as the login shell\n' "$fish_path"
  fi
}

printf '%s\n' 'checking dependencies...'
for dep in git tmux nvim fish zoxide atuin netbird; do
  command -v "$dep" >/dev/null 2>&1 || add_missing "$dep"
done

if [ -n "$missing_deps" ]; then
  printf 'Missing dependencies: %s\n' "$missing_deps"
  if prompt_to_install; then
    install_dependencies
  else
    printf '%s\n' 'Continuing without missing dependencies.'
  fi
fi

if [ ! -d "$repo_dir/.git" ]; then
  printf '%s\n' 'cloning conf repo...'
  git clone "$repo_url" "$repo_dir"
else
  printf '%s\n' 'repo already exists; pulling latest changes...'
  git -C "$repo_dir" pull
fi

mkdir -p "$config_dir"
printf '%s\n' 'linking configs...'
for dir in "$repo_dir"/*/; do
  [ -d "$dir" ] || continue
  name=$(basename "$dir")
  link_config "$dir" "$config_dir/$name" "$name"
done

if [ -f "$repo_dir/.tmux.conf" ]; then
  link_config "$repo_dir/.tmux.conf" "$HOME/.tmux.conf" '.tmux.conf'
fi

if [ ! -d "$HOME/.tmux/plugins/tpm" ]; then
  printf '%s\n' 'installing tmux plugin manager...'
  mkdir -p "$HOME/.tmux/plugins"
  git clone https://github.com/tmux-plugins/tpm "$HOME/.tmux/plugins/tpm"
  printf '%s\n' 'TPM installed. Start tmux and press C-a, then I, to install plugins.'
else
  printf '%s\n' 'TPM already installed'
fi

if command -v netbird >/dev/null 2>&1; then
  run_root netbird service install >/dev/null 2>&1 || true
  run_root netbird service start >/dev/null 2>&1 ||
    printf '%s\n' 'NetBird is installed, but its service could not be started.' >&2
fi

set_fish_as_login_shell

if [ -d "$backup_dir" ]; then
  printf '\nBackups created in: %s\n' "$backup_dir"
fi

printf '\n%s\n' 'setup complete!'
printf '%s\n' 'Restart tmux with: tmux kill-server 2>/dev/null || true; tmux'
printf '%s\n' 'Inside tmux, press C-a, then I, to install plugins.'
printf '%s\n' 'Log out and back in to start using Fish as your login shell.'
