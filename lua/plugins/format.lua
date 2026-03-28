local function create_clang_format_config()
	if vim.fn.filereadable(".clang-format") == 1 then
		return {
			command = "clang-format",
		}
	end

	return {
		command = "clang-format",
		args = {
			"--style=file:/home/lewohy/.config/clang-format/.clang-format",
		},
	}
end

return {
	{
		"stevearc/conform.nvim",
		keys = {
			{
				"<A-F>",
				function()
					if vim.g.vscode then
						local filename = vim.fn.expand("%:p")
						local test_str = "vscode-remote://dev-container"
						if filename:sub(1, test_str:len()) == test_str then
							vim.notify("Using VSCode Formatter")

							local vscode = require("vscode")
							vscode.action("editor.action.formatDocument")
							return
						end
					end

					local conform = require("conform")
					conform.format({ force = true })
				end,
				mode = { "n", "i" },
			},
			-- {
			-- 	"<leader>f",
			-- 	function()
			-- 		require("conform").format({ formatters = { "injected" }, timeout_ms = 3000 })
			-- 	end,
			-- 	mode = { "n", "i" },
			-- 	desc = "Format Injected Langs",
			-- },
		},
		opts = {
			format_on_save = nil,
			lang_to_ext = {
				c_sharp = "cs",
			},
			formatters_by_ft = {
				lua = { "stylua" },
				python = {
					"ruff_fix",
					"ruff_format",
					"ruff_organize_imports",
				},
				cpp = { "clang_format" },
				c = { "clang_format" },
				cs = { "csharpier" },
				rust = { "rustfmt" },
				wgsl = { "wgslfmt" },
				json = { "biome" },
				jsonc = { "biome" },
				java = { "google_java_format_aosp" },
				css = { "biome" },
				javascript = { "biome" },
				javascriptreact = { "biome" },
				typescript = { "biome" },
				typescriptreact = { "biome" },
				yaml = { "yamlfmt" },
				typst = { "typstyle" },
				toml = { "taplo" },
				dockerfile = { "dockerfmt" },
				meson = { "mesonfmt" },
				html = { "biome" },
			},
			default_format_opts = {
				lsp_format = "fallback",
			},
			formatters = {
				typstyle = {
					command = "typstyle",
					args = { "--indent-width", "4" },
				},
				google_java_format_aosp = {
					command = "google-java-format",
					args = { "--aosp", "-" },
				},
				csharpier = {
					command = "csharpier",
					args = { "format" },
				},
				mesonfmt = {
					command = "meson",
					args = { "format" },
				},
				wgslfmt = {
					command = "wgslfmt",
				},
				biome = {
					command = "biome",
					args = {
						"format",
						"--stdin-file-path",
                        "$FILENAME",
					},
				},
				-- biome_jsonc = {
				-- 	command = "biome",
				-- 	args = {
				-- 		"format",
				-- 		"--indent-style",
				-- 		"space",
				-- 		"--indent-width",
				-- 		"4",
				-- 		"--json-formatter-trailing-commas",
				-- 		"all",
				-- 		"--stdin-file-path",
				-- 		"foo.jsonc",
				-- 	},
				-- },
				taplo = {
					command = "taplo",
					args = {
						"format",
						"-",
					},
				},
				clang_format = create_clang_format_config(),
			},
		},
		event = "VeryLazy",
		vscode = true,
	},
}
