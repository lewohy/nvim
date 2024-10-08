local function set_ime(args)
    if args.event:match("Enter$") then
        vim.g.neovide_input_ime = true
    else
        vim.g.neovide_input_ime = false
    end
end

local ime_input = vim.api.nvim_create_augroup("ime_input", { clear = true })

vim.api.nvim_create_autocmd({ "InsertEnter", "InsertLeave" }, {
    group = ime_input,
    pattern = "*",
    callback = set_ime
})

vim.api.nvim_create_autocmd({ "CmdlineEnter", "CmdlineLeave" }, {
    group = ime_input,
    pattern = "[/\\?]",
    callback = set_ime
})

vim.g.neovide_cursor_vfx_mode = "pixiedust"
vim.g.neovide_cursor_vfx_particle_density = 100.0

vim.keymap.set('v', '<C-Insert>', '"+y')
vim.keymap.set('n', '<S-Insert>', '"+P')
vim.keymap.set('v', '<S-Insert>', '"+P')
vim.keymap.set('c', '<S-Insert>', '<C-R>+')
vim.keymap.set('i', '<S-Insert>', '<ESC>l"+Pli')
