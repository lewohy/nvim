local functions = require('config.functions')

vim.keymap.set({ 'n', 'i' }, '<C-k><C-m>', function()
    functions.open_telescope_filetypes()
end, {
    desc = 'telescope: filetypes'
});


vim.keymap.set({ 'n', 'i' }, '<A-f><A-f>', function()
    functions.reveal_file_in_neotree()
end, {
    desc = 'neotree: reveal file'
});

vim.keymap.set('n', '<A-f><A-e>', function()

end, {
    desc = 'Focus: Editor'
})

vim.keymap.set('n', '<A-f><A-g>', function()
    functions.open_neogit()
end, {
    desc = 'Focus: Neogit'
})

vim.keymap.set('n', '<A-f><A-i>', function()
    functions.open_todo_list()
end, {
    desc = 'Focus: todo'
})

vim.keymap.set('n', '<A-f><A-t>', function()
    functions.open_terminal()
end, {
    desc = 'Focus: Terminal'
})

vim.keymap.set({ 'n', 'i' }, '<A-g><A-g>', function()
    functions.open_neogit_graph()
end, {
    desc = 'Git: Graph'
})

vim.keymap.set('n', '<A-v>', function()
    functions.show_hover()
end, {
    desc = 'hover'
})

vim.keymap.set('n', '<A-e>', function()
    functions.open_telescope_recent()
end, {
    desc = 'Open telescope buffers'
})

vim.keymap.set('n', '<leader><leader>e', function()
    if hop_status and hop_hint_status then
        hop.hint_words({
            direction = hop_hint.HintDirection.AFTER_CURSOR
        })
    end
end, {
    desc = 'Hop: After cursor'
})

vim.keymap.set('n', '<leader><leader>b', function()
    if hop_status and hop_hint_status then
        hop.hint_words({
            direction = hop_hint.HintDirection.BEFORE_CURSOR
        })
    end
end, {
    desc = 'Hop: Before cursor'
})

vim.keymap.set('n', '<leader><leader>t', function()
    require('gitgraph').draw({}, { all = true, max_count = 5000 })
end, {
    desc = 'Test'
})

vim.keymap.set('v', 'J', 'j', {
    silent = true
})
