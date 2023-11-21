local snippets = require("luasnip")
local format = require("luasnip.extras.fmt").fmt

local entries = {
    snippets.s("inlinemath", format("$|{}|$", { snippets.i(1, "your_maths") })),
}

return entries
