local M = {
    "stevearc/oil.nvim",
    opts = {},
    -- Optional dependencies
    dependencies = { "nvim-tree/nvim-web-devicons" },
}

function M.config()
    local oil = _G.neos.base.safely_load("oil", vim.log.levels.WARN)
    if not oil then
        return
    end

    oil.setup()
end

return M
