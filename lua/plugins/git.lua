return {
	{
		"NeogitOrg/neogit",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"sindrets/diffview.nvim",
			"nvim-telescope/telescope.nvim",
			"ibhagwan/fzf-lua",
		},
		opts = {
			graph_style = "unicode",
			kind = "floating",
			commit_editor = {
				kind = "floating",
				show_staged_diff = true,
				-- Accepted values:
				-- 'split' to show the staged diff below the commit editor
				-- 'vsplit' to show it to the right
				-- 'split_above' Like :top split
				-- 'vsplit_left' like :vsplit, but open to the left
				-- 'auto' 'vsplit' if window would have 80 cols, otherwise 'split'
				staged_diff_split_kind = "split",
				spell_check = true,
			},
			commit_select_view = {
				kind = "floating",
			},
			commit_view = {
				kind = "floating",
				verify_commit = vim.fn.executable("gpg") == 1, -- Can be set to true or false, otherwise we try to find the binary
			},
			log_view = {
				kind = "floating",
			},
			rebase_editor = {
				kind = "floating",
			},
			reflog_view = {
				kind = "floating",
			},
			merge_editor = {
				kind = "floating",
			},
			description_editor = {
				kind = "floating",
			},
			tag_editor = {
				kind = "floating",
			},
			preview_buffer = {
				kind = "floating",
			},
			popup = {
				kind = "floating",
			},
			stash = {
				kind = "floating",
			},
			refs_view = {
				kind = "floating",
			},
			signs = {
				-- { CLOSED, OPENED }
				hunk = { "", "" },
				item = { ">", "v" },
				section = { ">", "v" },
			},
			mappings = {
				status = {
					["<ESC>"] = "Close",
				},
			},
		},
		cond = vim.g.vscode == nil,
	},
	{
		"lewis6991/gitsigns.nvim",
		opts = {
			signs = {
				add = { text = "+" },
				change = { text = "│" },
				delete = { text = "-" },
				topdelete = { text = "‾" },
				changedelete = { text = "~" },
				untracked = { text = "┆" },
			},
		},
		cond = vim.g.vscode == nil,
	},
	{
		"f-person/git-blame.nvim",
		-- load the plugin at startup
		event = "VeryLazy",
		-- Because of the keys part, you will be lazy loading this plugin.
		-- The plugin will only load once one of the keys is used.
		-- If you want to load the plugin at startup, add something like event = "VeryLazy",
		-- or lazy = false. One of both options will work.
		config = function(_, opts)
			require("gitblame").setup(opts)
		end,
		opts = {
			enabled = true,
			message_template = "        @<author>: <summary> • <date> • <<sha>>", -- template for the blame message, check the Message template section for more options
			date_format = "%Y-%m-%d %H:%M:%S", -- template for the date, check Date format section for more options
			virtual_text_column = 60, -- virtual text start column, check Start virtual text at column section for more options
		},
		cond = true,
	},
}
