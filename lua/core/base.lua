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

return M
