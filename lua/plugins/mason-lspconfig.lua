local M = {
    "williamboman/mason-lspconfig.nvim",
}

function M.config()
    local mason_lspconfig = _G.neos.base.safely_load("mason-lspconfig", vim.log.levels.WARN)
    if not mason_lspconfig then return end

    mason_lspconfig.setup({
        ensure_installed = {"lua_ls", "pylsp"}
    })
end

return M
