---Module containing some functionality to simplify configuring NeoVim
local M = {}

---Safely load a module. If not present, log into the console and return nil
---@param module_name string #Name of the module to load
---@param level number #Logging level in case of failure
---@return table|nil #Table containing the module or nil if it was not loade
function M.safely_load(module_name, level)
    local is_present, module = pcall(require, module_name)
    if not is_present then
        vim.notify_once(string.format("%s cannot be loaded", module_name), level)
        return
    end
    return module
end

---Set a highlight value. This function is just a wrapper over nvim_set_hl
---@param namespace number #Namespace to set the highlight. A value of 0 means all
---@param name string #Name of the highlight group to set
---@param bg_colour string|nil #Background colour of the highlight group
---@param fg_colour string|nil #Foreground colour of the highlight group
---@param opts_table table|nil #Other options to set in the table
function M.set_hl(namespace, name, bg_colour, fg_colour, opts_table)
    local values_table = { bg = bg_colour, fg = fg_colour }
    values_table = vim.tbl_extend("force", values_table, opts_table or {})
    vim.api.nvim_set_hl(namespace, name, values_table)
end

---Append an element to an array-like table in the last position
---@param table table Table to extend
---@param entry table Entry to append to the table
---@return table Table with appended entries
function M.tbl_append(table, entry)
    local new_table = {}
    for _, old_entry in ipairs(table) do
        new_table[#new_table + 1] = old_entry
    end
    new_table[#new_table + 1] = entry
    return new_table
end

return M
