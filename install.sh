#!/usr/bin/env bash
# set -e

# Install on every platform
# git, stow, python 2 + 3, python-pip, docker, zsh, nodejs, golang, tmux, vim with clipboard support
# kops, kubectl, awscli, terraform,
# chrome, firefox

setup_common () {
  if [ ! -d ~/.oh-my-zsh ]; then
    echo "Installing oh-my-zsh"
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/}/plugins/zsh-syntax-highlighting
    echo "Installed oh-my-zsh"
  fi

  if [ ! -d ~/dotfiles ]; then
    echo "Pulling down dotfiles"
    git clone https://github.com/perryao/dotfiles.git ~/dotfiles
    echo "Pulled dotfiles"
  fi
  # TODO: maybe git pull dotfiles to update them
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
  sudo apt-get update && sudo apt-get install python python3 python-pip python3-pip
  pip install awscli --upgrade --user
  setup_common
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
}

setup() {
  echo "Detecting OS"
  if [ -f "/etc/os-release" ]; then
    echo "on platform with /etc/os-release"
    name=$(cat /etc/os-release | grep ^NAME)
    case $name in
      *Debian*) echo "Debian" && setup_debian ;;
      "*Arch Linux") echo "Arch Linux" && setup_arch ;;
      *) echo "Unknown: $name" && exit -1;;
    esac
  elif [ $(uname -s) = Darwin ]; then
    echo "on mac"
    setup_mac
  fi
}
