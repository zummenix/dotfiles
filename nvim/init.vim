language en_US.UTF-8

call plug#begin('~/.local/share/nvim/plugged')
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
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'w0rp/ale'
Plug 'purescript-contrib/purescript-vim'
Plug 'keith/swift.vim'
call plug#end()

let g:elm_setup_keybindings=0

let g:fzf_layout = { 'down': '~20%' }

let g:ale_fixers = {
\   'rust': ['rustfmt'],
\   'typescript': ['prettier'],
\   'javascript': ['prettier'],
\   'python': [],
\}

let g:ale_linters = {
\   'rust': ['rls'],
\   'typescript': ['tslint', 'tsserver'],
\   'python': [],
\}

let g:ale_lint_on_text_changed='never'
let g:ale_completion_enabled=1
let g:ale_completion_delay=200
let g:ale_completion_max_suggestions=7
let g:ale_fix_on_save=1

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
set completeopt=menu,menuone,preview,noinsert
set cursorline
set backspace=indent,start,eol
set scrolloff=3

" Configure status line.

function! ModifiedStatus() abort
    return &modified ? ' • ' : '   '
endfunction

function! ReadOnlyStatus() abort
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

function! OpenAndConfigureMyTerminal(vertical) abort
    if a:vertical | vnew | else | new | endif | terminal
    setlocal nonumber norelativenumber
    tnoremap <buffer> <esc> <c-\><c-n>
    startinsert
endfunction

function! TabCompleteOrTab() abort
    " Check if its looks like possible to complete.
    if searchpos('[_a-zA-Z0-9.(]\%#', 'nb') != [0, 0]
        return "\<c-n>"
    else
        return "\<tab>"
    endif
endfunction

nnoremap <leader>p :GFiles<cr>
nnoremap <leader>P :Files<cr>
nnoremap <leader>t :call OpenAndConfigureMyTerminal(1)<cr>
nnoremap <leader>T :call OpenAndConfigureMyTerminal(0)<cr>

" Redraw the window.
nnoremap <leader>l :nohlsearch<cr>:diffupdate<cr>:syntax sync fromstart<cr><c-l>

nnoremap <silent> gh :ALEHover<cr>
nnoremap <silent> gd :ALEGoToDefinition<cr>
nnoremap <silent> gr :ALEFindReferences<cr>

" Open fzf's buffers list.
nnoremap gb :Buffers<enter>

" <tab>: completion.
inoremap <silent> <expr> <tab> TabCompleteOrTab()
inoremap <silent> <expr> <cr> pumvisible() ? "\<c-y>" : "\<c-g>u<cr>"

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

