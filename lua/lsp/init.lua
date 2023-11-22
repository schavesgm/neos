local nvim_devicons = _G.neos.base.safely_load("nvim-web-devicons", vim.log.levels.WARN)
if not nvim_devicons then
    return
end

require("lsp.installer")
require("lsp.handlers").setup()
