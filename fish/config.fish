if status is-interactive
    # Commands to run in interactive sessions can go here
    atuin init fish | source
    zoxide init fish | source
    alias cd='z'
    alias oc='opencode'
    bash ~/.config/usgc_prof.sh
    
    end


set -g PATH $PATH ~/google-cloud-sdk/bin
set -x CLOUDSDK_PYTHON (which python3.11)

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
if [ -f '/Users/hadihamoud/google-cloud-sdk/path.fish.inc' ]; . '/Users/hadihamoud/google-cloud-sdk/path.fish.inc'; end
