local a = {
	{
		"glacambre/firenvim",
		lazy = false,
		-- cond = vim.g.started_by_firenvim == true,
		build = function()
			vim.fn["firenvim#install"](0)
		end,
		init = function()
			vim.g.firenvim_config = {
				globalSettings = { alt = "all" },
				localSettings = {
					[".*"] = {
						cmdline = "neovim",
						content = "text",
						priority = 0,
						selector = "textarea",
						takeover = "never",
					},
				},
			}

			vim.opt.guifont = { "JetBrainsMono Nerd Font", ":h10" }
		end,
		opts = {},
		config = function(_, opts)
			if vim.g.started_by_firenvim == true then
				local id = vim.api.nvim_create_augroup("ExpandLinesOnTextChanged", { clear = true })
				local max_height = 20
				local height_offset = 4
				local resize_window = function(event)
					local height = vim.api.nvim_win_text_height(0, {}).all + height_offset

					if height > vim.o.lines and height < max_height then
						vim.o.lines = height
						vim.cmd("norm! zb")
					end
				end

				vim.api.nvim_create_autocmd({ "TextChanged", "TextChangedI" }, {
					group = id,
					callback = function(event)
						resize_window(event)

						if vim.g.timer_started == true then
							return
						end
						vim.g.timer_started = true
						vim.fn.timer_start(1000, function()
							vim.g.timer_started = false
							vim.cmd("silent! write")

							vim.fn.timer_start(100, function()
								resize_window(event)
							end)
						end)
					end,
				})

				vim.api.nvim_create_autocmd({ "UIEnter" }, {
					group = id,
					callback = function(event)
						vim.fn.timer_start(100, function()
							resize_window(event)
						end)
					end,
				})
			end
		end,
	},
	-- {
	--     'keaising/im-select.nvim',
	--     opts = function()
	--         ---@diagnostic disable-next-line: undefined-field
	--         if (vim.uv.os_uname().sysname == 'Windows_NT') then
	--             vim.notify('im-select.nvim for Windows')
	--             return {
	--                 default_im_select = 'en',
	--                 default_command   = 'kren-select.exe',
	--             }
	--         ---@diagnostic disable-next-line: undefined-field
	--         elseif (vim.uv.os_uname().sysname == 'Linux') then
	--             vim.notify('im-select.nvim for Linux')

	--             return {
	--                 default_im_select   = '-c',
	--                 default_command     = 'fcitx5-remote',
	--             }
	--         end
	--     end,
	--     cond = false
	-- },
	{
		"isakbm/gitgraph.nvim",
		dependencies = { "sindrets/diffview.nvim" },
		opts = {
			symbols = {
				merge_commit = "M",
				commit = "*",
			},
			format = {
				timestamp = "%H:%M:%S %d-%m-%Y",
				fields = { "hash", "timestamp", "author", "branch_name", "tag" },
			},
		},
		init = function()
			-- TODO: Move this to a keymap file
			vim.keymap.set("n", "<leader>gl", function()
				require("gitgraph").draw({}, { all = true, max_count = 5000 })
			end, { desc = "new git graph" })
		end,
		config = true,
	},
	{
		"Shougo/deoplete.nvim",
	},
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = true,
	},
	-- {
	--     "hat0uma/csvview.nvim",
	--     ---@module "csvview"
	--     ---@type CsvView.Options
	--     opts = {
	--         parser = { comments = { "#", "//" } },
	--         keymaps = {
	--             -- Text objects for selecting fields
	--             textobject_field_inner = { "if", mode = { "o", "x" } },
	--             textobject_field_outer = { "af", mode = { "o", "x" } },
	--             -- Excel-like navigation:
	--             -- Use <Tab> and <S-Tab> to move horizontally between fields.
	--             -- Use <Enter> and <S-Enter> to move vertically between rows and place the cursor at the end of the field.
	--             -- Note: In terminals, you may need to enable CSI-u mode to use <S-Tab> and <S-Enter>.
	--             jump_next_field_end = { "<Tab>", mode = { "n", "v" } },
	--             jump_prev_field_end = { "<S-Tab>", mode = { "n", "v" } },
	--             jump_next_row = { "<Enter>", mode = { "n", "v" } },
	--             jump_prev_row = { "<S-Enter>", mode = { "n", "v" } },
	--         },
	--     },
	--     cmd = { "CsvViewEnable", "CsvViewDisable", "CsvViewToggle" },
	-- },
}

