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
				cpp = { "clang_format" },
				c = { "clang_format" },
				rust = { "rustfmt" },
				wgsl = { "wgslfmt" },
				json = { "biome_json" },
				jsonc = { "biome_jsonc" },
				java = { "google-java-format" },
				css = { "biome_css" },
				javascript = { "biome_js" },
				javascriptreact = { "biome_jsx" },
				typescript = { "biome_ts" },
				typescriptreact = { "biome_tsx" },
				yaml = { "yamlfmt" },
				typst = { "typstyle" },
				toml = { "taplo" },
				dockerfile = { "dockerfmt" },
				meson = { "mesonfmt" },
			},
			default_format_opts = {
				lsp_format = "fallback",
			},
			formatters = {
				mesonfmt = {
					command = "meson",
					args = { "format" },
				},
				wgslfmt = {
					command = "wgslfmt",
				},
				biome_json = {
					command = "biome",
					args = {
						"format",
						"--indent-style",
						"space",
						"--indent-width",
						"4",
						"--stdin-file-path",
						"foo.json",
					},
				},
				biome_jsonc = {
					command = "biome",
					args = {
						"format",
						"--indent-style",
						"space",
						"--indent-width",
						"4",
						"--stdin-file-path",
						"foo.jsonc",
					},
				},
				biome_css = {
					command = "biome",
					args = {
						"format",
						"--indent-style",
						"space",
						"--indent-width",
						"4",
						"--stdin-file-path",
						"foo.css",
					},
				},
				biome_js = {
					command = "biome",
					args = {
						"format",
						"--indent-style",
						"space",
						"--indent-width",
						"4",
						"--stdin-file-path",
						"foo.js",
					},
				},
				biome_ts = {
					command = "biome",
					args = {
						"format",
						"--indent-style",
						"space",
						"--indent-width",
						"4",
						"--stdin-file-path",
						"foo.ts",
					},
				},
				biome_jsx = {
					command = "biome",
					args = {
						"format",
						"--indent-style",
						"space",
						"--indent-width",
						"4",
						"--stdin-file-path",
						"foo.jsx",
					},
				},
				biome_tsx = {
					command = "biome",
					args = {
						"format",
						"--indent-style",
						"space",
						"--indent-width",
						"4",
						"--stdin-file-path",
						"foo.tsx",
					},
				},
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
		vscode = true,
	},
}
