-- local neogit = require('neogit')

vim.keymap.set(
    'n',
    '<A-w><A-f>',
    '<ESC>:NvimTreeToggle<CR>',
    { desc = 'nvim-tree: Toggle' }
)

vim.keymap.set('n', '"', '<ESC>:reg<CR>"')

-- focus
vim.keymap.set(
    'n',
    '<A-f><A-f>',
    '<ESC>:NvimTreeFocus<CR>',
    { desc = 'nvim-tree: Focus' }
)
vim.keymap.set(
    'n',
    '<A-f><A-e>',
    '<ESC>:wincmd w<CR>',
    { desc = 'editor: Focus' }
)
-- vim.keymap.set(
--     'n',
--     '<A-f><A-g>',
--     function() neogit.open({}) end,
--     { desc = 'Neogit: open' }
-- )
vim.keymap.set(
    'n',
    '<A-f><A-t>',
    '<ESC>:TodoLocList<CR>',
    { desc = 'todo: Focus' }
)

vim.keymap.set(
    'n',
    '<A-e>',
    '<ESC>:Telescope oldfiles<CR>',
    { desc = 'Telescope: oldfiles' }
)

vim.keymap.set(
    'n',
    'j',
    'gj',
    { desc = 'j: gj' }
)

vim.keymap.set(
    'n',
    'k',
    'gk',
    { desc = 'k: gk' }
)

-- git
-- vim.keymap.set('n', '<A-g><A-p>', function()
--     neogit.open({ 'log' })
--     vim.api.nvim_input('l')
-- end, { desc = 'Neogit: log_view' })
--
-- -- hover
-- vim.keymap.set('n', '<A-v>', function()
--     vim.lsp.buf.hover()
-- end, { desc = 'Neogit: log_view' })
--
