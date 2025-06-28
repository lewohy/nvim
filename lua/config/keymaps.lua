local functions = require("functions")

-- File Type
vim.keymap.set({ "n", "i" }, "<C-k><C-m>", function()
	functions.open_telescope_filetypes()
end, {
	desc = "telescope: filetypes",
})

-- Focus
vim.keymap.set({ "n", "i" }, "<A-f><A-f>", function()
	functions.reveal_file_in_neotree()
end, {
	desc = "neotree: reveal file",
})

vim.keymap.set("n", "<A-f><A-e>", function() end, {
	desc = "Focus: Editor",
})

vim.keymap.set("n", "<A-f><A-g>", function()
	functions.open_neogit()
end, {
	desc = "Focus: Neogit",
})

vim.keymap.set("n", "<A-f><A-i>", function()
	functions.open_todo_list()
end, {
	desc = "Focus: todo",
})

-- Git
vim.keymap.set({ "n", "i" }, "<A-g><A-g>", function()
	functions.open_neogit_graph()
end, {
	desc = "Git: Graph",
})

vim.keymap.set("n", "<A-v>", function()
	functions.show_hover()
end, {
	desc = "hover",
})

vim.keymap.set({ "n", "i" }, "<A-e>", function()
	functions.open_telescope_recent()
end, {
	desc = "Open telescope buffers",
})

vim.keymap.del({ "n", "v" }, "<leader>cf")
vim.keymap.set({ "n", "i" }, "<A-F>", function()
	LazyVim.format({ force = true })
end, { desc = "Format" })

vim.keymap.set("n", "<leader><leader>e", function()
	functions.hop_after_cursor()
end, {
	desc = "Hop: After cursor",
})

vim.keymap.set("n", "<leader><leader>b", function()
	functions.hop_before_cursor()
end, {
	desc = "Hop: Before cursor",
})

vim.keymap.set("n", "<leader><leader>t", function()
	require("gitgraph").draw({}, { all = true, max_count = 5000 })
end, {
	desc = "Test",
})

vim.keymap.set("v", "J", "j", {
	silent = true,
})

if vim.g.vscode == nil then
	vim.keymap.set("i", "<C-SPACE>", "<C-X><C-O>", {
		desc = "Test",
	})
end

vim.keymap.set("c", "<S-Enter>", function()
	functions.noice_redirect_cmd()
end, { desc = "Redirect Cmdline" })

vim.keymap.set("n", "<ESC>", function()
	vim.fn.system("fcitx5-remote -c")
end, {
	desc = "fcitx5-remote -c",
})

vim.keymap.set("n", "<leader>tt", function()
	vim.notify("CWD: " .. vim.fn.getcwd())
	vim.notify("File: " .. vim.fn.expand("%:p"))
	vim.notify("Filetype: " .. vim.bo.filetype)
	print(vim.inspect(require("lazy.core.config")))
end, {
	desc = "Toggle Quickfix",
})
