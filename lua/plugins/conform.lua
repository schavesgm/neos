local M = {
    "stevearc/conform.nvim",
    opts = {},
}

function M.config()
    local conform = _G.neos.base.safely_load("conform", vim.log.levels.WARN)
    if not conform then
        return
    end

    conform.setup({
        formatters_by_ft = {
            lua = {
                "stylua",
            },
            python = {
                "ruff_format",
            },
        },
    })
end

return M
