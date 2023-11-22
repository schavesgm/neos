local M = {
    "nvim-neorg/neorg",
    build = ":Neorg sync-parsers",
    dependencies = { "nvim-lua/plenary.nvim" },
}

function M.config()
    local neorg = _G.neos.base.safely_load("neorg", vim.log.levels.WARN)
    if not neorg then
        return
    end

    neorg.setup({
        load = {
            ["core.defaults"] = {},
            ["core.concealer"] = {},
            ["core.dirman"] = {
                config = {
                    workspaces = {
                        second_brain = "~/SecondBrain",
                    },
                },
            },
            ["core.export"] = {},
            ["core.export.markdown"] = {
                config = {
                    extensions = {
                        "todo-items-basic",
                        "todo-items-pending",
                        "todo-items-extended",
                        "definition-lists",
                        "mathematics",
                        "metadata",
                    },
                },
            },
            ["core.esupports.indent"] = {
                config = {
                    dedent_excess = false,
                    format_on_enter = false,
                    format_on_escape = true,
                },
            },
        },
    })
end

return M
