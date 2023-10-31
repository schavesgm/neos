-- Module containing functionality to set options
local M = {}

---Set a table containing all the options of the system
---@param options_table table # Table containing key-value neovim-options
function M.set_options(options_table)
    for key, value in pairs(options_table) do
        vim.opt[key] = value
    end

    -- Some other default settings
    vim.opt.shortmess:append("c")
    vim.opt.shortmess:append("I")
    vim.opt.whichwrap:append("<,>,[,],h,l")
end

-- Load default options without user interface
function M.load_headless_defaults()
    vim.opt.shortmess = ""
    vim.opt.more = false
    vim.opt.cmdheight = 9999
    vim.opt.columns = 9999
    vim.opt.swapfile = false
end

function M:init(options_table)
    local is_headless = #vim.api.nvim_list_uis() == 0
    if is_headless then
        M.load_headless_defaults()
    else
        M.set_options(options_table)
    end
end

return M
