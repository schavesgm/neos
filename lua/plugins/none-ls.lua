local M = {
    "nvimtools/none-ls.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "nvim-lua/popup.nvim" },
}

function M.config()
    local none_ls = _G.neos.base.safely_load("null-ls", vim.log.levels.WARN)
    if not none_ls then
        return
    end

    none_ls.setup({
        sources = {
            -- Filetype: Lua
            none_ls.builtins.formatting.stylua,

            -- Filetype: Python
            none_ls.builtins.diagnostics.mypy.with({
                extra_args = {
                    "--show-column-numbers",
                    "--disallow-untyped-defs",
                    "--check-untyped-defs",
                    "--ignore-missing-imports",
                },
            }),

            -- Filetype: Markdown, YAML, TOML...
            none_ls.builtins.formatting.prettier,
        },
    })
end

return M
