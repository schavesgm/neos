local M = {
    "HiPhish/rainbow-delimiters.nvim",
    dependencies = "nvim-treesitter"
}

function M.config()
    local rainbow_delimiters = _G.neos.base.safely_load("rainbow-delimiters", vim.log.levels.WARN)
    if not rainbow_delimiters then
        return
    end
end

return M
