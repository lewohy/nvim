vim.api.nvim_create_autocmd(
    { "FocusGained", "InsertLeave", "CmdlineEnter" },
    {
        callback = function()
            vim.fn.system('fcitx5-remote -c')
        end,
        group = vim.api.nvim_create_augroup('fcitx5_reset', { clear = true }),
    }
)

if vim.g.vscode ~= nil then
    vim.api.nvim_create_autocmd({ "BufWriteCmd" }, {
        pattern = "*",
        callback = function()
            local vscode = require('vscode')
            vscode.action('workbench.action.files.save')
        end,
    })
end
