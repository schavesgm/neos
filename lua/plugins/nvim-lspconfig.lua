local M = {
    "neovim/nvim-lspconfig",
    lazy = true,
    config = function()
        require("lsp")
    end,
    opts = {
        inlay_hints = { enabled = true },
    },
}

return M
