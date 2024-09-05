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
            "latex",
        },
        sync_install = true,
        auto_install = true,

        -- Treesitter highlighting module
        highlight = {
            enable = true,
            additional_vim_regex_highlighting = { "markdown" },
            use_languagetree = true,
        },

        -- Treesitter incremental selection module
        incremental_selection = {
            enable = true,
            keymaps = {
                init_selection = "<C-space>",
                node_incremental = "<C-space>",
                scope_incremental = false,
                node_decremental = "<bs>",
            },
        },

        -- Treesitter indentation module
        indent = {
            enable = true,
        },

        -- Autopairing module
        autopairs = {
            enable = true,
        },

        -- Textobjects module
        textobjects = {
            select = {
                enable = true,
                lookahead = true,
                keymaps = {
                    -- You can use the capture groups defined in textobjects.scm
                    ["a="] = {
                        query = "@assignment.outer",
                        desc = "Select outer part of an assignment",
                    },
                    ["i="] = {
                        query = "@assignment.inner",
                        desc = "Select inner part of an assignment",
                    },
                    ["l="] = {
                        query = "@assignment.lhs",
                        desc = "Select left hand side of an assignment",
                    },
                    ["r="] = {
                        query = "@assignment.rhs",
                        desc = "Select right hand side of an assignment",
                    },

                    ["aa"] = {
                        query = "@parameter.outer",
                        desc = "Select outer part of a parameter/argument",
                    },
                    ["ia"] = {
                        query = "@parameter.inner",
                        desc = "Select inner part of a parameter/argument",
                    },

                    ["ai"] = {
                        query = "@conditional.outer",
                        desc = "Select outer part of a conditional",
                    },
                    ["ii"] = {
                        query = "@conditional.inner",
                        desc = "Select inner part of a conditional",
                    },

                    ["al"] = { query = "@loop.outer", desc = "Select outer part of a loop" },
                    ["il"] = { query = "@loop.inner", desc = "Select inner part of a loop" },

                    ["af"] = {
                        query = "@call.outer",
                        desc = "Select outer part of a function call",
                    },
                    ["if"] = {
                        query = "@call.inner",
                        desc = "Select inner part of a function call",
                    },

                    ["am"] = {
                        query = "@function.outer",
                        desc = "Select outer part of a method/function definition",
                    },
                    ["im"] = {
                        query = "@function.inner",
                        desc = "Select inner part of a method/function definition",
                    },

                    ["ac"] = { query = "@class.outer", desc = "Select outer part of a class" },
                    ["ic"] = { query = "@class.inner", desc = "Select inner part of a class" },
                },
            },
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
