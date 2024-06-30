FileSeperator = vim.loop.os_uname().sysname == 'Windows' and '\\' or '/'

require('config.functions')
require('config.lazy')
require('config.options')

if vim.g.vscode == nil then
    require('config.keymaps')
    require('plugins.catppuccin')
    require('plugins.nvim-tree')
    require('plugins.lualine')
    require('plugins.nvim-scrollbar')
    require('plugins.gitsigns')
    require('plugins.firenvim')
    require('plugins.telescope')
    require('plugins.nvim-notify')
    require('plugins.virt-column')
    require('plugins.todo-comments')
    require('plugins.nvim-cursor')
else
    require('plugins.vscode-neovim')
end
require('plugins.vim-smoothie')
require('plugins.vim-sandwich')
require('plugins.Comment')
require('plugins.nvim-lspconfig.nvim-lspconfig')
require('plugins.mason.mason')

vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, {
    border = 'rounded',
})
vim.api.nvim_set_hl(0, 'NormalFloat', { bg = nil })
