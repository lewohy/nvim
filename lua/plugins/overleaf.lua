return {
	{
		"richwomanbtc/overleaf.nvim",
		config = {
			pdf_viewer = "echo",
		},
		build = "cd node && npm install",
		-- cond = vim.g.vscode ~= nil,
	},
}
