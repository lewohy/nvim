return {
    config = {
        'lukas-reineke/virt-column.nvim',
    },
    init = function()
        require('virt-column').setup({
            char = '▕',
            virtcolumn = '80,120',
        })
    end
}
