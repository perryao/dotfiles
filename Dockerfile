FROM archlinux

RUN pacman -Syyu --noconfirm \
    && pacman -S --noconfirm \
      neovim \
      git \
      go \
      nodejs \
      npm \
    && go get github.com/rhysd/vim-startuptime

WORKDIR /root

COPY test/vim-startup-test.sh config/.config/nvim vim ./

RUN chmod +x vim-startup-test.sh

ENTRYPOINT ["/root/vim-startup-test.sh"]
