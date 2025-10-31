return {
	--- @type LazySpec
	{
		"snacks.nvim",
		opts = function()
			return {
				dashboard = {
					preset = {
						pick = function(cmd, opts)
							return LazyVim.pick(cmd, opts)()
						end,
						header = "version: "
							.. vim.version().major
							.. "."
							.. vim.version().minor
							.. "."
							.. vim.version().patch,
						keys = {
							{
								icon = " ",
								key = "f",
								desc = "Find File",
								action = ":lua Snacks.dashboard.pick('files')",
							},
							{ icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
							{
								icon = " ",
								key = "g",
								desc = "Find Text",
								action = ":lua Snacks.dashboard.pick('live_grep')",
							},
							{
								icon = " ",
								key = "r",
								desc = "Recent Files",
								action = ":lua Snacks.dashboard.pick('oldfiles')",
							},
							{
								icon = " ",
								key = "c",
								desc = "Config",
								action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})",
							},
							{ icon = " ", key = "s", desc = "Restore Session", section = "session" },
							{ icon = " ", key = "m", desc = "Mason", action = ":Mason" },
							{ icon = "󰒲 ", key = "l", desc = "Lazy", action = ":Lazy" },
							{ icon = " ", key = "q", desc = "Quit", action = ":qa" },
						},
					},
				},
			}
		end,
	},
	{
		"akinsho/bufferline.nvim",
		version = "*",
		dependencies = "nvim-tree/nvim-web-devicons",
		keys = function()
			return {}
		end,
		opts = {
			options = {
				mode = "tabs",
				separator_style = "slant",
				always_show_bufferline = true,
			},
		},
		cond = vim.g.vscode == nil,
	},
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		priority = 1000,
		opts = function()
			local function is_neo_tree()
				return vim.bo.filetype == "neo-tree"
			end
			local function is_todo()
				return vim.bo.filetype == "qf"
			end
			local function is_firenvim()
				return vim.g.started_by_firenvim
			end

			if vim.g.vscode ~= nil then
				return {
					options = {
						icons_enabled = true,
						disabled_filetypes = {
							statusline = {},
							winbar = {},
						},
						component_separators = { left = " ", right = " " },
						section_separators = { left = " ", right = " " },
						ignore_focus = {},
						always_divide_middle = true,
						globalstatus = true,
						refresh = {
							statusline = 100,
							tabline = 100,
							winbar = 100,
						},
					},
					sections = {
						lualine_a = {
							{
								"mode",
								cond = function()
									return (not is_neo_tree()) and (not is_todo())
								end,
							},
						},
						lualine_b = {},
						lualine_c = {},
						lualine_x = {},
						lualine_y = {},
						lualine_z = {},
					},
					inactive_sections = {
						lualine_a = {},
						lualine_b = {},
						lualine_c = {},
						lualine_x = {},
						lualine_y = {},
						lualine_z = {},
					},
					extensions = {},
				}
			end

			return {
				options = {
					icons_enabled = true,
					theme = "auto",
					component_separators = { left = "", right = "" },
					section_separators = { left = "", right = "" },
					disabled_filetypes = {
						statusline = {},
						winbar = {},
					},
					ignore_focus = {},
					always_divide_middle = true,
					globalstatus = true,
					refresh = {
						statusline = 100,
						tabline = 100,
						winbar = 100,
					},
				},
				sections = {
					lualine_a = {
						{
							"mode",
							cond = function()
								return (not is_neo_tree()) and (not is_todo())
							end,
						},
					},
					lualine_b = {
						{
							"branch",
							cond = function()
								return (not is_todo())
							end,
						},
						{
							"diff",
							cond = function()
								return (not is_neo_tree()) and (not is_todo())
							end,
						},
						{
							"diagnostics",
							cond = function()
								return (not is_neo_tree()) and (not is_todo())
							end,
						},
					},
					lualine_c = {
						{
							"filename",
							cond = function()
								return (not is_neo_tree()) and (not is_firenvim()) and (not is_todo())
							end,
						},
					},
					lualine_x = {},
					lualine_y = {
						{
							"location",
							cond = function()
								return (not is_neo_tree()) and (not is_todo())
							end,
						},
						{
							"encoding",
							cond = function()
								return (not is_neo_tree()) and (not is_todo())
							end,
						},
						{
							"fileformat",
							symbols = {
								unix = "LF",
								dos = "CRLF",
								mac = "CR",
							},
							cond = function()
								return (not is_neo_tree()) and (not is_todo())
							end,
						},
					},
					lualine_z = {
						{
							"filetype",
							cond = function()
								return (not is_neo_tree()) and (not is_todo())
							end,
						},
					},
				},
				inactive_sections = {
					lualine_a = {},
					lualine_b = {},
					lualine_c = {},
					lualine_x = {},
					lualine_y = {},
					lualine_z = {},
				},
				extensions = {},
			}
		end,
		cond = vim.g.vscode == nil,
	},
	{
		"petertriho/nvim-scrollbar",
		opts = {},
		cond = vim.g.vscode == nil,
	},
	{
		"karb94/neoscroll.nvim",
		opts = {
			mappings = { -- Keys to be mapped to their corresponding default scrolling animation
				"<C-u>",
				"<C-d>",
				"<C-b>",
				"<C-f>",
				"<C-y>",
				"<C-e>",
				-- 'zt',
				-- 'zz',
				-- 'zb',
			},
			hide_cursor = false, -- Hide cursor while scrolling
			stop_eof = true, -- Stop at <EOF> when scrolling downwards
			respect_scrolloff = false, -- Stop scrolling when the cursor reaches the scrolloff margin of the file
			cursor_scrolls_alone = true, -- The cursor will keep on scrolling even if the window cannot scroll further
			easing = "cubic", -- Default easing function
			pre_hook = nil, -- Function to run before the scrolling animation starts
			post_hook = nil, -- Function to run after the scrolling animation ends
			performance_mode = false, -- Disable 'Performance Mode' on all buffers.
		},
		cond = true,
	},
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons",
			"MunifTanjim/nui.nvim",
			"3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
		},
		opts = {
			default_component_configs = {
				indent = {
					indent_size = 2,
					padding = 1,
					with_markers = true,
					indent_marker = "│",
					last_indent_marker = "└",
				},
				icon = {
					folder_closed = "󰉋",
					folder_open = "󰝰",
					folder_empty = "󰷏",
				},
				modified = {
					symbol = "",
				},
				git_status = {
					symbols = {
						added = "󰐕",
						modified = "",
						deleted = "󰗨",
						renamed = "󰑕",
						untracked = "",
						ignored = "",
						unstaged = "󰄱",
						staged = "",
						conflict = "",
					},
				},
			},
			filesystem = {
				bind_to_cwd = true,
				filtered_items = {
					visible = true, -- when true, they will just be displayed differently than normal items
					hide_dotfiles = false,
					hide_gitignored = false,
					hide_hidden = false, -- only works on Windows for hidden files/directories
					hide_by_name = {
						-- 'node_modules'
					},
					always_show_by_pattern = {
						".*",
					},
				},
			},
			window = {
				position = "float",
				mappings = {
					["h"] = "close_node",
					["l"] = "open",
				},
			},
		},
		cond = vim.g.vscode == nil,
	},
}
