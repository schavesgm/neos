local M = {
    "hrsh7th/nvim-cmp",
    dependencies = "friendly-snippets",
}

---Set the border of the autocompletion floating window
---@param hl_name string; highlight name to apply in borders
local function border(hl_name)
    return {
        {"╭", hl_name},
        {"─", hl_name},
        {"╮", hl_name},
        {"│", hl_name},
        {"╯", hl_name},
        {"─", hl_name},
        {"╰", hl_name},
        {"│", hl_name},
    }
end

-- Define some nice icons in the autocompletion
local icons = {
    Text = "",
    Method = "m",
    Function = "",
    Constructor = "",
    Field = "",
    Variable = "",
    Class = "",
    Interface = "",
    Module = "",
    Property = "",
    Unit = "",
    Value = "",
    Enum = "",
    Keyword = "",
    Snippet = "",
    Color = "",
    File = "",
    Reference = "",
    Folder = "",
    EnumMember = "",
    Constant = "",
    Struct = "",
    Event = "",
    Operator = "",
    TypeParameter = "",
}


function M.config()
    local cmp = _G.neos.base.safely_load("cmp", vim.log.levels.WARN)
    if not cmp then return end

    -- Set the correct complete options
    vim.o.completeopt = "menu,menuone,noselect"

    local cmp_window = require("cmp.utils.window")
    cmp_window.info_ = cmp_window.info
    cmp_window.info = function(self)
        local info = self:info_()
        info.scrollable = false
        return info
    end

    cmp.setup({
        window = {
            completion = {
                border = border("CmpBorder"),
                winhighlight = "Normal:CmpPmenu,CursorLine:PmenuSel,Search:None",
            },
            documentation = {
                border = border("CmpDocBorder"),
            },
        },
        snippet = {
            expand = function(args) require("luasnip").lsp_expand(args.body) end,
        },
        formatting = {
            fields = {"kind", "abbr", "menu"},
            format = function(entry, vim_item)
                -- Kind icons
                vim_item.kind = string.format('%s', icons[vim_item.kind])
                vim_item.menu = ({
                    luasnip  = "[Snippet]",
                    buffer   = "[Buffer]",
                    path     = "[Path]",
                    nvim_lua = "[Nvim_lua]",
                    nvim_lsp = "[LSP]",
                })[entry.source.name]
                return vim_item
            end,
        },
        mapping = {
            -- Select previous and next items using Ctrl + {k, j}
            ["<C-k>"] = cmp.mapping.select_prev_item(),
            ["<C-j>"] = cmp.mapping.select_next_item(),

            -- Move laterally in the docs using Ctrl + {b, f}
            ["<C-u>"] = cmp.mapping(cmp.mapping.scroll_docs(-1), {"i", "c"}),
            ["<C-d>"] = cmp.mapping(cmp.mapping.scroll_docs(1), {"i", "c"}),

            -- Show all possible completion options
            ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), {"i", "c"}),

            -- Disable the autocompletion engine
            ["<C-y>"] = cmp.config.disable,

            -- Exit the autocompletion
            ["<C-e>"] = cmp.mapping {i = cmp.mapping.abort(), c = cmp.mapping.close(),},

            -- Accept currently selected item
            ["<CR>"] = cmp.mapping.confirm {select = true},

            -- Use <Tab> to select items in the autocompletion
            ["<Tab>"] = cmp.mapping(
                function(fallback)
                    if cmp.visible() then
                        cmp.select_next_item()
                    elseif require("luasnip").expand_or_jumpable() then
                        vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-expand-or-jump", true, true, true), "")
                    else
                        fallback()
                    end
                end, {"i", "s",}
            ),

            -- Use shift tab to jump to luasnip expandable items
            ["<S-Tab>"] = cmp.mapping(
                function(fallback)
                    if cmp.visible() then
                        cmp.select_prev_item()
                    elseif require("luasnip").jumpable(-1) then
                        vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-jump-prev", true, true, true), "")
                    else
                        fallback()
                    end
                end, {"i", "s",}
            ),
        },
        sources = {
            {name = "luasnip"},
            {name = "nvim_lsp"},
            {name = "buffer"},
            {name = "nvim_lua"},
            {name = "path"},
            {name = "latex_symbols"},
            {name = "git"},
        },
    })
end

return M
