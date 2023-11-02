-- Module containing functionality to set options
local M = {}

---Set all options in a table using "set option=value"
---@param set_option_table table #Table of options to set
local function _set_options(set_option_table)
    for key, value in pairs(set_option_table) do
        vim.opt[key] = value
    end
end

---Append to all options in a table using "set option+=value"
---@param append_option_table table #Table of options to set
local function _append_options(append_option_table)
    for key, values_to_append in pairs(append_option_table) do
        for _, value in ipairs(values_to_append) do
            vim.opt[key]:append(value)
        end
    end
end

---Prepend to all options in a table using "set option^=value"
---@param prepend_option_table table #Table of options to set
local function _prepend_options(prepend_option_table)
    for key, values_to_prepend in pairs(prepend_option_table) do
        for _, value in ipairs(values_to_prepend) do
            vim.opt[key]:prepend(value)
        end
    end
end

---Remove to all options in a table using "set option-=value"
---@param remove_option_table table #Table of options to set
local function _remove_options(remove_option_table)
    for key, values_to_remove in pairs(remove_option_table) do
        for _, value in ipairs(values_to_remove) do
            vim.opt[key]:remove(value)
        end
    end
end

local name_to_action = {
    set = _set_options,
    append = _append_options,
    prepend = _prepend_options,
    remove = _remove_options,
}

---Set a table containing all the options of the system
---@param options_table table # Table containing key-value neovim-options
function M.set_options(options_table)
    for _, action_name in ipairs({ "set", "append", "prepend", "remove" }) do
        if options_table[action_name] ~= nil then
            name_to_action[action_name](options_table[action_name])
        end
    end
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
