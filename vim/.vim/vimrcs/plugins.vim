"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Nerd Tree
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if has_key(g:plugs, 'nerdtree')
  echo 'has nerdtree'
  let g:NERDTreeWinPos = "left"
  let NERDTreeShowHidden=1
  let NERDTreeCascadeSingleChildDir=0
  let NERDTreeIgnore = ['\.pyc$', '__pycache__']
  let g:NERDTreeWinSize = 35
  let g:NERDTreeQuitOnOpen = 0
  map <leader>nn :NERDTreeToggle<cr>
  map <leader>nb :NERDTreeFromBookmark
  map <leader>nf :NERDTreeFind<cr>
endif

"""""""""""""""""""""""""""""""
" => Vim GitGutter
"""""""""""""""""""""""""""""""
let g:gitgutter_terminal_reports_focus=0

"""""""""""""""""""""""""""""""""
" => gundo
"""""""""""""""""""""""""""""""""
let g:gundo_prefer_python3 = 1

""""""""""""""""""""""""""""""""""
" => ctrlp
""""""""""""""""""""""""""""""""""
if has_key(g:plugs, 'ctrlp.vim')
  let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'
  let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard']
  let g:ctrlp_map = '<leader>f' "ctrlp mapping
  let g:ctrlp_cmd = 'CtrlP'
endif

" ==================== FZF ====================
if has_key(g:plugs, 'fzf')
  let g:fzf_command_prefix = 'Fzf'
  let g:fzf_layout = { 'down': '~20%' }

  " search 
  nmap <C-p> :FzfHistory<cr>
  imap <C-p> <esc>:<C-u>FzfHistory<cr>

  " search across files in the current directory
  nmap <leader>f :FzfFiles<cr>
  imap <leader>f <esc>:<C-u>FzfFiles<cr>

  let g:rg_command = '
    \ rg --column --line-number --no-heading --fixed-strings --ignore-case --hidden --follow --color "always"
    \ -g "!{.git}/*" '

  command! -bang -nargs=* Rg
    \ call fzf#vim#grep(
    \   'rg --column --line-number --no-heading --color=always '.shellescape(<q-args>), 1,
    \   <bang>0 ? fzf#vim#with_preview('up:60%')
    \           : fzf#vim#with_preview('right:50%:hidden', '?'),
    \   <bang>0)

  command! -bang -nargs=* F call fzf#vim#grep(g:rg_command .shellescape(<q-args>), 1, <bang>0)
  " call rg_command to search across files
  nmap <leader>/ :F<cr>
  nmap \ :F<cr>
  nnoremap <silent> <leader>o :FzfBuffers<CR>
endif

""""""""""""""""""""""""""""""""""
" => goyo
""""""""""""""""""""""""""""""""""
let g:goyo_width = 120
function! s:goyo_enter()
  colorscheme typewriter
  set background=light
  highlight Normal ctermfg=black
  silent !tmux set status off
  silent !tmux list-panes -F '\#F' | grep -q Z || tmux resize-pane -Z
  set nolist
  set noshowmode
  set noshowcmd
  set scrolloff=999
  Limelight
endfunction

function! s:goyo_leave()
  colorscheme codedark
  set background=dark
  silent !tmux set status on
  silent !tmux list-panes -F '\#F' | grep -q Z && tmux resize-pane -Z
  set list
  set showmode
  set showcmd
  set scrolloff=5
  Limelight!
endfunction

autocmd! User GoyoEnter nested call <SID>goyo_enter()
autocmd! User GoyoLeave nested call <SID>goyo_leave()
map <leader>go :Goyo<cr>

"""""""""""""""
" => Pencil
"""""""""""
if has_key(g:plugs, 'pencil')
  augroup pencil
    autocmd!
    "
    " Apply for Markdown and reStructuredText
    autocmd FileType markdown,mkd,md,rst,asciidoc call pencil#init({'wrap': 'soft'})
                                \ | call lexical#init()
                                \ | call litecorrect#init()
                                \ | call textobj#quote#init()
                                \ | call textobj#sentence#init()
    autocmd FileType markdown,mkd,md call SetMarkdownOptions() 
  augroup END
  function! SetMarkdownOptions()
    setlocal spell spelllang=en_us
    " surround for markdown links
    nmap <leader>l <Plug>Ysurroundiw]%a(<C-R>*)<Esc>
  endfunction

  let g:pencil#autoformat_config = {
          \   'markdown': {
          \     'black': [
          \       'htmlH[0-9]',
          \       'markdown(Code|H[0-9]|Url|IdDeclaration|Link|Rule|Highlight[A-Za-z0-9]+)',
          \       'markdown(FencedCodeBlock|InlineCode)',
          \       'mkd(Code|Rule|Delimiter|Link|ListItem|IndentCode)',
          \       'mmdTable[A-Za-z0-9]*',
          \     ],
          \     'white': [
          \      'markdown(Code|Link)',
          \     ],
          \   },
          \ }
endif

""""""""""""""""""""""""""""""""""
" => limelight
""""""""""""""""""""""""""""""""""
" Color name (:help cterm-colors) or ANSI code
let g:limelight_conceal_ctermfg = 'Grey'

" " Default: 0.5
let g:limelight_default_coefficient = 0.7

let g:limelight_bop = '^.*$'
let g:limelight_eop = '\n'
let g:limelight_paragraph_span = 0

