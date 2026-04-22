return {
	{
		"folke/flash.nvim",
		enabled = false,
		event = "VeryLazy",
	},
	{
		"kylechui/nvim-surround",
		version = "^4.0.0", -- Use for stability; omit to use `main` branch for the latest features
		event = "VeryLazy",
		keys = function()
			local surround = require("nvim-surround")

			return {
				{
					"ys",
					function()
						surround.normal_surround({ line_mode = false })
					end,
					mode = "n",
				},
				{
					"S",
					function()
						local curpos = require("nvim-surround.buffer").get_curpos()
						surround.visual_surround({
							line_mode = false,
							curpos = { curpos[1], curpos[2] },
							curswant = vim.fn.winsaveview().curswant,
						})
					end,
					mode = "v",
				},
				{
					"ds",
					function()
						surround.delete_surround()
					end,
					mode = "v",
				},
				{
					"cs",
					function()
						surround.change_surround({ line_mode = false })
					end,
					mode = "v",
				},
			}
		end,
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
		event = "VeryLazy",
		cond = true,
	},
}
