-- Collection of default commands
return {
    ["Format"] = {
        callback = function()
            vim.lsp.buf.format({ async = true })
        end,
        force = true,
    },
}
