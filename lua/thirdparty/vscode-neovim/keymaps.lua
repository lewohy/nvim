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

vim.keymap.set("n", "<leader>fg", function()
	vscode.action("workbench.scm.focus")
end, {
	desc = "git-graph.view",
})

vim.keymap.set("n", "<leader>gg", function()
	vscode.action("git-graph.view")
end, {
	desc = "git-graph.view",
})

vim.keymap.set("n", "<leader>gc", function()
	vscode.action("git.checkout")
end, {
	desc = "git.checkout",
})

vim.keymap.set("n", "<leader>gb", function()
	vscode.action("git.branch")
end, {
	desc = "git.branch",
})

vim.keymap.set("n", "<leader>gm", function()
	vscode.action("git.merge")
end, {
	desc = "git.merge",
})

vim.keymap.set("n", "<leader>gr", function()
	vscode.action("git.rebase")
end, {
	desc = "git.rebase",
})

vim.keymap.set("n", "<leader>gs", function()
	vscode.action("git.stashIncludeUntracked")
end, {
	desc = "git.stashIncludeUntracked",
})

vim.keymap.set("n", "<leader>gy", function()
	vscode.action("git.sync")
end, {
	desc = "git.sync",
})

vim.keymap.set("n", "<leader>gv", function()
	vscode.action("git.stashView")
end, {
	desc = "git.stashView",
})
