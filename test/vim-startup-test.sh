#!/usr/bin/env bash

# 1. install all plugins (pipe to /dev/null because fzf.vim is noisy)
nvim -u init.vim --headless +PlugInstall +qall &> /dev/null
# 2. test base startuptime
n1=`./go/bin/vim-startuptime -vimpath nvim | grep "^Total Average:" | cut -d ' ' -f3`
# 3. test startuptime with all plugins
n2=`./go/bin/vim-startuptime -vimpath nvim -- -u init.vim | grep "^Total Average:" | cut -d ' ' -f3`
# 4. compute percent increase
awk -v n1=$n1 -v n2=$n2 'BEGIN {printf "Percent increase in startup time = %s%%\n", (((n2 - n1) / n1)*100) }'
