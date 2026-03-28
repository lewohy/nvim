return {
	{
		"mason-org/mason.nvim",
		version = "^1.0.0",
		opts = {
			ensure_installed = {
				-- lsp
				"clangd",
				"eslint-lsp",
				"kotlin-lsp",

				-- formatters
				"stylua",
				"shfmt",
				"ruff",
				"rustfmt",
				"biome",
				"clang-format",
				"google-java-format",
				"yamlfmt",
			},
		},
		event = "VeryLazy",
		cond = true,
	},
	{ "mason-org/mason-lspconfig.nvim", cond = true },
}
