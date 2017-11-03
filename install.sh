#!/usr/bin/env bash
set -e

# Install on every platform
# git, stow, python 2 + 3, python-pip, docker, zsh, nodejs, golang, tmux, vim with clipboard support
# kops, kubectl, awscli, terraform,
# chrome, firefox

setup_common () {
  echo "Installing nvm"
  curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.5/install.sh | bash
  echo "nvm installed successfully"

  echo "Installing oh-my-zsh"
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/}/plugins/zsh-syntax-highlighting
  echo "Installed oh-my-zsh"

  echo "Pulling down dotfiles"
  git clone https://github.com/perryao/dotfiles.git ~/
  echo "Pulled dotfiles"
}

setup_arch () {
  echo "setting up arch linux"
  # install grub
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

install_mac () {
  echo "setting up mac"
  # install brew
  $(which ruby) -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  echo "Installed homebrew"
  brew cask install docker iterm2 postman
  setup_common
}

setup() {
  if [ -f "/etc/os-release" ]; then
    echo "on platform with /etc/os-release"
    name=$(cat /etc/os-release | grep ^NAME)
    case $name in
      *Debian*) echo "Debian" && setup_debian ;;
      "*Arch Linux") echo "Arch Linux" && setup_arch ;;
      *) echo "Unknown: $name" && exit -1;;
    esac
  fi
}

setup
