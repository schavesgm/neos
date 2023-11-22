local M = {
    "lukas-reineke/indent-blankline.nvim",
}

function M.config()
    local is_present, plugin = pcall(require, "ibl")
    if not is_present then
        return
    end

    plugin.setup()

    local set_hl = _G.neos.base.set_hl
    set_hl(0, "IblIndent", nil, _G.neos.palette.bg_4, { bold = false })
    set_hl(0, "IblScope", nil, _G.neos.palette.purple_1, { bold = false })
end

return M