" " Highlighting priority (default: 10)
" "   Set it to -1 not to overrule hlsearch
let g:limelight_priority = -1

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => vim-airline config
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:airline_theme='gruvbox'
let g:airline_powerline_fonts = 1
let g:WebDevIconsNerdTreeBeforeGlyphPadding = ""
let g:WebDevIconsUnicodeDecorateFolderNodes = v:true
" Disable arrow icons at the left side of folders for NERDTree.
let g:NERDTreeDirArrowExpandable = "\u00a0"
let g:NERDTreeDirArrowCollapsible = "\u00a0"
let g:airline_section_error = '%{airline#util#wrap(airline#extensions#coc#get_error(),0)}'
let g:airline_section_warning = '%{airline#util#wrap(airline#extensions#coc#get_warning(),0)}'
"""""""""""""""""""""""""""""""""""
" => vim-markdown-preview
"""""""""""""""""""""""""""""""""""
let vim_markdown_preview_toggle=1
let vim_markdown_preview_browser='Firefox'
let vim_markdown_preview_temp_file=1
let vim_markdown_preview_github=1


" => vim-markdown
let g:markdown_fenced_languages = ['html', 'python', 'bash=sh', 'scala', 'javascript', 'go']

"""vim terraform
let g:terraform_align=1
let g:terraform_fmt_on_save=1

" Vimux
if has_key(g:plugs, 'vimux')
  map <Leader>vp :VimuxPromptCommand<CR>
  map <Leader>vl :VimuxRunLastCommand<CR>
endif

" ultisnips
let g:UltiSnipsExpandTrigger="<c-j>" "remove conflict with coc.vim tab expandsion

" let g:user_emmet_leader_key=','

""vim-go
let g:go_auto_type_info = 0
let g:go_doc_keywordprg_enabled = 0 " disable K for :GoDoc
" let g:go_metalinter_enabled = ['vet', 'golint', 'errcheck']
" let g:go_metalinter_autosave = 1
" let g:go_metalinter_autosave_enabled = ['vet', 'golint']
" let g:go_metalinter_deadline = "5s"
let g:go_fmt_command = "goimports"
let g:go_list_type = "quickfix"
let g:go_info_mode = "gopls"
let g:go_def_mode = "gopls"
let g:go_highlight_functions = 1
let g:go_highlight_function_arguments = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_generate_tags = 1

" Open :GoDeclsDir with ctrl-g
nmap <C-g> :GoDeclsDir<cr>
" imap <C-g> <esc>:<C-u>GoDeclsDir<cr> "currently conflicts with imap below
" for coc.vim

augroup go
  autocmd!

  " Show by default 4 spaces for a tab
  autocmd BufNewFile,BufRead *.go setlocal noexpandtab tabstop=4 shiftwidth=4

  " :GoBuild and :GoTestCompile
  autocmd FileType go nmap <leader>b :<C-u>call <SID>build_go_files()<CR>

  " :GoTest
  autocmd FileType go nmap <leader>t  <Plug>(go-test)

  " :GoRun
  autocmd FileType go nmap <leader>r  <Plug>(go-run)

  " :GoDoc
  autocmd FileType go nmap <Leader>d <Plug>(go-doc)

  " :GoCoverageToggle
  autocmd FileType go nmap <Leader>c <Plug>(go-coverage-toggle)

  " :GoInfo
  autocmd FileType go nmap <Leader>i <Plug>(go-info)

  " :GoMetaLinter
  autocmd FileType go nmap <Leader>l <Plug>(go-metalinter)

  " :GoDef but opens in a vertical split
  autocmd FileType go nmap <Leader>v <Plug>(go-def-vertical)
  " :GoDef but opens in a horizontal split
  autocmd FileType go nmap <Leader>s <Plug>(go-def-split)

  " :GoAlternate  commands :A, :AV, :AS and :AT
  autocmd Filetype go command! -bang A call go#alternate#Switch(<bang>0, 'edit')
  autocmd Filetype go command! -bang AV call go#alternate#Switch(<bang>0, 'vsplit')
  autocmd Filetype go command! -bang AS call go#alternate#Switch(<bang>0, 'split')
  autocmd Filetype go command! -bang AT call go#alternate#Switch(<bang>0, 'tabe')
augroup END

augroup scala
  autocmd BufWritePre *.scala :call CocAction('format')
  autocmd BufWritePre *.scala :SortScalaImports
augroup END

" build_go_files is a custom function that builds or compiles the test file.
" It calls :GoBuild if its a Go file, or :GoTestCompile if it's a test file
function! s:build_go_files()
  let l:file = expand('%')
  if l:file =~# '^\f\+_test\.go$'
    call go#test#Test(0, 1)
  elseif l:file =~# '^\f\+\.go$'
    call go#cmd#Build(0)
  endif
endfunction

nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
" coc.vim
" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Use <C-l> for trigger snippet expand.
imap <C-l> <Plug>(coc-snippets-expand)

" Use <C-j> for select text for visual placeholder of snippet.
vmap <C-j> <Plug>(coc-snippets-select)

" Use <C-j> for jump to next placeholder, it's default of coc.nvim
let g:coc_snippet_next = '<c-j>'

" Use <C-k> for jump to previous placeholder, it's default of coc.nvim
let g:coc_snippet_prev = '<c-k>'

" Use <C-j> for both expand and jump (make expand higher priority.)
imap <C-j> <Plug>(coc-snippets-expand-jump)

inoremap <silent><expr> <TAB>
      \ pumvisible() ? coc#_select_confirm() :
      \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

let g:coc_snippet_next = '<tab>'

" " use <tab> for trigger completion and navigate to the next complete item
" function! s:check_back_space() abort
"   let col = col('.') - 1
"   return !col || getline('.')[col - 1]  =~ '\s'
" endfunction

" inoremap <silent><expr> <TAB>
"       \ pumvisible() ? "\<C-n>" :
"       \ <SID>check_back_space() ? "\<TAB>" :
"       \ coc#refresh()

" inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>"
" autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif
