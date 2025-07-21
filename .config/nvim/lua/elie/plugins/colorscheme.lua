return {
    {
        "catppuccin/nvim",
        name = "catppuccin",
        lazy = false,
        priority = 1000,
        config = function()
            -- load the colorscheme here
            vim.cmd([[colorscheme catppuccin-macchiato]])
        end,
    },
    {
        "bluz71/vim-nightfly-colors",
        name = "nightfly",
        lazy = false,
        priority = 1000,
        config = function()
            -- load the colorscheme here
            vim.cmd([[colorscheme nightfly]])

            -- enable window separators
            vim.g.nightflyWinSeparator = 2

            -- set window separator charaters
            vim.opt.fillchars = {
                horiz = '━',
                horizup = '┻',
                horizdown = '┳',
                vert = '┃',
                vertleft = '┫',
                vertright = '┣',
                verthoriz = '╋',
            }
        end,
    },
}
