local M = {
    "rebelot/kanagawa.nvim",
}

function M.init()
    -- Set some custom highlight groups if kanagawa is the colourscheme of the system
    if _G.neos.colourscheme ~= "kanagawa" then
        return
    end

    vim.cmd("colorscheme kanagawa")

    -- Set some custom highlights on this colourscheme
    local colors = require("kanagawa.colors").setup()
    local palette = colors.palette
    local set_hl = _G.neos.base.set_hl

    set_hl(0, "WinSeparator", nil, palette.crystalBlue, { bold = true })
    set_hl(0, "FloatBorder", nil, palette.oniViolet, { bold = true })
    set_hl(0, "NormalFloat", nil, palette.fujiWhite, { bold = false })
    set_hl(0, "DiagnosticError", nil, palette.springViolet1, { bold = false })
    set_hl(0, "DiagnosticWarn", nil, palette.springViolet1, { bold = false })
    set_hl(0, "DiagnosticInfo", nil, palette.springViolet1, { bold = false })
    set_hl(0, "DiagnosticHint", nil, palette.springViolet1, { bold = false })
    set_hl(0, "LspInlayHint", nil, palette.springViolet1, { bold = false })
    set_hl(0, "RainbowDelimiterRed", nil, palette.samuraiRed, { bold = false })
    set_hl(0, "RainbowDelimiterYellow", nil, palette.roninYellow, { bold = false })
    set_hl(0, "RainbowDelimiterBlue", nil, palette.dragonBlue, { bold = false })
    set_hl(0, "RainbowDelimiterOrange", nil, palette.surimiOrange, { bold = false })
    set_hl(0, "RainbowDelimiterGreen", nil, palette.autumnGreen, { bold = false })
    set_hl(0, "RainbowDelimiterViolet", nil, palette.springViolet1, { bold = false })
    set_hl(0, "RainbowDelimiterCyan", nil, palette.crystalBlue, { bold = false })
    set_hl(0, "IblIndent", nil, palette.sumiInk0, { bold = false })
    set_hl(0, "IblScope", nil, palette.springViolet1, { bold = false })
end

-- Configure the plugin
function M.config()
    local kanagawa = _G.neos.base.safely_load("kanagawa", vim.log.levels.WARN)
    if not kanagawa then
        return
    end

    --- Only setup the kanagawa colour-scheme if its selected
    if _G.neos.colourscheme ~= "kanagawa" then
        return
    end

    -- Setup kanagawa module
    kanagawa.setup({ theme = "wave" })
end

return M
