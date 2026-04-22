local vscode = require("vscode")
vim.notify = vscode.notify

require("thirdparty.vscode-neovim.autocmds")
require("thirdparty.vscode-neovim.keymaps")

vim.notify("VSCode mode enabled")

-- TODO: https://github.com/vscode-neovim/vscode-neovim/issues/2507
vim.o.cmdheight=1000
