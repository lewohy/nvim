return {
    config = {
        "declancm/cinnamon.nvim",
        version = "*", -- use latest release
        opts = {
            -- change default options here
        },
    },
    init = function()
        require("cinnamon").setup {
            -- Enable all provided keymaps
            keymaps = {
                basic = true,
                extra = true,
            },
            -- Only scroll the window
            options = { mode = "cursor" },
        }
    end
}
