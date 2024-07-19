local telescope_builtin_status, telescope_builtin = pcall(require, 'telescope.builtin')
local neogit_status, neogit = pcall(require, 'neogit')
local hop_status, hop = pcall(require, 'hop')
local neotree_command_status, neotree_command = pcall(require, 'neo-tree.command')
local hop_hint_status, hop_hint = pcall(require, 'hop.hint')
local toggleterm_terminal_status, toggleterm_terminal = pcall(require, 'toggleterm.terminal')

vim.keymap.set({ 'n', 'i' }, '<C-k><C-m>', function()
    if telescope_builtin_status then
        telescope_builtin.filetypes()
    end
end, {
    desc = 'Open telescope filetypes'
});


vim.keymap.set({ 'n', 'i' }, '<A-f><A-f>', function()
    if neotree_command_status then
        local reveal_file = vim.fn.expand('%:p')
        if (reveal_file == '') then
            reveal_file = vim.fn.getcwd()
        else
            local f = io.open(reveal_file, 'r')
            if (f) then
                f.close(f)
            else
                reveal_file = vim.fn.getcwd()
            end
        end
        neotree_command.execute({
            reveal_file = reveal_file,
            reveal_force_cwd = true,
        })
    end
end, {
    desc = 'Focus: neo-tree'
});

vim.keymap.set('n', '<A-f><A-e>', function()

end, {
    desc = 'Focus: Editor'
})

vim.keymap.set('n', '<A-f><A-g>', function()
    if neogit_status then
        neogit.open({
            kind = 'vsplit_left'
        })
    end
end, {
    desc = 'Focus: Neogit'
})

vim.keymap.set('n', '<A-f><A-i>', function()
    vim.cmd('TodoLocList')
end, {
    desc = 'Focus: todo'
})

vim.keymap.set('n', '<A-f><A-t>', function()
    if toggleterm_terminal_status then
        local terminal = toggleterm_terminal.Terminal:new({
            cmd = 'pwsh',
            direction = 'horizontal',
            on_open = function(term)
                vim.cmd('startinsert!')
                vim.api.nvim_buf_set_keymap(term.bufnr, 'n', 'q', '<cmd>close<CR>', {
                    silent = true
                })
            end,
            on_close = function(term)
                vim.cmd('startinsert!')
            end,
        })

        terminal:toggle()
    end
end, {
    desc = 'Focus: Terminal'
})

vim.keymap.set({ 'n', 'i' }, '<A-g><A-g>', function()
    if neogit_status then
        neogit.open({
            'log',
            kind = 'tab'
        })
    end
end, {
    desc = 'Git: Log'
})

vim.keymap.set('n', '<A-v>', function()
    vim.lsp.buf.hover()
end, {
    desc = 'hover'
})

vim.keymap.set('n', '<A-e>', function()
    -- require('telescope').extensions['recent-files'].recent_files({
    --     theme = 'dropdown'
    -- })
    
    if telescope_builtin_status then
        telescope_builtin.buffers()
    end
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
    vim.notify('Test2')
end, {
    desc = 'Test'
})

vim.keymap.set('v', 'J', 'j', {
    silent = true
})
