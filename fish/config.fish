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

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/hadihamoud/google-cloud-sdk/path.fish.inc' ]; . '/Users/hadihamoud/google-cloud-sdk/path.fish.inc'; end
