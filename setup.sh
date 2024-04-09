#!/bin/bash

set -e

install_tpm() {
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm || true
}

setup_tmux_conf() {
  cp -f "$HOME/configs/tmux.conf" "$HOME/.tmux.conf"
  echo "Tmux config added"
}

setup_alacritty() {
  cp -rf "$HOME/configs/config/alacritty"  "$HOME/.config/alacritty"
  echo "Alacritty config added"
}

setup_helix() {
  cp -rf  "$HOME/configs/config/helix"  "$HOME/.config/helix"
  echo "Helix config added"
}

setup_mac() {
  # setup zshrc
  cp -f "$HOME/configs/zshrc" "$HOME/.zshrc"

  # install starship
  which starship > /dev/null || (curl -sS https://starship.rs/install.sh | sh)
  cp -f "$HOME/configs/config/starship.toml" "$HOME/.config/starship.toml"
  
  # install brew
  which brew > /dev/null || /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  brew update

  # install hack-nerd-font
  which font-hack-nerd-font > /dev/null || brew install font-hack-nerd-font

  # install alacritty
  which alacritty > /dev/null || brew install alacritty
  setup_alacritty

  # install tmux
  which tmux > /dev/null || brew install tmux
  setup_tmux_conf
  install_tpm
  tmux -u
  echo "For install tmux plugins you need use Prefix+I shortcut"

  # install helix
  which hx > /dev/null || brew install helix
  setup_helix

  # install gitui
  which gitui > /dev/null || brew install gitui
}

setup_ubuntu() {
  echo "On linux you must have 'sudo'"
  sudo apt update
  sudo apt install zsh unzip tmux fontconfig
  chsh -s $(which zsh)
  
  ln -sfn "$HOME/configs/zshrc" "$HOME/.zshrc"
  
  # install hack-nerd-fonts
  wget -c https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.0/Hack.zip
  unzip Hack.zip -d ~/.fonts
  fc-cache -fv

  # setup tmux
  setup_tmux_conf
  install_tpm
  echo "For install tmux plugins you need use Prefix+I shortcut"

  # install helix
  which hx > /dev/null || (sudo add-apt-repository ppa:maveonair/helix-editor && \
      sudo apt update && \
      sudo apt install helix)
  setup_helix  
}


case ${OSTYPE} in
	darwin*)
		setup_mac
		;;
	linux-gnu)
		setup_ubuntu
		;;
	*)
	  echo -n "unknown os"
	  exit 1
	  ;;
esac
