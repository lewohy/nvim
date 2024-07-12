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

local builtin = require('telescope.builtin')

vim.keymap.set(
    'n',
    '<A-e>',
    builtin.buffers
)

local hop = require('hop')
local directions = require('hop.hint').HintDirection

vim.keymap.set('n', '<leader><leader>e', function()
    hop.hint_words({
        direction = directions.AFTER_CURSOR
    })
end, {
    remap = true
})
