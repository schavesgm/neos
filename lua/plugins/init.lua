---Module containing all plugin definitions
return {
    -- Treesitter plugins
    {
        "nvim-treesitter/playground",
        dependencies = "nvim-treesitter/nvim-treesitter",
        cmd = "TSPlaygroundToggle",
        config = function()
            require("nvim-treesitter.configs").setup({})
        end,
    },
    {
        "p00f/nvim-ts-rainbow",
        dependencies = "nvim-treesitter",
    },

    -- LSP plugins
    {
        "weilbith/nvim-code-action-menu",
        cmd = "CodeActionMenu",
    },
    {
        "kosayoda/nvim-lightbulb",
        config = function()
            require("nvim-lightbulb").setup({
                autocmd = { enabled = true },
                sign = {
                    enabled = true,
                    text = "🔥",
                }
            })
        end,
    },

    -- Autocompletion and snippets
    {
        "rafamadriz/friendly-snippets",
        event = "InsertEnter",
    },
    {
        "saadparwaiz1/cmp_luasnip",
        dependencies = "LuaSnip",
    },
    {
        "hrsh7th/cmp-nvim-lua",
        dependencies = "LuaSnip",
    },
    {
        "hrsh7th/cmp-nvim-lsp",
        dependencies = "LuaSnip",
    },
    {
        "hrsh7th/cmp-buffer",
        dependencies = "LuaSnip",
    },
    {
        "hrsh7th/cmp-path",
        dependencies = "LuaSnip",
    },
    {
        "kdheepak/cmp-latex-symbols",
        dependencies = "LuaSnip",
    },
}
