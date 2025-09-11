local vscode = require("vscode")

vim.api.nvim_create_autocmd({ "BufWriteCmd" }, {
	pattern = "*",
	callback = function()
		vscode.action("workbench.action.files.save")
	end,
})
