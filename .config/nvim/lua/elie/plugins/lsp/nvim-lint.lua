return {
    "mfussenegger/nvim-lint",
    config = function()
        -- import nvim-lint
        local lint = require("lint")
        lint.linters_by_ft = {
            go = { "golangcilint", "revive" },
            proto = { "buf_lint" },
        }

        -- run fmt before buffer write
        vim.api.nvim_create_autocmd({ "BufWritePre" }, {
            callback = function()
                vim.lsp.buf.format({
                    timeout_ms = 7000
                })
            end
        })

        -- run organizeImports on every golang file write
        vim.api.nvim_create_autocmd({ "BufWritePre" }, {
            pattern = { "*.go" },
            callback = function()
                local params = vim.lsp.util.make_range_params(nil, vim.lsp.util._get_offset_encoding())
                params.context = { only = { "source.organizeImports" } }

                local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, 3000)
                for _, res in pairs(result or {}) do
                    for _, r in pairs(res.result or {}) do
                        if r.edit then
                            vim.lsp.util.apply_workspace_edit(r.edit, vim.lsp.util._get_offset_encoding())
                        else
                            vim.lsp.buf.execute_command(r.command)
                        end
                    end
                end
            end,
        })

        -- run lint after buffer write
        vim.api.nvim_create_autocmd({ "BufWritePost" }, {
            callback = function()
                require("lint").try_lint()
            end,
        })
    end
}
