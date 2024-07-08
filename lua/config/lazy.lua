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

require('lazy').setup({
    {
        "catppuccin/nvim",
        name = "catppuccin",
        priority = 1000,
    },
    {
        'nvim-tree/nvim-tree.lua',
        version = '*',
        lazy = false,
        dependencies = {
            'nvim-tree/nvim-web-devicons',
        },
    },
    {
        'nvim-lualine/lualine.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
    },
    {
        'smoka7/hop.nvim',
        version = '*',
        opts = {},
    },
    {
        'psliwka/vim-smoothie',
    },
    {
        'petertriho/nvim-scrollbar',
    },
    {
        'machakann/vim-sandwich',
    },
    {
        'numToStr/Comment.nvim',
        opts = {
            -- add any options here
        },
        lazy = false,
    },
    {
        'lewis6991/gitsigns.nvim',
    },
    {
        'stevearc/conform.nvim',
        opts = {},
    },
    vim.g.started_by_firenvim == true and {
        'glacambre/firenvim',
        lazy = false,
        build = function() vim.fn['firenvim#install'](0) end,
    } or nil,
    {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.5',
        -- or                              , branch = '0.1.x',
        dependencies = {
            'nvim-lua/plenary.nvim',
        },
    },
    {
        'neovim/nvim-lspconfig',
    },
    {
        'williamboman/mason.nvim',
        'williamboman/mason-lspconfig.nvim',
        'neovim/nvim-lspconfig',
        'mfussenegger/nvim-dap',
        'rcarriga/nvim-dap-ui',
    },
    {
        'rcarriga/nvim-notify',
    },
    {
        'lukas-reineke/virt-column.nvim',
    },
    {
        'folke/todo-comments.nvim',
        dependencies = {
            'nvim-lua/plenary.nvim',
        },
    },
    {
        'NeogitOrg/neogit',
        dependencies = {
            'nvim-lua/plenary.nvim',  -- required
            'sindrets/diffview.nvim', -- optional - Diff integration

            -- Only one of these is needed, not both.
            'nvim-telescope/telescope.nvim', -- optional
            'ibhagwan/fzf-lua',              -- optional
        },
        config = true,
    },
    {
        'phanviet/nvim-cursor'
    },
    vim.g.vscode == nil and {
        'github/copilot.vim'
    } or nil
})
