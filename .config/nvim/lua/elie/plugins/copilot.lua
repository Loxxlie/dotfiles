return {
    "zbirenbaum/copilot.lua",
    lazy = false,
    event = "InsertEnter",
    config = function()
        require("copilot").setup({
            suggestion = { enabled = false },
            panel = {
                enabled = true,
                auto_refresh = true,
                keymap = {
                    jump_prev = "[[",
                    jump_next = "]]",
                    accept = "<Tab>",
                    refresh = "gr",
                    open = "<M-CR>"
                },
                layout = {
                    position = "bottom", -- | top | left | right
                    ratio = 0.4
                },
            },
        })
    end,
}
