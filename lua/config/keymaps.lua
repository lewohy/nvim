local functions = require("functions")

-- 파일 타입 설정 단축키
vim.keymap.set({ "n", "i" }, "<C-k><C-m>", function()
	functions.open_telescope_filetypes()
end, {
	desc = "telescope: filetypes",
})

--
vim.keymap.set("n", "<A-f><A-e>", function() end, {
	desc = "Focus: Editor",
})

vim.keymap.set("n", "<A-f><A-i>", function()
	functions.open_todo_list()
end, {
	desc = "Focus: todo",
})

vim.keymap.set("n", "<leader>v", function()
	functions.show_hover()
end, {
	desc = "hover",
})

vim.keymap.set({ "n", "i" }, "<A-e>", function()
	functions.open_telescope_recent()
end, {
	desc = "Open telescope buffers",
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

vim.keymap.set("i", ",", ",<C-g>u")
vim.keymap.set("i", ".", ".<C-g>u")
vim.keymap.set("i", ";", ";<C-g>u")
vim.keymap.set("i", "<SPACE>", "<SPACE><C-g>u")
vim.keymap.set("i", "<CR>", "<CR><C-g>u")

-- vim.keymap.set("n", "<leader><leader>t", function()
-- 	vim.notify("CWD: " .. vim.fn.getcwd())
-- 	vim.notify("File: " .. vim.fn.expand("%:p"))
-- 	vim.notify("Filetype: " .. vim.bo.filetype)
-- end, {
-- 	desc = "Toggle Quickfix",
-- })

-- LazyVim이 특정 filetype에 spell을 활성화하는데 이후에 끄기위한 토글
vim.keymap.set("n", "<leader>st", function()
	vim.wo.spell = not vim.wo.spell
end, {
	desc = "Toggle spell",
})
