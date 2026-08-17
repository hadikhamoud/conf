#!/bin/sh
set -eu

root=$(CDPATH= cd -- "$(dirname "$0")/.." && pwd)
tmp=$(mktemp -d)
trap 'rm -rf "$tmp"' EXIT HUP INT TERM

fail() {
  printf 'FAIL: %s\n' "$1" >&2
  exit 1
}

test_installer_runs_with_sh() {
  home="$tmp/home"
  bin="$tmp/bin"
  mkdir -p "$home/conf/.git" "$home/conf/fish" "$home/conf/nvim"
  mkdir -p "$home/.tmux/plugins/tpm" "$bin"
  : >"$home/conf/.tmux.conf"

  for command_name in git tmux nvim fish zoxide atuin netbird; do
    cat >"$bin/$command_name" <<'EOF'
#!/bin/sh
exit 0
EOF
    chmod +x "$bin/$command_name"
  done

  cat >"$bin/chsh" <<EOF
#!/bin/sh
printf '%s\n' "\$*" >"$tmp/chsh.args"
EOF
  chmod +x "$bin/chsh"

  cat >"$bin/uname" <<'EOF'
#!/bin/sh
printf 'Linux\n'
EOF
  cat >"$bin/sudo" <<'EOF'
#!/bin/sh
exec "$@"
EOF
  cat >"$bin/grep" <<'EOF'
#!/bin/sh
exit 0
EOF
  chmod +x "$bin/uname" "$bin/sudo" "$bin/grep"

  PATH="$bin:/usr/bin:/bin" HOME="$home" SHELL=/bin/sh \
    /bin/dash <"$root/install.sh" >"$tmp/install.out" 2>"$tmp/install.err" || {
      cat "$tmp/install.err" >&2
      fail 'install.sh must run when piped to sh'
    }

  [ -L "$home/.tmux.conf" ] || fail 'installer did not link .tmux.conf'
  [ "$(readlink "$home/.tmux.conf")" = "$home/conf/.tmux.conf" ] ||
    fail 'installer linked the wrong tmux config'
  [ -f "$tmp/chsh.args" ] || fail 'installer did not set fish as the login shell'
}

test_fish_starts_without_optional_files() {
  fish_bin=$(command -v fish || true)
  [ -n "$fish_bin" ] || return 0

  home="$tmp/fish-home"
  config="$tmp/config"
  mkdir -p "$home" "$config"
  ln -s "$root/fish" "$config/fish"

  HOME="$home" XDG_CONFIG_HOME="$config" PATH=/usr/bin:/bin \
    "$fish_bin" -i -c exit >"$tmp/fish.out" 2>"$tmp/fish.err" ||
    fail 'fish config failed to load'

  [ ! -s "$tmp/fish.err" ] || {
    cat "$tmp/fish.err" >&2
    fail 'fish config emitted startup errors without optional files'
  }
}

test_installer_runs_with_sh
test_fish_starts_without_optional_files
printf 'PASS: installer and fish startup tests\n'
