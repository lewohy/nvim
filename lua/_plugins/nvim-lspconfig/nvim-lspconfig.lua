local lspconfig = require('lspconfig')

lspconfig.pyright.setup({})
lspconfig.tsserver.setup({})
lspconfig.lua_ls.setup({
    settings = {
        Lua = {
            diagnostics = {
                globals = { 'vim' },
            },
            workspace = {
                -- Make the server aware of Neovim runtime files
                library = vim.api.nvim_get_runtime_file('', true),
            },
            -- Do not send telemetry data containing a randomized but unique identifier
            telemetry = {
                enable = false,
            },
        },
    },
})
lspconfig.bashls.setup({})
lspconfig.clangd.setup({})
lspconfig.cmake.setup({})
lspconfig.eslint.setup({})
lspconfig.gradle_ls.setup({})
lspconfig.html.setup({})
lspconfig.jdtls.setup({})
lspconfig.kotlin_language_server.setup({})
lspconfig.omnisharp.setup({})
lspconfig.yamlls.setup({})
