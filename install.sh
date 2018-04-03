#!/usr/bin/env bash
# set -e

# Install on every platform
# git, stow, python 2 + 3, python-pip, docker, zsh, nodejs, scala, golang, tmux, vim with clipboard support
# kops, kubectl, awscli, terraform,
# chrome, firefox

setup_common () {
  if [ ! -d ~/.oh-my-zsh ]; then
    echo "Installing oh-my-zsh"
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/plugins/zsh-syntax-highlighting
    echo "Installed oh-my-zsh"
  fi

  if [ ! -d ~/dotfiles ]; then
    echo "Pulling down dotfiles"
    git clone https://github.com/perryao/dotfiles.git ~/dotfiles
    echo "Pulled dotfiles"
  fi
  # TODO: maybe git pull dotfiles to update them
  # Require setting user.name and email per-repo
  git config --global user.useConfigOnly true

  # # Remove email address from global config:
  git config --global --unset-all user.email
}

setup_arch () {
  echo "setting up arch linux"
  # install networkmanager, xorg-server, xorg-xinit, openssh, gnome-keyring, ttf-croscoe, ttf-dejavu, systat, acpi, pulseaudio-alsa with pacman
  # install yaourt
  # install urxvt-unicode
  # install i3status, i3bar, i3lock
  # yaourt i3-gaps-git
  # yaourt ttf-font-awesome
  setup_commmon
}

setup_debian () {
  echo "setting up debian"
  if [ ! -f /etc/apt/sources.list.d/sbt.list ]; then
    echo "deb https://dl.bintray.com/sbt/debian /" | sudo tee -a /etc/apt/sources.list.d/sbt.list
  fi
  if [ ! -f /etc/apt/sources.list.d/vagrant.list ]; then
    echo "deb http://download.virtualbox.org/virtualbox/debian $(lsb_release -cs) contrib" | sudo tee -a /etc/apt/sources.list.d/vagrant.list
  fi

  if [ ! -f /etc/apt/sources.list.d/azure-cli.list ]; then
    echo "deb [arch=amd64] https://packages.microsoft.com/repos/azure-cli/ $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/azure-cli.list
  fi
  sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 2EE0EA64E40A89B84B2DF73499E82A75642AC823
  sudo apt-key adv --keyserver packages.microsoft.com --recv-keys 52E16F86FEE04B979B07E28DB02C46DF417A0893
  curl -fsSL https://download.docker.com/linux/$(. /etc/os-release; echo "$ID")/gpg | sudo apt-key add -
  curl -fsSl https://www.virtualbox.org/download/oracle_vbox_2016.asc | sudo apt-key add -
  sudo add-apt-repository \
       "deb [arch=amd64] https://download.docker.com/linux/$(. /etc/os-release; echo "$ID") \
             zesty \
             stable"
  sudo apt-add-repository ppa:ansible/ansible -y
  sudo apt-get update -y && sudo apt-get install -y \
    ansible \
    apt-transport-https \
    azure-cli \
    ca-certificates \
    curl \
    gnupg2 \
    software-properties-common \
    curl \
    jq \
    docker-ce \
    golang \
    openjdk-8-jdk \
    scala \
    sbt \
    python \
    python3 \
    python-pip \
    python3-pip \
    vim-gnome \
    silversearcher-ag \
    stow \
    zsh \
    tmux \
    unzip \
    virtualbox-5.2
  # install terraform
  terraform_url=$(curl https://releases.hashicorp.com/index.json | jq '{terraform}' | egrep "linux.*amd64" | sort --version-sort -r | head -1 | awk -F[\"] '{print $4}')
  packer_url=$(curl https://releases.hashicorp.com/index.json | jq '{packer}' | egrep "linux.*amd64" | sort --version-sort -r | head -1 | awk -F[\"] '{print $4}')
  vagrant_url=$(curl https://releases.hashicorp.com/index.json | jq '{vagrant}' | egrep "x86_64.*deb" | sort --version-sort -r | head -1 | awk -F[\"] '{print $4}')

  echo "Downloading $terraform_url."
  curl -o /tmp/terraform.zip $terraform_url
  # Unzip and install
  sudo unzip -o /tmp/terraform.zip -d /usr/local/bin

  echo "Downloading $packer_url"
  curl -o /tmp/packer.zip $packer_url
  sudo unzip -o /tmp/packer.zip -d /usr/local/bin

  echo "Downloading $vagrant_url"
  curl -o /tmp/vagrant.deb $vagrant_url
  sudo dpkg -i /tmp/vagrant.deb

  echo "Downloading kubectl"
  sudo curl -L -o /usr/local/bin/kubectl https://storage.googleapis.com/kubernetes-release/release/v1.9.0/bin/linux/amd64/kubectl
  sudo chmod +x /usr/local/bin/kubectl

  echo "Downloading kops"
  sudo curl -L -o /usr/local/bin/kops https://github.com/kubernetes/kops/releases/download/1.8.0/kops-linux-amd64
  sudo chmod +x /usr/local/bin/kops

  sudo getent group docker || (sudo groupadd docker && sudo usermod -aG docker $USER)
  sudo curl -L https://github.com/docker/compose/releases/download/1.18.0/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose
  sudo chmod +x /usr/local/bin/docker-compose
  pip install awscli --upgrade --user
  sudo chsh -s /usr/bin/zsh
  setup_common
  echo "Done"
}

setup_mac () {
  echo "setting up mac"
  # install brew
  if xcode-select -p ; then
    echo "command line tools already installed"
  else
    xcode-select --install
  fi
  brew update &>/dev/null || $(which ruby) -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  echo "Installed homebrew"
  brew bundle
  setup_common

  # apply one dark terminal theme
  /usr/libexec/PlistBuddy -c "add :'Window Settings':'One Dark' dict" ~/Library/Preferences/com.apple.Terminal.plist
  /usr/libexec/PlistBuddy -x -c "Merge /Users/$USER/dotfiles/themes/macos/One\ Dark.terminal 'Window Settings':'One Dark'" ~/Library/Preferences/com.apple.Terminal.plist
  #set Terminal defaults
  defaults write /Users/$USER/Library/Preferences/com.apple.Terminal.plist "Default Window Settings" "One Dark"
  defaults write /Users/$USER/Library/Preferences/com.apple.Terminal.plist "Startup Window Settings" "One Dark"

  #restart terminal to apply changes
  killall Terminal
  exit 0
}

setup() {
  echo "Detecting OS"
  if [ -f "/etc/os-release" ]; then
    echo "on platform with /etc/os-release"
    name=$(cat /etc/os-release | grep ^NAME)
    case $name in
      *Debian*) echo "Debian" && setup_debian ;;
      *Ubuntu*) echo "Ubuntu" && setup_debian ;;
      "*Arch Linux") echo "Arch Linux" && setup_arch ;;
      *) echo "Unknown: $name" && exit -1;;
    esac
  elif [ $(uname -s) = Darwin ]; then
    echo "on mac"
    setup_mac
  fi
}
