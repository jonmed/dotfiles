let mapleader = " "

if has("nvim")
    let g:plug_home = stdpath('data') . '/plugged'
endif

call plug#begin()

Plug 'lifepillar/vim-gruvbox8'
Plug 'nathom/filetype.nvim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}

call plug#end()

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
set clipboard+=unnamed,unnamedplus

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
set scrolloff=8

" Formatting
set expandtab
set nowrap
set shiftround
set shiftwidth=4
set tabstop=4

" Search
set ignorecase
set path+=**
set smartcase
set nohlsearch
set wildignore+=*.pyc,*/venv/*
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

vnoremap < <gv
vnoremap > >gv

noremap <silent> <expr> j (v:count == 0 ? 'gj' : 'j')
noremap <silent> <expr> k (v:count == 0 ? 'gk' : 'k')

nnoremap n nzzzv
nnoremap N Nzzzv
nnoremap J mzJ`z

"cmap w!! %!sudo tee > /dev/null %

"nnoremap <silent> <leader>e :Lex 30<cr>
" Think about using 's' as a leader for splits operations (creating splits and
" navigating

" Autocommands
augroup restore_terminal_cursor_on_exit
    autocmd!
    autocmd VimLeave * set guicursor=a:ver25-blinkwait700-blinkoff250-blinkon400
augroup END

" Filetype settings
augroup html
    au!
    au FileType html setlocal tabstop=2 shiftwidth=2
    au FileType htmldjango setlocal tabstop=2 shiftwidth=2
augroup END

" Plugins Settings


" CoC
set updatetime=300
set shortmess+=c
set cmdheight=2
set signcolumn=number

inoremap <silent><expr> <c-n> pumvisible() ? "\<c-n>" : coc#refresh()
inoremap <silent><expr> <c-p> pumvisible() ? "\<c-p>" : coc#refresh()

nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
    if CocAction('hasProvider', 'hover')
        call CocActionAsync('doHover')
    else
        call feedkeys('K', 'in')
    endif
endfunction

autocmd CursorHold * silent call CocActionAsync('highlight')

nmap <leader>rn <Plug>(coc-rename)

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

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)

" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

" coc-explorer
nmap <leader>e <Cmd>CocCommand explorer --toggle --sources=buffer+,file+<cr>
