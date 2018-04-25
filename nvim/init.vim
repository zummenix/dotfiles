language en_US.UTF-8

call plug#begin('~/.local/share/nvim/plugged')
Plug 'rust-lang/rust.vim'
Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'airblade/vim-gitgutter'
Plug 'cespare/vim-toml'
Plug 'ctrlpvim/ctrlp.vim', { 'on': 'CtrlP' }
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
call plug#end()

let g:elm_setup_keybindings=0

" Convenient jumps between splits.
nmap <c-h> <c-w>h
nmap <c-j> <c-w>j
nmap <c-k> <c-w>k
nmap <c-l> <c-w>l

let g:LanguageClient_serverCommands = {
    \ 'rust': ['rustup', 'run', 'nightly', 'rls'],
    \ }

let g:deoplete#enable_at_startup=1
let g:deoplete#max_list=7

let g:ctrlp_reuse_window='dirvish'

set hidden
set number
set relativenumber
set noshowmode
set incsearch
set ignorecase
set smartcase
set nohlsearch
set signcolumn=yes
set completeopt=menu,preview,noinsert
set cursorline
set backspace=indent,start,eol
set scrolloff=3
set laststatus=2

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

" <tab>: completion.
inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"

" Cycle through buffers.
nnoremap <tab> :bnext!<cr>
nnoremap <s-tab> :bprev!<cr>

nmap <leader><leader> <c-^>

nnoremap <leader>q :bdelete<cr>

nnoremap <leader>p :CtrlP<cr>
nnoremap <leader>t :CtrlP<cr>

" Redraw the window.
nnoremap <leader>l :nohlsearch<cr>:diffupdate<cr>:syntax sync fromstart<cr><c-l>

nnoremap <silent> gh :call LanguageClient_textDocument_hover()<cr>
nnoremap <silent> gd :call LanguageClient_textDocument_definition()<cr>
nnoremap <silent> gr :call LanguageClient_textDocument_rename()<cr>

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

augroup fmt
    autocmd!
    autocmd BufWritePre * Neoformat
augroup END

