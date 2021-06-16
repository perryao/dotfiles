# vim: set ft=zsh:
source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/local/etc/zsh-kubectl-prompt/kubectl.zsh

source "/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc"
source "/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc"

# source homebrew autocomplete
if type brew &>/dev/null; then
  FPATH=$(brew --prefix)/share/zsh/site-functions:$FPATH

  autoload -Uz compinit
  compinit
fi

# Add Visual Studio Code (code)
export PATH="\$PATH:/Applications/Visual Studio Code.app/Contents/Resources/app/bin:$PATH"


# fix for jabba installed through homebrew
# see: https://github.com/shyiko/jabba/issues/452
JABBA_HOME=$HOME/.jabba
JABBA_HOME_TO_EXPORT=\$HOME/.jabba

_jabba() {
    local fd3=$(mktemp /tmp/jabba-fd3.XXXXXX)
    (JABBA_SHELL_INTEGRATION=ON `which jabba` "$@" 3>| ${fd3})
    local exit_code=$?
    eval $(cat ${fd3})
    rm -f ${fd3}
    return ${exit_code}
}

if [ ! -z "$(_jabba alias default)" ]; then
    _jabba use default
fi