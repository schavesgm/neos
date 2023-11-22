local M = {
    "L3MON4D3/LuaSnip",
    dependencies = { "nvim-cmp", "friendly-snippets" },
}

function M.config()
    local luasnip = _G.neos.base.safely_load("luasnip", vim.log.levels.WARN)
    if not luasnip then
        return
    end

    luasnip.config.set_config({
        history = true,
        updateevents = "TextChanged,TextChangedI",
    })

    require("luasnip.loaders.from_vscode").lazy_load()
    require("luasnip.loaders.from_lua").lazy_load({ paths = "./snippets" })

    vim.api.nvim_create_autocmd("InsertLeave", {
        callback = function()
            if
                luasnip.session.current_nodes[vim.api.nvim_get_current_buf()]
                and not require("luasnip").session.jump_active
            then
                luasnip.unlink_current()
            end
        end,
    })
end

return M
