local M = {
    "windwp/nvim-autopairs",
    dependencies = "nvim-cmp",
}

function M.config()
    local autopairs = _G.neos.base.safely_load("nvim-autopairs", vim.log.levels.WARN)
    if not autopairs then
        return
    end
    local cmp = _G.neos.base.safely_load("cmp", vim.log.levels.WARN)
    if not cmp then
        return
    end

    autopairs.setup({
        -- Check using treesitter
        check_ts = true,
        ts_config = {
            lua = { "string", "source" },
        },
        disable_filetype = { "TelescopePrompt", "spectre_panel" },
        fast_wrap = {
            map = "<C-e>",
            chars = { "{", "[", "(", '"', "'" },
            pattern = string.gsub([[ [%'%"%)%>%]%)%}%,] ]], "%s+", ""),
            offset = 0, -- Offset from pattern match
            end_key = "$",
            keys = "qwertyuiopzxcvbnmasdfghjkl",
            check_comma = true,
            highlight = "PmenuSel",
            highlight_grey = "LineNr",
        },
    })

    -- Hook onto cmp to close parenthesis on autocompletion
    local cmp_autopairs = require("nvim-autopairs.completion.cmp")
    cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done({ map_char = { tex = "" } }))
end

return M
