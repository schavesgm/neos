local plugin = _G.neos.base.safely_load("nvim-web-devicons", vim.log.levels.WARN)
if not plugin then
    return
end

require("lsp.installer")
require("lsp.handlers").setup()
