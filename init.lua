require("config.lazy")
require("config.autocmds")
require("config.keymaps")
require("config.options")
require("config.test")

if vim.g.vscode then
	require("thirdparty.vscode-neovim.init")
end

if vim.g.neovide then
	require("thirdparty.neovide")
end

-- vim.api.nvim_set_hl(0, 'NormalFloat', {
--     bg = nil
-- })

function Dump(o)
	if type(o) == "table" then
		local s = "{ "
		for k, v in pairs(o) do
			if type(k) ~= "number" then
				k = '"' .. k .. '"'
			end
			s = s .. "[" .. k .. "] = " .. Dump(v) .. ","
		end
		return s .. "} "
	else
		return tostring(o)
	end
end

vim.filetype.add({
	pattern = {
		[".*/%.vscode/.+.json"] = "jsonc",
		["devcontainer.json"] = "jsonc",
	},
})
