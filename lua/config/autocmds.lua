vim.api.nvim_create_autocmd({ "FocusGained", "InsertLeave", "CmdlineEnter" }, {
	callback = function()
		local sysname = vim.uv.os_uname().sysname

		if sysname == "Linux" then
			vim.fn.system("fcitx5-remote -c")
		elseif sysname == "Windows_NT" then
            vim.fn.system("kren-select.exe en")
        end
	end,
	group = vim.api.nvim_create_augroup("im_select", { clear = true }),
})

if vim.g.vscode ~= nil then
end
