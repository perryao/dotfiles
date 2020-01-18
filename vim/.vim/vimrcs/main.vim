call plug#begin('~/.vim/plugged')

" Themes
" this theme gives an atom-like appearance
" Plug 'joshdick/onedark.vim'
" this theme gives a vscode-like appearance
" Plug 'perryao/vim-code-dark'
Plug 'tomasiser/vim-code-dark'
Plug 'morhetz/gruvbox'
Plug 'dunstontc/vim-vscode-theme'
Plug 'reedes/vim-colors-pencil'

" Writing
Plug 'reedes/vim-pencil'
Plug 'reedes/vim-wordy'
Plug 'reedes/vim-lexical'
Plug 'kana/vim-textobj-user'
Plug 'reedes/vim-textobj-quote'
Plug 'reedes/vim-textobj-sentence'
Plug 'reedes/vim-litecorrect'

" Tools
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'jiangmiao/auto-pairs'
" Plug 'dense-analysis/ale'
Plug 'benmills/vimux'
Plug 'jlanzarotta/bufexplorer'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'SirVer/ultisnips'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'simnalamburt/vim-mundo' " visualize the undo tree (a fork of gundo with support for neovim)
Plug 'easymotion/vim-easymotion'
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'
Plug 'airblade/vim-gitgutter'
Plug 'terryma/vim-multiple-cursors'
Plug 'JamshedVesuna/vim-markdown-preview'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'tmux-plugins/vim-tmux-focus-events'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-unimpaired'
Plug 'vimlab/split-term.vim'
Plug 'ryanoasis/vim-devicons' "fancy icons. load after nerdtree and ctrlp

" Language Plugins + Syntax
Plug 'posva/vim-vue'
Plug 'mattn/emmet-vim'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'tpope/vim-markdown'
Plug 'keith/swift.vim'
Plug 'othree/es.next.syntax.vim'
Plug 'othree/yajs.vim'
Plug 'isRuslan/vim-es6'
Plug 'pangloss/vim-javascript'
Plug 'derekwyatt/vim-scala'
Plug 'hashivim/vim-terraform'
Plug 'stephpy/vim-yaml'
Plug 'Glench/Vim-Jinja2-Syntax'
Plug 'mustache/vim-mustache-handlebars'
Plug 'digitaltoad/vim-pug'
Plug 'moll/vim-node'
Plug 'udalov/kotlin-vim'
Plug 'HerringtonDarkholme/yats.vim'
" Plug 'leafgarland/typescript-vim'
Plug 'tsandall/vim-rego'
call plug#end()
