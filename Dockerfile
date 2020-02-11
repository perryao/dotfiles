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

# COPY config/.config/nvim vim ./
# 1. install all plugins
# nvim -u init.vim --headless +PlugInstall +qall
# 2. test base startuptime
# ./go/bin/vim-startuptime -vimpath nvim | grep "^Total Average:" | cut -d ' ' -f3
# 3. test startuptime with all plugins
# ./go/bin/vim-startuptime -vimpath nvim -- -u init.vim | grep "^Total Average:" | cut -d ' ' -f3
# 4. compute percent increase
# awk -v n1=$n1 -v n2=$n2 'BEGIN {print (((n2 - n1) / n1)*100) }'
