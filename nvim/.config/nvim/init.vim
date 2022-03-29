let mapleader = " "

if has("nvim")
    let g:plug_home = stdpath('data') . '/plugged'
endif

call plug#begin()

Plug 'lifepillar/vim-gruvbox8'
Plug 'nathom/filetype.nvim'
Plug 'tpope/vim-fugitive'

call plug#end()

" Colorscheme
set termguicolors
let g:gruvbox_italic = 1
colorscheme gruvbox8

" Speed up startup
set history=50
if has("win32") || has ("wsl")
    let g:clipboard = {
    \   'name': 'win32yank',
    \   'copy': {
    \      '+': 'win32yank.exe -i --crlf',
    \      '*': 'win32yank.exe -i --crlf',
    \    },
    \   'paste': {
    \      '+': 'win32yank.exe -o --lf',
    \      '*': 'win32yank.exe -o --lf',
    \   },
    \   'cache_enabled': 1,
    \ }
endif
set clipboard+=unnamed

" Files
set noswapfile
set undofile

" Interface
set confirm
set guicursor+=a:blinkwait700-blinkon400-blinkoff250
set mouse=a
set noruler
set noshowcmd
set number
set splitbelow
set splitright

" Formatting
set expandtab
set nowrap
set shiftround
set shiftwidth=4
set softtabstop=4
set tabstop=4

" Search
set ignorecase
set path+=**
set smartcase
set wildignore+=*.pyc
set wildignorecase

" Statusline
function! CheckFEnc()
    if &fenc == '' || &fenc == 'utf-8'
        return ''
    endif
    return '['.&fenc.']'
endfunction

set statusline=
set statusline+=%<%f\ %y
set statusline+=%{'['.&ff.']'}%{CheckFEnc()}\ %m%r
set statusline+=%=\ \ %11.(%l/%L%)\ :\ %-5(%c%V%)

" Remaps
noremap <leader>d "_d
nnoremap x "_x
nnoremap <silent> <leader>e :Lex 30<cr>
" Think about using 's' as a leader for splits operations (creating splits and
" navigating

" Plugins Settings
