local vscode = require("vscode")

vim.keymap.set("n", "<leader>tt", function()
	vscode.action("workbench.action.tasks.test")
end, {
	desc = "Run test task",
})

vim.keymap.set("n", "<leader>tb", function()
	vscode.action("workbench.action.tasks.build")
end, {
	desc = "Run build task",
})
