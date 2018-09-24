call plug#begin('~/.vim/plugged')

Plug 'nsf/gocode', { 'rtp': 'vim', 'do': '~/.vim/plugged/gocode/vim/symlink.sh'  }

" Themes
Plug 'joshdick/onedark.vim'
Plug 'reedes/vim-colors-pencil'

" Tools
Plug 'jlanzarotta/bufexplorer'
Plug 'tpope/vim-commentary'
Plug 'w0rp/ale'
Plug 'scrooloose/nerdtree'
Plug 'jiangmiao/auto-pairs'
Plug 'sjl/gundo.vim'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'easymotion/vim-easymotion'
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'
Plug 'google/vim-maktaba'
Plug 'airblade/vim-gitgutter'
Plug 'terryma/vim-multiple-cursors'
Plug 'JamshedVesuna/vim-markdown-preview'
Plug 'tpope/vim-surround'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Language Plugins + Syntax
Plug 'posva/vim-vue'
Plug 'fatih/vim-go'
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


call plug#end()
