vim.keymap.set({ "n", "i" }, "<A-e>", function()
	functions.open_telescope_recent()
end, {
	desc = "Open telescope buffers",
})