return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		opts = {
			ensure_installed = { "vim", "regex", "lua", "bash", "markdown", "markdown_inline" },
			sync_install = true,
			auto_install = true,
		},
	},
	{
		"nvim-treesitter/nvim-treesitter-textobjects",
	},
	{
		"MunifTanjim/nui.nvim",
	},
	{
		"rcarriga/nvim-notify",
		opts = function()
			local palettes = require("catppuccin.palettes").get_palette("mocha")

			return {
				fps = 60,
				background_colour = palettes.surface0,
				icons = {
					DEBUG = "",
					ERROR = "",
					INFO = "",
					TRACE = "✎",
					WARN = "",
				},
				level = 2,
				minimum_width = 20,
				render = "wrapped-compact",
				stages = "fade_in_slide_out",
				time_formats = {
					notification = "%T",
					notification_history = "%FT%T",
				},
				timeout = 5000,
				top_down = false,
			}
		end,
	},
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		---@type NoiceConfig
		opts = {
			cmdline = {
				enabled = true, -- enables the Noice cmdline UI
				view = "cmdline_popup", -- view for rendering the cmdline. Change to `cmdline` to get a classic cmdline at the bottom
				opts = {}, -- global options for the cmdline. See section on views
				---@type table<string, CmdlineFormat>
				format = {
					-- conceal: (default=true) This will hide the text in the cmdline that matches the pattern.
					-- view: (default is cmdline view)
					-- opts: any options passed to the view
					-- icon_hl_group: optional hl_group for the icon
					-- title: set to anything or empty string to hide
					cmdline = { pattern = "^:", icon = "", lang = "vim" },
					search_down = { kind = "search", pattern = "^/", icon = " ", lang = "regex" },
					search_up = { kind = "search", pattern = "^%?", icon = " ", lang = "regex" },
					filter = { pattern = "^:%s*!", icon = "$", lang = "bash" },
					lua = { pattern = { "^:%s*lua%s+", "^:%s*lua%s*=%s*", "^:%s*=%s*" }, icon = "", lang = "lua" },
					help = { pattern = "^:%s*he?l?p?%s+", icon = "󰋖" },
					input = { view = "cmdline_input", icon = "󰥻 " }, -- Used by input()
					-- lua = false, -- to disable a format, set to `false`
				},
			},
			lsp = {
				-- override markdown rendering so that **cmp** and other plugins use **Treesitter**
				override = {
					["vim.lsp.util.convert_input_to_markdown_lines"] = true,
					["vim.lsp.util.stylize_markdown"] = true,
					["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
				},
			},
			notify = {
				view = "notify",
			},
			views = {
				cmdline_popup = {
					position = {
						row = 5,
						col = "50%",
					},
					border = {
						style = "rounded",
						padding = { 0, 1 },
					},
					filter_options = {},
					win_options = {
						winhighlight = "NormalFloat:NormalFloat,FloatBorder:FloatBorder",
					},
				},
				popupmenu = {
					relative = "editor",
					position = {
						row = 8,
						col = "50%",
					},
					size = {
						width = 60,
						height = 10,
					},
					border = {
						style = "rounded",
						padding = { 0, 1 },
					},
					win_options = {
						winhighlight = { Normal = "Normal", FloatBorder = "DiagnosticInfo" },
					},
				},
				hover = {
					border = {
						style = "rounded",
						padding = { 0, 1 },
					},
				},
			},
		},
		dependencies = {
			"MunifTanjim/nui.nvim",
			"rcarriga/nvim-notify",
		},
		-- config = function(_, opts)
		--     local noice = require('noice')
		--     noice.setup(opts)

		--     vim.api.nvim_create_autocmd("CmdlineLeave", {
		--         callback = function()
		--             if vim.fn.getcmdline():sub(1, 1) == '!' then
		--                 local command = vim.fn.getcmdline():sub(2)
		--                 local output = vim.fn.systemlist(command)

		--                 local function strip_ansi_codes(s)
		--                     return s:gsub("\27%[[0-9;]*m", "")
		--                 end

		--                 local function map(tbl, fn)
		--                     local res = {}
		--                     for i, v in ipairs(tbl) do
		--                         res[i] = fn(v)
		--                     end
		--                     return res
		--                 end

		--                 functions.open_popup_command_output(map(output, strip_ansi_codes))
		--             end
		--         end,
		--     })

		--     vim.keymap.set('c', '<S-Enter>', function()
		--         noice.redirect(vim.fn.getcmdline())
		--     end, { desc = 'Redirect Cmdline' })
		-- end,
		cond = vim.g.vscode == nil,
	},
	{
		"folke/ts-comments.nvim",
		opts = {},
		event = "VeryLazy",
		enabled = vim.fn.has("nvim-0.10.0") == 1,
	},
	{
		"lukas-reineke/virt-column.nvim",
		opts = {
			char = "▕",
			virtcolumn = "80,120",
		},
		cond = vim.g.vscode == nil,
	},
	{
		"folke/todo-comments.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		opts = {
			signs = true, -- show icons in the signs column
			sign_priority = 8, -- sign priority
			-- keywords recognized as todo comments
			keywords = {
				FIX = {
					icon = " ", -- icon used for the sign, and in search results
					color = "error", -- can be a hex color, or a named color (see below)
					alt = { "FIXME", "BUG", "FIXIT", "ISSUE" }, -- a set of other keywords that all map to this FIX keywords
					-- signs = false, -- configure signs for some keywords individually
				},
				TODO = { icon = " ", color = "info" },
				HACK = { icon = " ", color = "warning" },
				WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX" } },
				PERF = { icon = " ", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
				NOTE = { icon = " ", color = "hint", alt = { "INFO" } },
				TEST = {
					icon = "⏲ ",
					color = "test",
					alt = { "TESTING", "PASSED", "FAILED" },
				},
			},
			gui_style = {
				fg = "NONE", -- The gui style to use for the fg highlight group.
				bg = "BOLD", -- The gui style to use for the bg highlight group.
			},
			merge_keywords = true, -- when true, custom keywords will be merged with the defaults
			-- highlighting of the line containing the todo comment
			-- * before: highlights before the keyword (typically comment characters)
			-- * keyword: highlights of the keyword
			-- * after: highlights after the keyword (todo text)
			highlight = {
				multiline = true, -- enable multine todo comments
				multiline_pattern = "^.", -- lua pattern to match the next multiline from the start of the matched keyword
				multiline_context = 10, -- extra lines that will be re-evaluated when changing a line
				before = "", -- 'fg' or 'bg' or empty
				keyword = "wide", -- 'fg', 'bg', 'wide', 'wide_bg', 'wide_fg' or empty. (wide and wide_bg is the same as bg, but will also highlight surrounding characters, wide_fg acts accordingly but with fg)
				after = "fg", -- 'fg' or 'bg' or empty
				pattern = [[.*<(KEYWORDS)\s*:]], -- pattern or table of patterns, used for highlighting (vim regex)
				comments_only = true, -- uses treesitter to match keywords in comments only
				max_line_len = 400, -- ignore lines longer than this
				exclude = {}, -- list of file types to exclude highlighting
			},
			-- list of named colors where we try to extract the guifg from the
			-- list of highlight groups or use the hex color if hl not found as a fallback
			colors = {
				error = { "DiagnosticError", "ErrorMsg", "#FF0000" },
				warning = { "DiagnosticWarn", "WarningMsg", "#FFFF00" },
				info = { "DiagnosticInfo", "#2563EB" },
				hint = { "DiagnosticHint", "#10B981" },
				default = { "Identifier", "#7C3AED" },
				test = { "Identifier", "#FF00FF" },
			},
			search = {
				command = "rg",
				args = {
					"--color=never",
					"--no-heading",
					"--with-filename",
					"--line-number",
					"--column",
				},
				-- regex that will be used to match keywords.
				-- don't replace the (KEYWORDS) placeholder
				pattern = [[\b(KEYWORDS):]], -- ripgrep regex
				-- pattern = [[\b(KEYWORDS)\b]], -- match without the extra colon. You'll likely get false positives
			},
		},
		cond = vim.g.vscode == nil,
	},
	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		opts = {
			indent = {
				char = "▏",
			},
		},
		cond = vim.g.vscode == nil,
	},
	{
		"smoka7/hop.nvim",
		version = "*",
		opts = {
			keys = "qwerasdfzxcv",
			quit_key = "<ESC>",
			jump_on_sole_occurrence = false,
			case_insensitive = false,
			multi_windows = true,
		},
		cond = true,
	},
	{
		"zbirenbaum/copilot.lua",
		cmd = "Copilot",
		build = ":Copilot auth",
		opts = {
			suggestion = {
				enabled = true,
				auto_trigger = true,
			},
			filetypes = {
				["*"] = true,
			},
		},
		cond = vim.g.vscode == nil,
	},
	{
		"mikesmithgh/kitty-scrollback.nvim",
		enabled = true,
		lazy = true,
		cmd = {
			"KittyScrollbackGenerateKittens",
			"KittyScrollbackCheckHealth",
			"KittyScrollbackGenerateCommandLineEditing",
		},
		event = { "User KittyScrollbackLaunch" },
		-- version = '*', -- latest stable version, may have breaking changes if major version changed
		-- version = '^6.0.0', -- pin major version, include fixes and features that do not have breaking changes
		config = function()
			require("kitty-scrollback").setup()
		end,
	},
	{
		"nvim-telescope/telescope.nvim",
		branch = "0.1.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"mollerhoj/telescope-recent-files.nvim",
		},
		cond = vim.g.vscode == nil,
		opts = function()
			local actions = require("telescope.actions")

			return {
				pickers = {
					buffers = {
						theme = "dropdown",
					},
					find_files = {
						theme = "dropdown",
					},
					oldfiles = {
						theme = "dropdown",
					},
				},
			}
		end,
	},
}
