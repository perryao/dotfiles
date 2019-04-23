# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH=~/.oh-my-zsh

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="mh"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.

plugins=(
  git 
  tmux
  kubectl
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

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
#
alias v="/usr/local/bin/nvim"
alias v.="/usr/local/bin/nvim ."
source ~/.oh-my-zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

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

# check squid proxy
if (systemctl -q is-active squid.service)
    then
    echo "Squid Proxy is running."
    export_proxy_vars
fi

# auto launch tmux
# if [[ -z "$TMUX" ]]
# then
#     echo "Loading tmux"
#     ID="`tmux ls | grep -vm1 attached | cut -d: -f1`"
#     if [[ -z "$ID" ]]
#     then
#         tmux -2 new-session
#     else
#         # kill old sessions
#         tmux kill-session -t "$ID"
#         tmux -2 new-session
#         # tmux attach-session -t "$ID"
#     fi
# fi

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
[ -f /Users/anthonyperry/.travis/travis.sh ] && source /Users/anthonyperry/.travis/travis.sh

export N_PREFIX="$HOME/n"; [[ :$PATH: == *":$N_PREFIX/bin:"* ]] || PATH+=":$N_PREFIX/bin"  # Added by n-install (see http://git.io/n-install-repo).


# OS Specific config
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
[[ -f /home/mike/n/lib/node_modules/serverless/node_modules/tabtab/.completions/serverless.zsh ]] && . /home/mike/n/lib/node_modules/serverless/node_modules/tabtab/.completions/serverless.zsh
# tabtab source for sls package
# uninstall by removing these lines or running `tabtab uninstall sls`
[[ -f /home/mike/n/lib/node_modules/serverless/node_modules/tabtab/.completions/sls.zsh ]] && . /home/mike/n/lib/node_modules/serverless/node_modules/tabtab/.completions/sls.zsh
# added by travis gem
[ -f /home/mike/.travis/travis.sh ] && source /home/mike/.travis/travis.sh

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="/home/mike/.sdkman"
[[ -s "/home/mike/.sdkman/bin/sdkman-init.sh" ]] && source "/home/mike/.sdkman/bin/sdkman-init.sh"

# tabtab source for slss package
# uninstall by removing these lines or running `tabtab uninstall slss`
[[ -f /home/vagrant/n/lib/node_modules/serverless/node_modules/tabtab/.completions/slss.zsh ]] && . /home/vagrant/n/lib/node_modules/serverless/node_modules/tabtab/.completions/slss.zsh

autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /usr/bin/terraform terraform
