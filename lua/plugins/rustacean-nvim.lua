local M = {
    "mrcjkb/rustaceanvim",
    version = "^4",
    ft = { "rust" },
}

function M.config()
    vim.g.rustaceanvim = {
        tools = {
            hover_actions = {
                auto_focus = false,
            },
        },
        server = {
            on_attach = function(client, bufnr)
                require("lsp.utils").lsp_highlight_document(client)
                require("lsp.utils").lsp_keymaps(bufnr)
            end,
            settings = {
                ["rust-analyzer"] = {
                    check = {
                        command = "clippy",
                    },
                },
            },
        },
    }
end

return M
