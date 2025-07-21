return {
    "zbirenbaum/copilot-cmp",
    lazy = false,
    after = { "copilot.lua" },
    config = function()
        require("copilot_cmp").setup({ fix_pairs = true })
    end,
}
