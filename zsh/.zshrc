# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH=~/.oh-my-zsh

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="mh"

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

alias v="/usr/local/bin/nvim"
alias v.="/usr/local/bin/nvim ."
export GOPATH=$HOME/go
export PATH="$GOPATH/bin:/usr/local/go/bin:$PATH"
export PATH=$PATH:~/.cargo/bin

export_proxy_vars() {
  export http_proxy=http://localhost:3128
  export HTTP_PROXY=$http_proxy
  export https_proxy=http://localhost:3128
  export HTTPS_PROXY=$https_proxy
  export no_proxy="localhost,127.0.0.1,10.96.0.0/12,192.168.99.1/24,*.kroger.com"
  export NO_PROXY=$no_proxy
}

export EDITOR=$(which vim)
export PATH="$HOME/.yarn/bin:$PATH"
# for aws cli
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.gem/ruby/2.5.0/bin:$PATH"

# Python
#export WORKON_HOME=$HOME/.virtualenvs   # optional
#export PROJECT_HOME=$HOME/projects      # optional
#source /usr/bin/virtualenvwrapper.sh
#
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# added by travis gem
[ -f "$HOME/.travis/travis.sh" ] && source "$HOME/.travis/travis.sh"

export N_PREFIX="$HOME/n"; [[ :$PATH: == *":$N_PREFIX/bin:"* ]] || PATH+=":$N_PREFIX/bin"  # Added by n-install (see http://git.io/n-install-repo).


# OS Specific config
source "${ZDOTDIR:-${HOME}}/.zshrc-`uname`"
case `uname` in
  Darwin)
    # commands for OS X go here
    . `brew --prefix`/etc/profile.d/z.sh
  ;;
  Linux)
    # commands for Linux go here
  ;;
esac

# Helper Functions
checkport() {
  sudo lsof -n -i :$1| grep LISTEN
}

docker_proxy_on() {
  new_config="`cat ~/.docker/config.json | jq --arg http_proxy $http_proxy --arg https_proxy $https_proxy  '. + {proxies: {default: {httpProxy:$http_proxy, httpsProxy: $https_proxy, noProxy: "*.kroger.com"}}}'`"
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

if [ $commands[kubectl] ]; then
  source <(kubectl completion zsh)
fi

# tabtab source for serverless package
# uninstall by removing these lines or running `tabtab uninstall serverless`
[[ -f "$HOME/n/lib/node_modules/serverless/node_modules/tabtab/.completions/serverless.zsh" ]] && . "$HOME/n/lib/node_modules/serverless/node_modules/tabtab/.completions/serverless.zsh"
# tabtab source for sls package
# uninstall by removing these lines or running `tabtab uninstall sls`
[[ -f "$HOME/n/lib/node_modules/serverless/node_modules/tabtab/.completions/sls.zsh" ]] && . "$HOME/n/lib/node_modules/serverless/node_modules/tabtab/.completions/sls.zsh"
# tabtab source for slss package
# uninstall by removing these lines or running `tabtab uninstall slss`
[[ -f "$HOME/n/lib/node_modules/serverless/node_modules/tabtab/.completions/slss.zsh" ]] && ."$HOME/n/lib/node_modules/serverless/node_modules/tabtab/.completions/slss.zsh"

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /usr/bin/terraform terraform

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
