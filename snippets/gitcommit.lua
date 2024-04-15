local snippets = require("luasnip")
local format = require("luasnip.extras.fmt").fmt

local function generate_new_commit_message(scope)
    return snippets.s(
        scope,
        format(string.format("%s({}): {}", scope), {
            snippets.i(1, "scope"),
            snippets.i(2, "message"),
        })
    )
end

local entries = {
    snippets.s("code", format("`{}`", { snippets.i(1, "your_code") })),
}

for _, scope in ipairs({ "rebase", "fixup", "WIP" }) do
    entries[#entries + 1] = generate_new_commit_message(scope)
end

return entries
