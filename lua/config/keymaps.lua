local telescope_builtin = require('telescope.builtin')
local neogit = require('neogit')
local hop = require('hop')
local directions = require('hop.hint').HintDirection

vim.keymap.set({
    'n',
    'i'
}, '<C-k><C-m>', function()
    telescope_builtin.filetypes()
end, {
    desc = 'Open telescope filetypes'
});


vim.keymap.set({
    'n',
    'i'
}, '<A-f><A-f>', function()
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
    require('neo-tree.command').execute({
        reveal_file = reveal_file,
        reveal_force_cwd = true,
    })
end, {
    desc = 'Focus: neo-tree'
});

vim.keymap.set('n', '<A-f><A-e>', function()

end, {
    desc = 'Focus: Editor'
})

vim.keymap.set('n', '<A-f><A-g>', function()
    neogit.open({
        kind = 'vsplit_left'
    })
end, {
    desc = 'Focus: Neogit'
})

vim.keymap.set('n', '<A-f><A-i>', function()
    vim.cmd('TodoLocList')
end, {
    desc = 'Focus: todo'
})

vim.keymap.set('n', '<A-f><A-t>', function()
    local toggleterm_terminal = require('toggleterm.terminal')
    local terminal = toggleterm_terminal.Terminal:new({
        cmd = 'pwsh',
        direction = 'horizontal',
        on_open = function(term)
            vim.cmd('startinsert!')
            vim.api.nvim_buf_set_keymap(term.bufnr, 'n', 'q', '<cmd>close<CR>', { noremap = true, silent = true })
        end,
        on_close = function(term)
            vim.cmd('startinsert!')
        end,
    })

    terminal:toggle()
end, {
    remap = true
})

vim.keymap.set(
    {
        'n',
        'i'
    },
    '<A-g><A-g>',
    function()
        neogit.open({
            'log',
            kind = 'tab'
        })
    end,
    {
        desc = 'Git: Log'
    }
)

vim.keymap.set('n', '<A-v>', function()
    vim.lsp.buf.hover()
end, {
    desc = 'Neogit: log_view'
})

vim.keymap.set(
    'n',
    '<A-e>',
    telescope_builtin.buffers
)

vim.keymap.set('n', '<leader><leader>e', function()
    hop.hint_words({
        direction = directions.AFTER_CURSOR
    })
end, {
    remap = true
})

vim.keymap.set('n', '<leader><leader>b', function()
    hop.hint_words({
        direction = directions.BEFORE_CURSOR
    })
end, {
    remap = true
})

vim.keymap.set('n', '<leader><leader>t', function()
    vim.notify('Test')

    -- 현재 열려있는 모든 윈도우의 ID를 가져옴
    local window_list = vim.api.nvim_list_wins()

    -- 각 윈도우의 버퍼 번호를 가져오고, 출력함
    for _, win in ipairs(window_list) do
        local buf = vim.api.nvim_win_get_buf(win)
        print("Window ID: " .. win .. " Buffer ID: " .. buf)
    end
end, {
    remap = true
})

vim.keymap.set('v', 'J', 'j', { noremap = true, silent = true })
