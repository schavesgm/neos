local M = {
    "rebelot/kanagawa.nvim",
}

-- Configure the plugin
function M.config()
    local kanagawa = _G.neos.base.safely_load("kanagawa", vim.log.levels.WARN)
    if not kanagawa then
        return
    end

    -- Setup kanagawa module
    kanagawa.setup({})

    -- Set some custom highlight groups if kanagawa is the colourscheme of the system
    if _G.neos.colourscheme == "kanagawa" then
        vim.cmd("colorscheme kanagawa")

        -- Set some custom highlights on this colourscheme
        local colors = require("kanagawa.colors").setup()
        local set_hl = _G.neos.base.set_hl

        set_hl(0, "WinSeparator", nil, colors.palette.crystalBlue, { bold = true })
        set_hl(0, "FloatBorder", nil, colors.palette.oniViolet, { bold = true })
        set_hl(0, "NormalFloat", nil, colors.palette.fujiWhite, { bold = false })
        set_hl(0, "DiagnosticError", nil, colors.palette.springViolet1, { bold = false })
        set_hl(0, "DiagnosticWarn", nil, colors.palette.springViolet1, { bold = false })
        set_hl(0, "DiagnosticInfo", nil, colors.palette.springViolet1, { bold = false })
        set_hl(0, "DiagnosticHint", nil, colors.palette.springViolet1, { bold = false })
    end
end

return M
