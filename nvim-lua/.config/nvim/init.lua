vim.g.mapleader = " "

vim.opt.termguicolors = true

-- Speed up startup
vim.opt.history = 50
if vim.fn.has('win32') or vim.fn.has('wsl') then
    vim.g.clipboard = {
        name = "win32yank",
        copy = {
            ["+"] = "win32yank.exe -i --crlf",
            ["*"] = "win32yank.exe -i --crlf"
        },
        paste = {
            ["+"] = "win32yank.exe -o --lf",
            ["*"] = "win32yank.exe -o --lf"
        },
        cache_enabled = 1
    }
end
vim.opt.clipboard = 'unnamed,unnamedplus'

-- Files
vim.opt.swapfile = false
vim.opt.undofile = true

-- Interface
vim.opt.confirm = true
vim.opt.guicursor:append({"a:blinkwait700-blinkon400-blinkoff250"})
vim.opt.mouse = 'a'
vim.opt.ruler = false
vim.opt.showcmd = false
vim.opt.number = true
vim.opt.splitbelow = true
vim.opt.splitright = true

-- Formatting
vim.opt.expandtab = true
vim.opt.shiftround = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.wrap = false 

-- Search
vim.opt.ignorecase = true
vim.opt.path:append({"**"})
vim.opt.smartcase = true
vim.opt.wildignore:append({"*.pyc","*/venv/*"})
vim.opt.wildignorecase = true
