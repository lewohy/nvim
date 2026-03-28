return {
	{
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000,
        opts = {
            auto_integrations = true
        }
		-- opts = function(_, opts)
		-- 	local module = require("catppuccin.groups.integrations.bufferline")
		-- 	if module then
		-- 		module.get = module.get_theme
		-- 	end
		-- 	return opts
		-- end,
		-- opts = {
		-- 	flavour = "mocha", -- latte, frappe, macchiato, mocha
		-- 	integrations = {
		-- 		aerial = true,
		-- 		alpha = true,
		-- 		cmp = true,
		-- 		dashboard = true,
		-- 		flash = true,
		-- 		fzf = true,
		-- 		grug_far = true,
		-- 		gitsigns = true,
		-- 		headlines = true,
		-- 		illuminate = true,
		-- 		indent_blankline = { enabled = true },
		-- 		leap = true,
		-- 		lsp_trouble = true,
		-- 		mason = true,
		-- 		markdown = true,
		-- 		mini = true,
		-- 		native_lsp = {
		-- 			enabled = true,
		-- 			underlines = {
		-- 				errors = { "undercurl" },
		-- 				hints = { "undercurl" },
		-- 				warnings = { "undercurl" },
		-- 				information = { "undercurl" },
		-- 			},
		-- 		},
		-- 		navic = { enabled = true, custom_bg = "lualine" },
		-- 		neotest = true,
		-- 		neotree = true,
		-- 		noice = true,
		-- 		notify = true,
		-- 		semantic_tokens = true,
		-- 		snacks = true,
		-- 		telescope = true,
		-- 		treesitter = true,
		-- 		treesitter_context = true,
		-- 		which_key = true,
		-- 	},
		-- 	background = { -- :h background
		-- 		light = "mocha",
		-- 		dark = "mocha",
		-- 	},
		-- },
		-- config = function(_, opts)
		-- 	local catppuccin = require("catppuccin")
		-- 	catppuccin.setup(opts)

		-- 	vim.cmd.colorscheme("catppuccin-mocha")

		-- 	local palettes = require("catppuccin.palettes").get_palette("mocha")

		-- 	vim.api.nvim_set_hl(0, "LineNrAbove", {
		-- 		fg = palettes.overlay2,
		-- 		bold = true,
		-- 	})
		-- 	vim.api.nvim_set_hl(0, "LineNr", {
		-- 		fg = palettes.overlay1,
		-- 		bold = true,
		-- 	})
		-- 	vim.api.nvim_set_hl(0, "LineNrBelow", {
		-- 		fg = "#FB508F",
		-- 		bold = true,
		-- 	})
		-- end,
	},
	-- {
	-- 	"LazyVim/LazyVim",
	-- 	opts = {
	-- 		colorscheme = "catppuccin",
	-- 	},
	-- },
}
