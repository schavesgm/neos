local snippets = require("luasnip")
local format = require("luasnip.extras.fmt").fmt

local function generate_code_link_snippet(code_encoding)
    return snippets.s(
        code_encoding,
        format(string.format(":%s:`{}`", code_encoding), { snippets.i(1, "reference") })
    )
end

local entries = {
    snippets.s(
        "sphcode", format("``{}``", { snippets.i(1, "default") })
    ),
    snippets.s(
        "link", format("`{} <{}>`_", {
            snippets.i(1, "link_text"),
            snippets.i(2, "link_url"),
        })
    ),
}

local all_code_encodings = { "mod", "func", "data", "const", "class", "meth", "attr", "exc", "obj" }
for _, code_encoding in ipairs(all_code_encodings) do
    entries[#entries + 1] = generate_code_link_snippet(code_encoding)
end

return entries
