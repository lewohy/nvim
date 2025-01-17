local telescope_builtin_status, telescope_builtin = pcall(require, 'telescope.builtin')
local neogit_status, neogit = pcall(require, 'neogit')
local hop_status, hop = pcall(require, 'hop')
local hop_hint_status, hop_hint = pcall(require, 'hop.hint')
local neotree_command_status, neotree_command = pcall(require, 'neo-tree.command')
local toggleterm_terminal_status, toggleterm_terminal = pcall(require, 'toggleterm.terminal')
local nui_status, Popup = pcall(require, 'nui.popup')

local functions = {}

function functions.open_note()
    if nui_status then
        local event = require('nui.utils.autocmd').event

        local popup = Popup({
            enter = true,
            focusable = true,
            border = {
                style = "rounded",
            },
            position = "50%",
            size = {
                width = "80%",
                height = "60%",
            },
        })

        -- mount/open the component
        popup:mount()

        -- unmount component when cursor leaves buffer
        popup:on(event.BufLeave, function()
            popup:unmount()
        end)

        -- set content
        vim.api.nvim_buf_set_lines(popup.bufnr, 0, 1, false, {
            "Hello World",
            "a"
        })
    end
end

function functions.open_telescope_filetypes()
    if telescope_builtin_status then
        telescope_builtin.filetypes()
    end
end

function functions.reveal_file_in_neotree()
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
            position = "float",
            reveal_force_cwd = true,
        })
    end
end

function functions.open_neogit()
    if neogit_status then
        neogit.open({})
    end
end

function functions.open_todo_list()
    vim.cmd('TodoLocList')
end

function functions.open_terminal()
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
end

function functions.open_neogit_graph()
    if neogit_status then
        neogit.action(
            'log', 'log_current', { "--graph", "--decorate" }
        )()
    end
end

function functions.show_hover()
    -- vim.lsp.buf.hover()
    vim.diagnostic.open_float()
end

function functions.open_telescope_recent()
    -- require('telescope').extensions['recent-files'].recent_files({
    --     theme = 'dropdown'
    -- })

    if telescope_builtin_status then
        telescope_builtin.buffers()
    end
end

function functions.hop_after_cursor()
    if hop_status and hop_hint_status then
        hop.hint_words({
            direction = hop_hint.HintDirection.AFTER_CURSOR
        })
    end
end

function functions.hop_before_cursor()
    if hop_status and hop_hint_status then
        hop.hint_words({
            direction = hop_hint.HintDirection.BEFORE_CURSOR
        })
    end
end

return functions
