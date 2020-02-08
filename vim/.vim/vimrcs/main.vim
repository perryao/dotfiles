" Automatically install vim-plug
" https://github.com/junegunn/vim-plug/wiki/tips#automatic-installation
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
let g:coc_global_extensions = ['coc-tsserver', 'coc-prettier', 'coc-json', 'coc-html', 'coc-css', 'coc-metals', 'coc-vimlsp', 'coc-snippets', 'coc-emmet', 'coc-java', 'coc-python', 'coc-yaml', 'coc-rls', 'coc-sourcekit']

call plug#begin('~/.vim/plugged')

" Themes
Plug 'morhetz/gruvbox'
" Plug 'reedes/vim-colors-pencil'

" Writing
" Plug 'reedes/vim-pencil'
" Plug 'reedes/vim-wordy'
" Plug 'reedes/vim-lexical'
" Plug 'kana/vim-textobj-user'
" Plug 'reedes/vim-textobj-quote'
" Plug 'reedes/vim-textobj-sentence'
" Plug 'reedes/vim-litecorrect'

" Tools
" Plug 'scrooloose/nerdtree'
" Plug 'Xuyuanp/nerdtree-git-plugin'
" Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'jiangmiao/auto-pairs'
Plug 'benmills/vimux'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --bin' }
Plug 'junegunn/fzf.vim'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" Plug 'simnalamburt/vim-mundo' " visualize the undo tree (a fork of gundo with support for neovim)
" Plug 'easymotion/vim-easymotion'
" Plug 'junegunn/goyo.vim'
" Plug 'junegunn/limelight.vim'
Plug 'airblade/vim-gitgutter'
" Plug 'terryma/vim-multiple-cursors'
" Plug 'JamshedVesuna/vim-markdown-preview'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
" Plug 'tmux-plugins/vim-tmux-focus-events'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-vinegar'
" Plug 'tpope/vim-unimpaired'
" Plug 'vimlab/split-term.vim'
" Plug 'ryanoasis/vim-devicons' "fancy icons. load after nerdtree and ctrlp

" Language Plugins + Syntax
" Plug 'posva/vim-vue'
" Plug 'mattn/emmet-vim'
" Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
" Plug 'tpope/vim-markdown'
" Plug 'keith/swift.vim'
" Plug 'othree/es.next.syntax.vim'
" Plug 'othree/yajs.vim'
" Plug 'isRuslan/vim-es6'
" Plug 'pangloss/vim-javascript'
" Plug 'derekwyatt/vim-scala'
" Plug 'hashivim/vim-terraform'
" Plug 'stephpy/vim-yaml'
" Plug 'Glench/Vim-Jinja2-Syntax'
" Plug 'mustache/vim-mustache-handlebars'
" Plug 'digitaltoad/vim-pug'
" Plug 'moll/vim-node'
" Plug 'udalov/kotlin-vim'
" Plug 'HerringtonDarkholme/yats.vim'
" Plug 'leafgarland/typescript-vim'
" Plug 'tsandall/vim-rego'
call plug#end()
