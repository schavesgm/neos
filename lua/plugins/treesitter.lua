local M = {
    "nvim-treesitter/nvim-treesitter",
    event = "BufEnter",
    cmd = { "TSInstall", "TSBufEnable", "TSBufDisable", "TSEnable", "TSDisable", "TSModuleInfo" },
    build = ":TSUpdate",
}

function M.config()
    local treesitter = _G.neos.base.safely_load("nvim-treesitter.configs", vim.log.levels.WARN)
    if treesitter == nil then
        return
    end

    treesitter.setup({
        ensure_installed = {
            "c",
            "lua",
            "vim",
            "vimdoc",
            "python",
            "markdown",
            "markdown_inline",
            "regex",
        },
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

        -- Autopairing module
        autopairs = {
            enable = true,
        },
    })

    local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
    parser_config.nu = {
        install_info = {
            url = "https://github.com/nushell/tree-sitter-nu",
            files = { "src/parser.c" },
            branch = "main",
        },
        filetype = "nu",
    }
end

return M
