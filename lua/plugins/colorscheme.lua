return {
	{
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000,
		opts = {
			auto_integrations = true,
		},
		config = function(_, opts)
			require("catppuccin").setup(opts)

			-- setup 이후에 설정되어야함
			vim.cmd.colorscheme("catppuccin-mocha")
		end,
	},
}
