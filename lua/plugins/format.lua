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
					conform.format({
						force = true,
					})
				end,
				mode = { "n", "i" },
			},
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
					local start_line = vim.fn.line("v")
					local end_line = vim.fn.line(".")
					if start_line > end_line then
						start_line, end_line = end_line, start_line
					end

					conform.format({
						force = true,
						range = {
							start = { start_line, 0 },
							["end"] = { end_line, vim.fn.col({ end_line, "$" }) },
						},
					})
				end,
				mode = { "v" },
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
		---@type conform.setupOpts
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
				latex = { "tex_fmt" },
				ps1 = { "psscriptanalyzer" },
				qml = { "qmlformat" },
				cmake = { "cmake_format" },
			},
			default_format_opts = {
				lsp_format = "fallback",
			},
			formatters = {
				tex_fmt = {
					command = "tex-fmt",
					args = { "--stdin", "--config", "~/.config/tex-fmt.toml" },
				},
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
						"check",
						"--write",
						"--stdin-file-path",
						"$FILENAME",
					},
				},
				taplo = {
					command = "taplo",
					args = {
						"format",
						"-",
					},
				},
				clang_format = {
					args = function(_, _)
                        -- vscode-neovim 대응해서 현재 열린 파일 위치를 vim api로 가져옴
						local dirname = vim.fs.dirname(vim.fn.expand("%:p"))

						local found = vim.fs.find({ ".clang-format", "_clang-format" }, {
							path = dirname,
							upward = true,
						})[1]

						-- 프로젝트에 설정이 있으면 clang-format 기본 동작에 맡김
						if found then
							return { "-assume-filename", "$FILENAME" }
						end

						-- 없으면 XDG 전역 설정을 명시적으로 지정
						local xdg = vim.env.XDG_CONFIG_HOME or (vim.env.HOME .. "/.config")
						local global = xdg .. "/clang-format/.clang-format"
						return { "-assume-filename", "$FILENAME", "--style=file:" .. global }
					end,
				},
				psscriptanalyzer = {
					command = "pwsh",
					args = {
						"-NoProfile",
						"-Command",
						"Invoke-Formatter -ScriptDefinition ([Console]::In.ReadToEnd())",
					},
					stdin = true,
				},
				qmlformat = {
					command = "qmlformat",
					args = {
						"-i",
						"$FILENAME",
					},
					stdin = false,
					tmpfile_format = ".conform.$RANDOM.qml",
				},
				cmake_format = {
					command = "cmake-format",
					args = { "-" },
				},
			},
		},
		event = "VeryLazy",
		vscode = true,
	},
}
