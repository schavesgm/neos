local snippets = require("luasnip")
local format = require("luasnip.extras.fmt").fmt

---Function to generate a mathematical expression in Obsidian markdown files
---@param name string; Name of the snippet.
---@param environment string; Name of the LaTeX environment to instantiate.
---@return table; Generated snippet table.
local function generate_obsidian_equation_snippet(name, environment)
    return snippets.s(
        name,
        format(
            string.format(
                "$$\n\\begin{{%s}}\n\t{}\n\\end{{%s}}\n$$", environment, environment
            ),
            { snippets.i(1, "your_maths") }
        )
    )
end

local entries = {
    generate_obsidian_equation_snippet("begeq", "equation"),
    generate_obsidian_equation_snippet("begalign", "align"),
}

return entries
