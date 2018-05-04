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
Plug 'pangloss/vim-javascript'
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

let g:ale_lint_on_text_changed='never'

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

set laststatus=2
set statusline=
set statusline+=\ %f
set statusline+=%{ReadOnlyStatus()}
set statusline+=%{ModifiedStatus()}
set statusline+=%y
set statusline+=\ %q
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

" Convenient jumps between splits.
nmap <c-h> <c-w>h
nmap <c-j> <c-w>j
nmap <c-k> <c-w>k
nmap <c-l> <c-w>l

let mapleader="\<SPACE>"

nmap <leader><leader> <c-^>

" There are probably better ways to do this.
function! OpenAndConfigureMyTerminal()
    execute "vnew | terminal"
    execute "setlocal nonumber norelativenumber"
    execute "tnoremap <buffer> <esc> <c-\\><c-n>"
    execute "normal! i"
endfunction

nnoremap <leader>q :bdelete<cr>
nnoremap <leader>p :FZF<cr>
nnoremap <leader>c "+
nnoremap <leader>t :call OpenAndConfigureMyTerminal()<cr>

" Redraw the window.
nnoremap <leader>l :nohlsearch<cr>:diffupdate<cr>:syntax sync fromstart<cr><c-l>

nnoremap <silent> gh :call LanguageClient_textDocument_hover()<cr>
nnoremap <silent> gd :call LanguageClient_textDocument_definition()<cr>
nnoremap <silent> gr :call LanguageClient_textDocument_rename()<cr>

" <tab>: completion.
inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"

" Cycle through buffers.
nnoremap <tab> :bnext!<cr>
nnoremap <s-tab> :bprev!<cr>

" Open buffer's list for selection.
nnoremap gb :ls<cr>:b<space>

" Don't loose visual selection when using indent.
xnoremap < <gv
xnoremap > >gv

" Add more granularity to undo history.
inoremap <space> <space><c-g>u
inoremap . .<c-g>u
inoremap , ,<c-g>u

if filereadable(expand("~/.vimrc_background"))
    let base16colorspace=256
    source ~/.vimrc_background
endif

hi StatusLine ctermbg=235

augroup fmt
    autocmd!
    autocmd BufWritePre * Neoformat
augroup END

