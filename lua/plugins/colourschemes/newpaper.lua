local M = {
    "yorik1984/newpaper.nvim",
    priority = 1000,
    config = true,
}

-- Configure the plugin
function M.config()
    local newpaper = _G.neos.base.safely_load("newpaper", vim.log.levels.WARN)
    if not newpaper then
        return
    end

    if _G.neos.colourscheme ~= "newpaper" then
        return
    end

    -- Setup kanagawa module
    newpaper.setup({ style = "light" })
end

return M
