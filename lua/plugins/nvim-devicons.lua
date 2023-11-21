local M = {
    "nvim-tree/nvim-web-devicons"
}

function M.config()
    local devicons = _G.neos.base.safely_load("nvim-web-devicons", vim.log.levels.WARN)
    if not devicons then
        return
    end
    devicons.setup()
end

return M
