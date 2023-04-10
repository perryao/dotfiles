# Path to your oh-my-zsh installation.
export ZSH=~/.oh-my-zsh

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME=""
fpath+=$HOME/.zsh/pure
plugins=(
  git 
  tmux
  kubectl
  z
)
if [ $commands[fzf] ]; then
  export FZF_BASE=$(which fzf)
  plugins+=(fzf)
fi
ZSH_TMUX_AUTOSTART=true
ZSH_TMUX_AUTOSTART_ONCE=false
ZSH_TMUX_AUTOQUIT=true
ZSH_TMUX_AUTOCONNECT=false
source $ZSH/oh-my-zsh.sh

# autoload
autoload -U promptinit; promptinit
autoload -U colors; colors
autoload -U +X bashcompinit && bashcompinit

# theme
prompt pure

#completion
complete -o nospace -C /usr/local/bin/terraform terraform
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# aliases
alias v="/usr/local/bin/nvim"
alias v.="/usr/local/bin/nvim ."

for file in ~/.alias_*; do
    . "$file"
done

# OS Specific config
source "${ZDOTDIR:-${HOME}}/.`uname`.zshrc"
case `uname` in
  Darwin)
    # commands for OS X go here
    . `brew --prefix`/etc/profile.d/z.sh
  ;;
  Linux)
    # commands for Linux go here
  ;;
esac

if [ $commands[kubectl] ]; then
  source <(kubectl completion zsh)
fi

export FZF_DEFAULT_COMMAND='rg --files --hidden -g "!.git"'
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh


# shows k8s context in right prompt
RPROMPT='%{$fg[blue]%}($ZSH_KUBECTL_PROMPT)%{$reset_color%}'
# shows k8s context in left prompt
# PROMPT=$PROMPT'($ZSH_KUBECTL_PROMPT) '

# path
export GOPATH=$HOME/go
export PATH="$GOPATH/bin:/usr/local/go/bin:$PATH"
export PATH=$PATH:~/.cargo/bin
export PATH=~/.npm-global/bin:$PATH
export N_PREFIX="$HOME/n"; [[ :$PATH: == *":$N_PREFIX/bin:"* ]] || PATH="$N_PREFIX/bin:$PATH"  # Added by n-install (see http://git.io/n-install-repo).
export PATH="$HOME/.yarn/bin:$PATH"
# for aws cli
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.gem/ruby/2.5.0/bin:$PATH"

# for scalaenv: https://github.com/scalaenv/scalaenv#installation
export PATH="${HOME}/.scalaenv/bin:${PATH}"
eval "$(scalaenv init -)"

# for sbtenv: https://github.com/sbtenv/sbtenv#installation
export PATH="${HOME}/.sbtenv/bin:${PATH}"
eval "$(sbtenv init -)"

# for pyenv: https://github.com/pyenv/pyenv#homebrew-on-macos
eval "$(pyenv init --path)"
export PIPENV_VENV_IN_PROJECT="enabled"

export EDITOR=$(which nvim)

# Helper Functions
export_proxy_vars() {
  local minikube_no_proxy="10.96.0.0/12,192.168.99.0/24,192.168.39.0/24"
  export http_proxy=http://localhost:3128
  export HTTP_PROXY=$http_proxy
  export https_proxy=http://localhost:3128
  export HTTPS_PROXY=$https_proxy
  export no_proxy="localhost,127.0.0.1,$minikube_no_proxy"
  export NO_PROXY=$no_proxy
}

# Python
#export WORKON_HOME=$HOME/.virtualenvs   # optional
#export PROJECT_HOME=$HOME/projects      # optional
#source /usr/bin/virtualenvwrapper.sh
#

checkport() {
  sudo lsof -n -i :$1| grep LISTEN
}

killport() {
  PID=$(echo $(lsof -n -i4TCP:$1) | awk 'NR==1{print $11}')
  kill -9 $PID
}

docker_proxy_on() {
  new_config="`cat ~/.docker/config.json | jq --arg http_proxy $http_proxy --arg https_proxy $https_proxy  '. + {proxies: {default: {httpProxy:$http_proxy, httpsProxy: $https_proxy, noProxy: "localhost"}}}'`"
  echo $new_config > ~/.docker/config.json
}

proxy_on() {
  local new_config
  sudo systemctl start squid
  export_proxy_vars
  docker_proxy_on
  echo "proxy started"
}

docker_proxy_off() {
  new_config="`cat ~/.docker/config.json | jq 'del(.proxies)'`"
  echo $new_config > ~/.docker/config.json
}

# cat dockerconfigtest.json | jq 'del(.proxies)' | jq --arg http_proxy $http_proxy --arg https_proxy $https_proxy  '. + {proxies: {default: {httpProxy:$http_proxy, httpsProxy: $https_proxy}}}'
proxy_off() {
  local new_config
  sudo systemctl stop squid
  unset http_proxy
  unset HTTP_PROXY
  unset https_proxy
  unset HTTPS_PROXY
  unset no_proxy
  unset NO_PROXY
  # echo $(cat ~/.docker/config.json | jq 'del(.proxies)')
  docker_proxy_off
  echo "proxy stopped"
}

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

# OS Specific config that needs to run last
case `uname` in
  Darwin)
    # commands for OS X go here
    source ${HOMEBREW_PREFIX}/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
    source ${HOMEBREW_PREFIX}/share/zsh-autosuggestions/zsh-autosuggestions.zsh
    source ${HOMEBREW_PREFIX}/etc/zsh-kubectl-prompt/kubectl.zsh

    source ${HOMEBREW_PREFIX}/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc
    source ${HOMEBREW_PREFIX}/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc
  ;;
  Linux)
    # commands for Linux go here
  ;;
esac