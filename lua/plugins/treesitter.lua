local M = {
    "nvim-treesitter/nvim-treesitter",
    event = "BufEnter",
    cmd = { "TSInstall", "TSBufEnable", "TSBufDisable", "TSEnable", "TSDisable", "TSModuleInfo" },
    build = ":TSUpdate",
}

function M.config()
    local treesitter = _G.neos.base.safely_load("nvim-treesitter", vim.log.levels.WARN)
    if treesitter == nil then
        return
    end

    treesitter.setup({
        ensure_installed = { "lua", "vim", "python", "markdown", "markdown_inline", "regex" },
        sync_install = true,
        auto_install = true,

        -- Treesitter highlighting module
        highlight = {
            enable = true,
            additional_vim_regex_highlighting = { "markdown" },
            use_languagetree = true,
        },

        -- Treesitter indentation module
        indent = {
            enable = true,
        },
    })
end

return M
