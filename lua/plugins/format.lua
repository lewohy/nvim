return {
	{
		"stevearc/conform.nvim",
		keys = function()
			return {
				{
					"<C-A-F>",
					function()
						require("conform").format({ formatters = { "injected" }, timeout_ms = 3000 })
					end,
					mode = { "n", "v" },
					desc = "Format Injected Langs",
				},
			}
		end,
		opts = {
			formatters_by_ft = {
				lua = { "stylua" },
				python = {
					"ruff_fix",
					"ruff_format",
					"ruff_organize_imports",
				},
				cpp = { "clang-format" },
				rust = { "rustfmt" },
				json = { "jq_indent4" },
                java = { "google-java-format" },
			},
			default_format_opts = {
				lsp_format = "fallback",
			},
			formatters = {
				jq_indent4 = {
					meta = {
						url = "https://github.com/stedolan/jq",
						description = "command-line json processor.",
					},
					command = "jq",
					args = {
						"--indent",
						"4",
					},
				},
			},
		},
		vscode = true,
	},
}
