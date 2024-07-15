require('config.functions')
require('config.options')
require('config.lazy')
require('config.keymaps')

if vim.g.vscode then
    local vscode = require('vscode')
    vim.notify = vscode.notify
end

if vim.g.neovide then
    require('config.neovide')
end

vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, {
    border = 'rounded',
})
vim.api.nvim_set_hl(0, 'NormalFloat', {
    bg = nil
})

