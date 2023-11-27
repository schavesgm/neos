local M = {
    "mrcjkb/rustaceanvim",
    version = "^3",
    ft = { "rust" },
    dependencies = {
        {
            "lvimuser/lsp-inlayhints.nvim",
            opts = {},
        },
    },
}

function M.config()
    vim.g.rustaceanvim = {
        inlay_hints = {
            highlight = "NonText",
        },
        tools = {
            hover_actions = {
                auto_focus = false,
            },
        },
        server = {
            on_attach = function(client, bufnr)
                require("lsp-inlayhints").on_attach(client, bufnr)

                -- Set some required functionalities on attach
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
