if status is-interactive
    if command -q atuin
        atuin init fish | source
    end
    if command -q zoxide
        zoxide init fish | source
        alias cd='z'
    end
    alias oc='opencode'
    alias claud='CLAUDE_CODE_NO_FLICKER=1 claude --dangerously-skip-permissions'
    if test -f ~/.config/usgc_prof.sh
        bash ~/.config/usgc_prof.sh
    end
end


fish_add_path "$HOME/.local/bin" "$HOME/.atuin/bin" "$HOME/google-cloud-sdk/bin"
if command -q python3.11
    set -x CLOUDSDK_PYTHON (command -s python3.11)
end

set -gx PATH "/Users/hadihamoud/.local/state/fnm_multishells/77380_1772859005091/bin" $PATH;
set -gx FNM_MULTISHELL_PATH "/Users/hadihamoud/.local/state/fnm_multishells/77380_1772859005091";
set -gx FNM_VERSION_FILE_STRATEGY "local";
set -gx FNM_DIR "/Users/hadihamoud/.local/share/fnm";
set -gx FNM_LOGLEVEL "info";
set -gx FNM_NODE_DIST_MIRROR "https://nodejs.org/dist";
set -gx FNM_COREPACK_ENABLED "false";
set -gx FNM_RESOLVE_ENGINES "true";
set -gx FNM_ARCH "arm64";
# The next line updates PATH for the Google Cloud SDK.
if test -f "$HOME/google-cloud-sdk/path.fish.inc"
    source "$HOME/google-cloud-sdk/path.fish.inc"
end

# opencode
fish_add_path "$HOME/.opencode/bin"

# Raise open-file limit for dcf-etl local downloads (default macOS limit is too low for 200 concurrent downloads)
if test (uname) = Darwin
    ulimit -n 10240 2>/dev/null
end
