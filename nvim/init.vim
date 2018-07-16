language en_US.UTF-8

call plug#begin('~/.local/share/nvim/plugged')
Plug 'rust-lang/rust.vim'
Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'airblade/vim-gitgutter'
Plug 'cespare/vim-toml'
Plug 'chriskempson/base16-vim'
Plug 'wincent/terminus'
Plug 'wincent/ferret'
Plug 'tpope/vim-commentary'
Plug 'elmcast/elm-vim'
Plug 'justinmk/vim-dirvish'
Plug 'neoclide/vim-jsx-improve'
Plug 'leafgarland/typescript-vim'
Plug 'machakann/vim-highlightedyank'
Plug 'pearofducks/ansible-vim'
Plug 'dag/vim-fish'
Plug 'henrik/vim-indexed-search'
Plug 'gluon-lang/vim-gluon'
Plug 'sbdchd/neoformat'
Plug 'sirver/ultisnips'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'w0rp/ale'
Plug 'purescript-contrib/purescript-vim'
call plug#end()

let g:elm_setup_keybindings=0

let g:LanguageClient_serverCommands = {
    \ 'rust': ['rustup', 'run', 'nightly', 'rls'],
    \ }

let g:deoplete#enable_at_startup=1
let g:deoplete#max_list=7

let g:fzf_layout = { 'down': '~20%' }

" We should always use local prettier.
let g:neoformat_javascript_prettier = {
      \ 'exe': './node_modules/.bin/prettier',
      \ 'args': ['--write'],
      \ 'replace': 1
      \ }

let g:neoformat_typescript_prettier = {
      \ 'exe': './node_modules/.bin/prettier',
      \ 'args': ['--write'],
      \ 'replace': 1
      \ }

let g:ale_lint_on_text_changed='never'
let g:ale_linters={'rust': []}
let g:ale_sign_error='•'
let g:ale_sign_info='•'
let g:ale_sign_style_error='•'
let g:ale_sign_style_warning='•'
let g:ale_sign_warning='•'

set hidden
set number
set relativenumber
set incsearch
set ignorecase
set smartcase
set nohlsearch
set signcolumn=yes
set completeopt=menu,preview,noinsert
set cursorline
set backspace=indent,start,eol
set scrolloff=3

" Configure status line.

function! ModifiedStatus()
    return &modified ? ' • ' : '   '
endfunction

function! ReadOnlyStatus()
    return &readonly ? ', readonly' : ''
endfunction

function! LinterErrorStatus() abort
    let l:counts = ale#statusline#Count(bufnr(''))
    let l:all_errors = l:counts.error + l:counts.style_error
    return l:all_errors == 0 ? '' : printf('E:%d', l:all_errors)
endfunction

function! LinterWarningStatus() abort
    let l:counts = ale#statusline#Count(bufnr(''))
    let l:all_warnings = l:counts.warning + l:counts.style_warning
    return l:all_warnings == 0 ? '' : printf('W:%d', l:all_warnings)
endfunction

set laststatus=2
set statusline=
set statusline+=\ %f
set statusline+=%{ReadOnlyStatus()}
set statusline+=%{ModifiedStatus()}
set statusline+=%y
set statusline+=\ %q
set statusline+=\ %{LinterErrorStatus()}
set statusline+=\ %{LinterWarningStatus()}
set statusline+=%=%l\:%-4.c\ %L

" Configure tab indentation.
set autoindent
set expandtab
set tabstop=4
set shiftwidth=0 " Use tabstop value.

" Folding using indentation and in unfold state by default.
set foldmethod=indent
set foldlevel=20

set colorcolumn=100

" Show trailing spaces.
set listchars=tab:►-,trail:·
set list

filetype plugin indent on

" Sane splits.
set splitright
set splitbelow

let mapleader="\<SPACE>"

nmap <leader><leader> <c-w>

function! OpenAndConfigureMyTerminal()
    vnew | terminal
    setlocal nonumber norelativenumber
    tnoremap <buffer> <esc> <c-\><c-n>
    startinsert
endfunction

nnoremap <leader>p :GFiles<cr>
nnoremap <leader>P :Files<cr>
nnoremap <leader>t :call OpenAndConfigureMyTerminal()<cr>

" Redraw the window.
nnoremap <leader>l :nohlsearch<cr>:diffupdate<cr>:syntax sync fromstart<cr><c-l>

nnoremap <silent> gh :call LanguageClient_textDocument_hover()<cr>
nnoremap <silent> gd :call LanguageClient_textDocument_definition()<cr>
nnoremap <silent> gr :call LanguageClient_textDocument_rename()<cr>

" Open buffer's list for selection.
nnoremap gb :ls<cr>:b<space>

" <tab>: completion.
inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"

" Add more granularity to undo history.
inoremap <space> <space><c-g>u
inoremap . .<c-g>u
inoremap , ,<c-g>u

command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview('up:60%')
  \           : fzf#vim#with_preview('right:50%:hidden', '?'),
  \   <bang>0)

if filereadable(expand("~/.vimrc_background"))
    set termguicolors
    source ~/.vimrc_background
endif

hi StatusLine ctermfg=12 ctermbg=11 guifg=#a7adba guibg=#21252e
hi Error ctermfg=1 ctermbg=10 guifg=#bf616a guibg=#343d46

augroup fmt
    autocmd!
    autocmd BufWritePre * Neoformat
augroup END

