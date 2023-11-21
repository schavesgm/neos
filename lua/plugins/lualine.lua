local M = {
  'nvim-lualine/lualine.nvim',
  requires = { 'nvim-tree/nvim-web-devicons', opt = true }
}

function M.config()
    local lualine = _G.neos.base.safely_load("lualine", vim.log.levels.WARN)
    if not lualine then
        return
    end
    lualine.setup({
        options = {
            component_separators = { left = '｜', right = '｜'},
            section_separators = { left = '', right = ''},
        },
    })
end

return M
