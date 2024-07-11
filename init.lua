require('config.functions')
require('config.options')

local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        'git',
        'clone',
        '--filter=blob:none',
        'https://github.com/folke/lazy.nvim.git',
        '--branch=stable', -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

local function map(f, t)
    local t1 = {}
    for i = 1, #t do
        t1[i] = f(t[i])
    end
    return t1
end

function LoadPlugins()
    local plugins = {}

    table.insert(plugins, require('plugins.catppuccin'))
    table.insert(plugins, require('plugins.Comment'))
    table.insert(plugins, require('plugins.lualine'))
    table.insert(plugins, require('plugins.vim-sandwich'))
    table.insert(plugins, require('plugins.cinnamon'))

    if vim.g.vscode == nil then
        table.insert(plugins, require('plugins.virt-column'))
    else

    end
    if vim.g.started_by_firenvim == true then
        table.insert(plugins, require('plugins.firevim'))
    end

    require('lazy').setup(
        map(function(plugin)
            return plugin.config
        end, plugins)
    )

    for _, plugin in ipairs(plugins) do
        plugin.init()
    end
end

LoadPlugins()

if vim.g.vscode == nil then
    -- require('config.keymaps')
    -- require('plugins.catppuccin')
    -- require('plugins.nvim-tree')
    -- require('plugins.lualine')
    -- require('plugins.nvim-scrollbar')
    -- require('plugins.gitsigns')
    -- require('plugins.telescope')
    -- require('plugins.nvim-notify')
    -- require('plugins.virt-column')
    -- require('plugins.todo-comments')
    -- require('plugins.nvim-cursor')
    --
    -- require('plugins.neogit')
    -- require('plugins.telescope')
else
    -- require('plugins.vscode-neovim')
end

if vim.g.started_by_firenvim == true then
    -- require('plugins.firenvim')
end

-- require('plugins.vim-smoothie')
-- require('plugins.vim-sandwich')
-- require('plugins.Comment')
-- require('plugins.nvim-lspconfig.nvim-lspconfig')
-- require('plugins.mason.mason')

vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, {
    border = 'rounded',
})
vim.api.nvim_set_hl(0, 'NormalFloat', { bg = nil })
