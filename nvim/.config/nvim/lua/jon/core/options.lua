local opt = vim.opt

-- Colors
opt.termguicolors = true

-- Files
opt.swapfile = false
opt.undofile = true

-- Formatting
opt.tabstop = 2
opt.shiftwidth = 2
opt.shiftround = true
opt.expandtab = true
opt.wrap = false

-- Interface
opt.confirm = true
opt.guicursor:append("a:blinkwait700-blinkon400-blinkoff250")
opt.relativenumber = true
opt.number = true
opt.mouse = "a"
opt.showcmd = false
opt.splitbelow = true
opt.splitright = true
opt.signcolumn = "yes"

-- Search
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = false
opt.wildignorecase = true
opt.wildignore:append("*.pyc")
opt.wildignore:append("*/venv/*")

-- System
opt.clipboard:append("unnamedplus")
