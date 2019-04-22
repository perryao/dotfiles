call plug#begin('~/.vim/plugged')

" Themes
Plug 'joshdick/onedark.vim'
Plug 'sonph/onehalf', { 'rtp': 'vim/' }
Plug 'reedes/vim-colors-pencil'
Plug 'logico-dev/typewriter'
Plug 'altercation/vim-colors-solarized'

" Writing
Plug 'reedes/vim-pencil'
Plug 'reedes/vim-wordy'
Plug 'reedes/vim-lexical'
Plug 'kana/vim-textobj-user'
Plug 'reedes/vim-textobj-quote'
Plug 'reedes/vim-textobj-sentence'
Plug 'reedes/vim-litecorrect'

" Tools
Plug 'w0rp/ale'
Plug 'benmills/vimux'
Plug 'jlanzarotta/bufexplorer'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'sjl/gundo.vim'
Plug 'easymotion/vim-easymotion'
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'
Plug 'google/vim-maktaba'
Plug 'airblade/vim-gitgutter'
Plug 'terryma/vim-multiple-cursors'
Plug 'JamshedVesuna/vim-markdown-preview'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'tmux-plugins/vim-tmux-focus-events'
Plug 'SirVer/ultisnips'
Plug 'ervandew/supertab'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-unimpaired'


" Language Plugins + Syntax
Plug 'posva/vim-vue'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'tpope/vim-markdown'
Plug 'keith/swift.vim'
Plug 'othree/es.next.syntax.vim'
Plug 'othree/yajs.vim'
Plug 'isRuslan/vim-es6'
Plug 'pangloss/vim-javascript'
Plug 'bazelbuild/vim-bazel'
Plug 'derekwyatt/vim-scala'
Plug 'hashivim/vim-terraform'
Plug 'stephpy/vim-yaml'
Plug 'Glench/Vim-Jinja2-Syntax'
Plug 'mustache/vim-mustache-handlebars'
Plug 'digitaltoad/vim-pug'
Plug 'moll/vim-node'
Plug 'udalov/kotlin-vim'
Plug 'leafgarland/typescript-vim'
Plug 'tsandall/vim-rego'


call plug#end()
