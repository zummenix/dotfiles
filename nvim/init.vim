
language en_US.UTF-8

call plug#begin('~/.local/share/nvim/plugged')
call plug#end()


lua << EOM
vim.opt.hidden = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.incsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = false
vim.opt.signcolumn = 'yes'
vim.opt.completeopt = 'menu,menuone,preview,noinsert'
vim.opt.cursorline = true
vim.opt.backspace = 'indent,start,eol'
vim.opt.scrolloff = 3
vim.opt.colorcolumn = '100'

-- Configure tab indentation.
vim.opt.autoindent = true
vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 0 -- Use tabstop value.

-- Sane splits.
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Folding using indentation and in unfold state by default.
vim.opt.foldmethod = 'indent'
vim.opt.foldlevel = 20

-- Show trailing spaces.
vim.opt.listchars = 'tab:►-,trail:·'
vim.opt.list = true

-- Plugins
vim.g.fzf_layout = { down = "~20%" }
EOM

set shortmess+=c

" Configure status line.

function! ModifiedStatus() abort
    return &modified ? ' • ' : '   '
endfunction

function! ReadOnlyStatus() abort
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

filetype plugin indent on

let mapleader="\<SPACE>"

nmap <leader><leader> <c-w>

nnoremap <leader>p :GFiles<cr>
nnoremap <leader>P :Files<cr>

" Redraw the window.
nnoremap <leader>l :nohlsearch<cr>:diffupdate<cr>:syntax sync fromstart<cr><c-l>

" Open fzf's buffers list.
nnoremap gb :Buffers<enter>

" Pair parentheses and etc.
inoremap () ()<esc>i
inoremap [] []<esc>i
inoremap {} {}<esc>i
inoremap <> <><esc>i
inoremap "" ""<esc>i
inoremap '' ''<esc>i
inoremap `` ``<esc>i

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

hi StatusLine ctermfg=12 ctermbg=11 guifg=#a7adba guibg=#21252e
hi Error ctermfg=1 ctermbg=10 guifg=#bf616a guibg=#343d46
