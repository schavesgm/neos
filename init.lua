-- Add the current configuration path to runtimepath
local path = debug.getinfo(1, "S").source:sub(2)
local path_to_config = path:match("(.*[/\\])"):sub(1, -2)

if not vim.tbl_contains(vim.opt.rtp:get(), path_to_config) then
    vim.opt.rtp:append(path_to_config)
end

-- Load the default configuration table
local default_table = require("defaults")

-- Bootstrap configuration
require("bootstrap"):init(path_to_config, default_table, "default")
