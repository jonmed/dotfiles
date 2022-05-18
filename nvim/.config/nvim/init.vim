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
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-neorg/neorg'
Plug 'vimwiki/vimwiki', {'branch': 'dev'}
Plug 'camspiers/animate.vim'
Plug 'camspiers/lens.vim'
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
let s:coc_diagnostic_enabled = 1

function! Is_coc_diagnostic_enabled ()
  if (s:coc_diagnostic_enabled == 1)
    return "CoC enabled"
  else
    return "%#StatuslineNC#CoC disabled%#Statusline#"
  endif
endfunction

function! ToggleDiagnostic ()
  call CocAction('diagnosticToggle')
  if (s:coc_diagnostic_enabled == 1)
    let s:coc_diagnostic_enabled = 0
  else
    let s:coc_diagnostic_enabled = 1
  endif
endfunction

hi! SLFile guibg=#727169 guifg=#000000

function! StatuslineGen(winid) abort
  if (a:winid == win_getid())
    return "%<%#SLFile#%f\ %m%r\ %#Statusline#\ %{&ft==''?'':&ft..'\ \ '}%{%Is_coc_diagnostic_enabled()%}%=\ \ \ %3l/%L\ :\ %-2v"
  else
    return "%<%f\ %m%r"
  endif
endfunction

set statusline=%!StatuslineGen(g:statusline_winid)
"set statusline+=%<%f\ %m%r\ \ %{&ft==''?'':&ft..'\ \ '}%{%Is_coc_diagnostic_enabled()%}
"et statusline+=%=\ \ \ %3l/%L\ :\ %-2v

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

" markdown-preview
let g:mkdp_auto_close = 0

" vimwiki
let g:vimwiki_list = [{'path': '~/notes/', 'syntax': 'markdown', 'ext': '.md'}]
let g:markdown_fenced_languages = ['c', 'c++', 'python', 'sh', 'json', 'css', 'html']

" coc settings
set updatetime=300
set shortmess+=c
set signcolumn=number
inoremap <silent><expr> <c-n> coc#refresh()
inoremap <silent><expr> <c-p> coc#refresh()

nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nmap <leader>rn <Plug>(coc-rename)
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"

nnoremap <silent> <leader>c :call ToggleDiagnostic()<cr>

" Treesitter
lua << END
require('nvim-treesitter.configs').setup {
  ensure_installed = { "norg", --[[ other parsers you would wish to have ]] },
  highlight = { -- Be sure to enable highlights if you haven't!
    enable = true,
  }
}
END

" Telescope
lua << END
require('telescope').load_extension('fzf')
END
nnoremap <leader>ff <cmd>Telescope find_files theme=ivy<cr>
nnoremap <leader>fg <cmd>Telescope live_grep theme=ivy<cr>
nnoremap <leader>fb <cmd>Telescope buffers theme=ivy<cr>
nnoremap <leader>fh <cmd>Telescope help_tags theme=ivy<cr>

" neorg
lua << EOF
require('neorg').setup {
  load = {
    ["core.defaults"] = {},
    ["core.norg.concealer"] = {}
  }
}
EOF

" lens
let g:lens#disabled = 1
nnoremap <silent> <leader>l :call lens#toggle()<cr>

" General remaps
noremap <leader>d "_d
nnoremap x "_x
nnoremap c "_c

vnoremap < <gv
vnoremap > >gv

noremap <silent> <expr> j (v:count == 0 ? 'gj' : 'j')
noremap <silent> <expr> k (v:count == 0 ? 'gk' : 'k')

nnoremap n nzzzv
nnoremap N Nzzzv
nnoremap J mzJ`z

tnoremap <c-w> <c-\><c-n><c-w>
tnoremap <esc> <c-\><c-n>

nnoremap <silent> <F1> :vsplit ~/scratch.md<cr>

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

augroup markdown
  au!
  au FileType markdown setlocal conceallevel=2
augroup END

