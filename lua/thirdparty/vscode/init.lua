local vscode = require("vscode")
vim.notify = vscode.notify

require("thirdparty.vscode.autocmds")
require("thirdparty.vscode.keymaps")

vim.notify("VSCode mode enabled")

