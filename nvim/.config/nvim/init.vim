let mapleader = " "

if has("nvim")
  let g:plug_home = stdpath('data') . '/plugged'
endif

call plug#begin()
Plug 'lewis6991/impatient.nvim'
Plug 'dstein64/vim-startuptime'
Plug 'nathom/filetype.nvim'
Plug 'rebelot/kanagawa.nvim'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'kyazdani42/nvim-tree.lua'
call plug#end()

" Speed up startup
lua << EOF
require('impatient')
EOF
set history=100
" look up how to disable selected default plugins
if has("win32") || has("wsl")
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

" Colors
set termguicolors
colorscheme kanagawa

" Files
set noswapfile
set undofile

" Formatting
set expandtab
set nowrap
set shiftround
set shiftwidth=2
set tabstop=2

" Interface
set confirm
set guicursor+=a:blinkwait700-blinkon400-blinkoff250
set mouse=a
set noshowcmd
set number
set splitbelow
set splitright
set scrolloff=5

" Search
set ignorecase
set path+=**
set smartcase
set nohlsearch
set wildignore+=*.pyc,*/venv/*
set wildignorecase

" System
set clipboard+=unnamed,unnamedplus

" Statusline
set statusline=
set statusline+=%<%f\ %m%r\ \ %{&ft==''?'':&ft..'\ \ '}%{&ff}\ \ %{&fenc}
set statusline+=%=\ \ \ %3l/%L\ :\ %-2v

" File Explorer
lua << END
require('nvim-tree').setup {
  renderer = {
    icons = {
      webdev_colors = false 
    }
  }
}
END
nnoremap <leader>e :NvimTreeToggle<CR>

" General remaps
noremap <leader>d "_d
nnoremap x "_x

vnoremap < <gv
vnoremap > >gv

noremap <silent> <expr> j (v:count == 0 ? 'gj' : 'j')
noremap <silent> <expr> k (v:count == 0 ? 'gk' : 'k')

nnoremap n nzzzv
nnoremap N Nzzzv
nnoremap J mzJ`z

tnoremap <c-w> <c-\><c-n><c-w>
tnoremap <esc> <c-\><c-n>

"cmap w!! %!sudo tee > /dev/null %

" Think about using 's' as a leader for splits operations (creating splits and
" navigating

" Autocommands
augroup restore_terminal_cursor_on_exit
  autocmd!
  autocmd VimLeave * set guicursor=a:ver25-blinkwait700-blinkoff250-blinkon400
augroup END

augroup close_nvimtree_if_last_window
  autocmd!
  autocmd BufEnter * ++nested if winnr('$') == 1 && bufname() == 'NvimTree_' . tabpagenr() | quit | endif
augroup END

augroup python 
  au!
  au FileType python setlocal tabstop=4 shiftwidth=4
augroup END
