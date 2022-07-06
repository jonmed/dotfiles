let mapleader = " "

let g:plug_home = stdpath('data') . '/plugged'
call plug#begin()
Plug 'lewis6991/impatient.nvim'
Plug 'dstein64/vim-startuptime'
Plug 'nathom/filetype.nvim'
Plug 'rebelot/kanagawa.nvim'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'kyazdani42/nvim-tree.lua'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'iamcco/markdown-preview.nvim', {'do': {-> mkdp#util#install()}, 'for': ['markdown', 'vim-plug']}
Plug 'nvim-telescope/telescope-fzf-native.nvim', {'do': 'make'}
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-live-grep-args.nvim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'vimwiki/vimwiki', {'branch': 'dev'}
Plug 'camspiers/animate.vim'
Plug 'camspiers/lens.vim'
Plug 'mfussenegger/nvim-dap'
Plug 'mfussenegger/nvim-dap-python'
Plug 'nvim-telescope/telescope-dap.nvim'
Plug 'theHamsta/nvim-dap-virtual-text'
Plug 'rcarriga/nvim-dap-ui'
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
hi! VertSplit guifg=#363646 guibg=#1F1F28
hi! Visual gui=reverse

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
let s:diagnostics = 1

function! ToggleDiagnostic ()
  call CocAction('diagnosticToggle')
  let s:diagnostics = s:diagnostics==1 ? 0 : 1
endfunction

function! Is_coc_diagnostic_enabled ()
  let l:string = s:diagnostics==1 ? "%#SLDiagnostic#" : "%#StatuslineNC#"
  return l:string . "\ \ "
endfunction

function! Dohi(name, fg, bg, gui)
  let l:string = a:name.' guifg='.a:fg.' guibg='.a:bg
  execute 'hi '.l:string.(a:gui==''?'':' gui='.a:gui)
endfunction

let s:sumiInk0 = "#16161D"
let s:old_white = "#C8C093"
let s:spring_green = "#98BB6C"
let s:winter_green = "#2B3328"
let s:dragon_blue = "#658594"
let s:spring_violet1 = "#938AA9"

call Dohi('SLFile', s:old_white, s:sumiInk0, '')
call Dohi('SLFileFormat', s:spring_violet1, s:sumiInk0, 'bold')
call Dohi('SLBranch', s:dragon_blue, s:sumiInk0, 'bold')
call Dohi('SLDiagnostic', s:spring_green, s:winter_green, '')

" To insert result of vim command into buffer
" :put=Exec('hi Statusline')
function! Exec(command)
  redir =>output
  silent exec a:command
  redir END
  return output
endfunction

function! GitBranch()
  let l:file_path = fnamemodify(resolve(expand("%:p")), ':h')
  let l:repo = trim(system("basename -s .git `git -C ".l:file_path." remote get-url origin 2>/dev/null` 2>/dev/null"))
  if (l:repo == '')
    return ''
  endif
  let l:branch = trim(system("git -C ".l:file_path." branch --show-current 2>/dev/null"))
  return ''.l:repo.":".l:branch
endfunction

function! DisableSL()
  return "%#Normal#\ "
endfunction

let b:git_branch = ''

function! StatuslineGen(winid) abort
  let l:sl = ''
  if (a:winid == win_getid())
    let l:sl .= "%<%#SLFile#\ %{expand('%')!=''?expand('%:~:.'):'[No\ Name]'}"
    let l:sl .= "\ %m%r\ "
    let l:sl .= "%#SLBranch#%{%b:git_branch%}\ "
    let l:sl .= "%=%#SLFileFormat#%{&ft}\ "
    let l:sl .= "%{%Is_coc_diagnostic_enabled()%}"
    let l:sl .= "%#SLFile#\ \ %3l/%L\ :\ %-2v\ "
  else
    let l:sl .= "%<\ %f\ %m%r\ %{%b:git_branch%}"
  endif
  return l:sl
endfunction

set statusline=%!StatuslineGen(g:statusline_winid)

" File Explorer
lua << END
require('nvim-tree').setup {
  renderer = {
    icons = {
      webdev_colors = true 
    }
  }
}
END
nnoremap <silent> <leader>e :NvimTreeToggle<CR>

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
require('telescope').load_extension('live_grep_args')
require('telescope').load_extension('dap')
END
nnoremap <leader>ff <cmd>Telescope find_files theme=ivy<cr>
nnoremap <leader>fg <cmd>Telescope live_grep theme=ivy<cr>
nnoremap <leader>fG :lua require("telescope").extensions.live_grep_args.live_grep_args({ theme = {'ivy'} })<cr>
nnoremap <leader>fb <cmd>Telescope buffers theme=ivy<cr>
nnoremap <leader>fh <cmd>Telescope help_tags theme=ivy<cr>

" DAP
lua << EOF
require('dap-python').setup('~/.virtualenvs/debugpy/bin/python')
table.insert(require('dap').configurations.python, {
  name = 'Docker remote attach',
  type = 'python',
  request = 'attach',
  port = 5678,
  host = 'localhost',
  pathMappings = {{
    localRoot = vim.fn.getcwd();
    remoteRoot = ".";
  }};
})
require('dapui').setup({
  layouts = {
    {
      elements = {
        "scopes",
        "watches",
      },
      size = 40,
      position = "right",
    },
  },
})
require('nvim-dap-virtual-text').setup()
EOF
nnoremap <silent> <F5> :lua require'dap'.continue()<cr>
" <F17> == <S-F5>
nnoremap <silent> <F17> :lua require'dap'.terminate()<cr>
nnoremap <silent> <F9> :lua require'dap'.toggle_breakpoint()<cr>
" <F21> == <S-F9>
nnoremap <silent> <F21> :lua require'dap'.clear_breakpoints()<cr>

nnoremap <silent> <F10> :lua require'dap'.step_over()<cr>
nnoremap <silent> <F11> :lua require'dap'.step_into()<cr>
" <F23> == <S-F11>
nnoremap <silent> <F23> :lua require'dap'.step_out()<cr>
nnoremap <silent> <leader>dr :lua require'dap'.repl.toggle({}, 'vsplit')<cr><c-w>l
nnoremap <silent> <leader>dk :lua require'dap'.up()<cr>
nnoremap <silent> <leader>dj :lua require'dap'.down()<cr>
nnoremap <leader>df <cmd>Telescope dap frames theme=ivy<cr>
nnoremap <leader>db <cmd>Telescope dap list_breakpoints theme=ivy<cr>
nnoremap <silent> <leader>dq :lua require('dapui').toggle()<cr>
nnoremap <silent> <leader>di :lua require('dap.ui.widgets').hover()<cr>
nnoremap <silent> <leader>d, :lua local widgets=require('dap.ui.widgets');widgets.centered_float(widgets.scopes)<cr>

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

augroup no_statusline_nvimtree 
  autocmd!
  autocmd BufEnter * if bufname() == 'NvimTree_' . tabpagenr() | setlocal statusline=%!DisableSL() | endif
augroup END

augroup get_git_branch 
  autocmd!
  autocmd BufEnter * let b:git_branch = GitBranch() 
augroup END

augroup python 
  au!
  au FileType python setlocal tabstop=4 shiftwidth=4
augroup END

augroup markdown
  au!
  au FileType markdown setlocal conceallevel=2
augroup END
