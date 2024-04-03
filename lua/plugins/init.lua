---Module containing all plugin definitions
return {
    -- LuaRocks
    {
        "vhyrro/luarocks.nvim",
        priority = 1000,
        config = true,
    },

    -- Treesitter plugins
    {
        "nvim-treesitter/nvim-treesitter-textobjects",
        dependencies = "nvim-treesitter/nvim-treesitter",
    },
    {
        "nvim-treesitter/playground",
        dependencies = "nvim-treesitter/nvim-treesitter",
        cmd = "TSPlaygroundToggle",
        config = function()
            require("nvim-treesitter.configs").setup({})
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
