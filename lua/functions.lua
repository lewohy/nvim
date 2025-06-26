local hop_status, hop = pcall(require, 'hop')
local hop_hint_status, hop_hint = pcall(require, 'hop.hint')

local functions = {}

function functions.open_telescope_filetypes()
    local telescope_builtin = require('telescope.builtin')
    telescope_builtin.filetypes()
end

function functions.reveal_file_in_neotree()
    local neotree_command = require('neo-tree.command')
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

function functions.open_neogit()
    local neogit = require('neogit')
    neogit.open({})
end

function functions.open_todo_list()
    vim.cmd('TodoLocList')
end

function functions.open_neogit_graph()
    local neogit = require('neogit')
    neogit.action(
        'log', 'log_current', { "--graph", "--decorate" }
    )()
end

function functions.show_hover()
    vim.lsp.buf.hover()
    vim.diagnostic.open_float()
end

function functions.close_hover()

end

function functions.open_telescope_recent()
    local telescope_builtin = require('telescope.builtin')
    telescope_builtin.buffers()
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

function functions.format_code()
    local lspconfig = require('lspconfig')
    -- eslint를 이용해서 포매팅할 언어들 설정
    local filetypes = lspconfig.eslint.filetypes

    if filetypes then
        for _, filetype in ipairs(filetypes) do
            if vim.bo.filetype == filetype then
                vim.notify('eslint format')
                vim.cmd('EslintFixAll')

                return
            end
        end
    end

    local conform = require('conform')
    local formatters = conform.list_formatters(vim.api.nvim_get_current_buf())

    for _, formatter in ipairs(formatters) do
        vim.notify(
            string.format(
                'Using formatter\n' ..
                '- name: %s\n' ..
                '- command: %s\n' ..
                '- available: %s',
                formatter['name'],
                formatter['command'],
                formatter['available']
            ),
            vim.log.levels.INFO
        )
    end

    conform.format(
        {
            bufnr = vim.api.nvim_get_current_buf(),
        },
        function(err, did_edit)
            if err then
                vim.notify('format error: ' .. err, vim.log.levels.ERROR)
                return
            end
        end
    )
end

-- 커맨드의 출력을 리다이렉트
function functions.noice_redirect_cmd()
    local noice = require('noice')
    noice.redirect(vim.fn.getcmdline())
end

function functions.start_lsp()
    local lspconfig = require('lspconfig')

    lspconfig.pyright.setup {}
    lspconfig.lua_ls.setup {}
    lspconfig.clangd.setup {}
    lspconfig.rust_analyzer.setup {}
    lspconfig.eslint.setup {}
end

function functions.open_popup_command_output(output)
    local Popup = require('nui.popup')

    local event = require("nui.utils.autocmd").event

    -- 팝업 생성
    local popup = Popup({
        position = "50%", -- 화면 중앙
        size = {
            width = math.floor(vim.o.columns * 0.8),
            height = math.floor(vim.o.lines * 0.6),
        },
        enter = true,
        focusable = true,
        border = {
            style = "rounded",
            text = {
                top = "[ Command Output ]",
                top_align = "center",
            },
        },
        buf_options = {
            modifiable = false,
            readonly = true,
        },
        win_options = {
            wrap = true,
            cursorline = false,
        },
    })

    vim.api.nvim_buf_set_lines(popup.bufnr, 0, 1, false, output)


    popup:mount()

    popup:map("n", "<Esc>", function()
        popup:unmount()
    end, { noremap = true, silent = true })
    popup:map("n", "q", function()
        popup:unmount()
    end, { noremap = true, silent = true })
end

return functions
