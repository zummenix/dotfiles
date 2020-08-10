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
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'keith/swift.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
call plug#end()

let g:elm_setup_keybindings=0

let g:fzf_layout = { 'down': '~20%' }

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
set shortmess+=c

" Configure status line.

function! ModifiedStatus() abort
    return &modified ? ' • ' : '   '
endfunction

function! ReadOnlyStatus() abort
    return &readonly ? ', readonly' : ''
endfunction

function! StatusDiagnostic() abort
    let info = get(b:, 'coc_diagnostic_info', {})
    if empty(info) | return '' | endif
    let msgs = []
    if get(info, 'error', 0)
        call add(msgs, 'E:' . info['error'])
    endif
    if get(info, 'warning', 0)
        call add(msgs, 'W:' . info['warning'])
    endif
    return join(msgs, ' ') . ' ' . get(g:, 'coc_status', '')
endfunction

set laststatus=2
set statusline=
set statusline+=\ %f
set statusline+=%{ReadOnlyStatus()}
set statusline+=%{ModifiedStatus()}
set statusline+=%y
set statusline+=\ %q
set statusline+=\ %{StatusDiagnostic()}
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

nnoremap <leader>p :GFiles<cr>
nnoremap <leader>P :Files<cr>
nnoremap <leader>t :call OpenAndConfigureMyTerminal(1)<cr>
nnoremap <leader>T :call OpenAndConfigureMyTerminal(0)<cr>

" Redraw the window.
nnoremap <leader>l :nohlsearch<cr>:diffupdate<cr>:syntax sync fromstart<cr><c-l>

" Open fzf's buffers list.
nnoremap gb :Buffers<enter>

" <tab>: completion.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"

" To navigate diagnostics
nmap <silent> gn <Plug>(coc-diagnostic-next)
nmap <silent> gp <Plug>(coc-diagnostic-prev)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

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

