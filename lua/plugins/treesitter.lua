return {
    'nvim-treesitter/nvim-treesitter',
    lazy = false,
    branch = 'main',
    build = ':TSUpdate',
    config = function()
        local config = require('nvim-treesitter')
        config.setup({
            highlight = { enable = true },
            indent = { enable = true },
            fold = { enable = true }
        })
        config.install({
            'rust', 'javascript', 'lua', 'python', 'c_sharp', 'cpp'
        })
    end
}
