---Module containing all plugin definitions
return {
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
