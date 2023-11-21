local snippets = require("luasnip")
local format = require("luasnip.extras.fmt").fmt

local function generate_new_commit_message(scope)
    return snippets.s(
        scope,
        format(
            string.format("%s({}): {}", scope),
            {
                snippets.i(1, "scope"),
                snippets.i(2, "message"),
            }
        )
    )
end

local entries = {}
for _, scope in ipairs({ "rebase", "fixup" }) do
    entries[#entries + 1] = generate_new_commit_message(scope)
end

return entries
