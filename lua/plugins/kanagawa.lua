local M = {
    "rebelot/kanagawa.nvim",
}

function M.init()
    -- Set some custom highlight groups if kanagawa is the colourscheme of the system
    if _G.neos.colourscheme == "kanagawa" then
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

        -- Set a global colourscheme table to be used on other plugins
        _G.neos.palette = {
            bg_0 = palette.sumiInk0,
            bg_1 = palette.sumiInk1,
            bg_2 = palette.sumiInk2,
            bg_3 = palette.sumiInk3,
            bg_4 = palette.sumiInk4,

            fg_0 = palette.fujiWhite,
            fg_1 = palette.oldWhite,

            gray_0 = palette.katanaGray,
            gray_1 = palette.fujiGray,

            red_0 = palette.autumnRed,
            red_1 = palette.samuraiRed,
            blue_0 = palette.dragonBlue,
            blue_1 = palette.crystalBlue,
            green_0 = palette.autumnGreen,
            green_1 = palette.springGreen,
            yellow_0 = palette.autumnYellow,
            yellow_1 = palette.roninYellow,
            orange_0 = palette.surimiOrange,
            orange_1 = palette.carpYellow,
            purple_0 = palette.oniViolet,
            purple_1 = palette.springViolet1,
        }
    end
end

-- Configure the plugin
function M.config()
    local kanagawa = _G.neos.base.safely_load("kanagawa", vim.log.levels.WARN)
    if not kanagawa then
        return
    end

    -- Setup kanagawa module
    kanagawa.setup({ theme = "wave" })
end

return M
