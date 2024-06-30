vim.g.mapleader = '\\'

vim.opt.number = true
vim.opt.backspace = 'indent,eol,start'
vim.opt.timeout = false

-- set guifont=JetBrainsMono\ NF
vim.opt.guifont = { 'JetBrainsMono Nerd Font' }
-- vim.opt.guifont = 'JetBrainsMono NF:h14'

-- cursorline
vim.opt.cursorline = true
-- vim.api.nvim_set_hl(0, 'Cursor', {
--     ctermfg = 1
-- })

-- indent
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4

-- search
vim.opt.hlsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.incsearch = true
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.autoindent = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 1

-- paste
vim.opt.paste = false
-- vim.opt.pastetoggle = '<F2>'

-- undo
vim.opt.history = 1000
vim.opt.undolevels = 1000

-- scroll
vim.opt.scrolloff = 3

-- clipboard
vim.opt.clipboard = 'unnamedplus'

vim.opt.termguicolors = true

if vim.g.vscode then vim.opt.shada = '' end

vim.opt.background = 'dark'
