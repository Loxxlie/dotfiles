return {
    {
        "nvim-treesitter/nvim-treesitter",
        event = { "BufReadPre", "BufNewFile" },
        build = ":TSUpdate",
        dependencies = {
            "nvim-treesitter/nvim-treesitter-textobjects",
        },
        config = function()
            -- import nvim-treesitter plugin
            local treesitter = require("nvim-treesitter.configs")

            -- configure treesitter
            treesitter.setup({ -- enable syntax highlighting
                highlight = {
                    enable = true,
                    use_languagetree = true,
                },
                -- enable indentation
                indent = { enable = true },
                -- ensure these language parsers are installed
                ensure_installed = {
                    "json",
                    "yaml",
                    "markdown",
                    "bash",
                    "lua",
                    "vim",
                    "dockerfile",
                    "gitignore",
                    "query",
                    "go",
                },
                incremental_selection = {
                    enable = true,
                    keymaps = {
                        init_selection = "<C-space>",
                        node_incremental = "<C-space>",
                        scope_incremental = false,
                        node_decremental = "<bs>",
                    },
                },
            })
        end,
    },
}
