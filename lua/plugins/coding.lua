return {
	{
		"folke/flash.nvim",
		enabled = false,
	},
	{
		"kylechui/nvim-surround",
		version = "^3.0.0", -- Use for stability; omit to use `main` branch for the latest features
		event = "VeryLazy",
		opts = {
			keymaps = {
				insert = "<C-g>s",
				insert_line = "<C-g>S",
				normal = "ys",
				normal_cur = "yss",
				normal_line = "yS",
				normal_cur_line = "ySS",
				visual = "S",
				visual_line = "gS",
				delete = "ds",
				change = "cs",
				change_line = "cS",
			},
		},
		cond = true,
	},
	{
		"nat-418/boole.nvim",
		config = {
			mappings = {
				increment = "<C-a>",
				decrement = "<C-x>",
			},
		},
		cond = true,
	},
}
