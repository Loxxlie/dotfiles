return {
    "epwalsh/obsidian.nvim",
    version = "*", -- recommended, use latest release instead of latest commit
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-tree.lua",
    },
    opts = {
        workspaces = {
            {
                name = "personal",
                path = "~/LoxxNotes",
            },
        },
    },
    config = function()
        local api = require("nvim-tree.api")

        local move_to_vault = function()
            api.tree.close()
            api.tree.open({ path = vim.env.HOME .. "/LoxxNotes" })
        end

        vim.keymap.set('n', '<leader>ocd', move_to_vault, { desc = 'change directory to vault' })
    end,
}
