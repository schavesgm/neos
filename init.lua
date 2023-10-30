-- Add the current configuration path to runtimepath
local path = debug.getinfo(1, "S").source:sub(2)
local config_path = path:match("(.*[/\\])"):sub(1, -2)

if not vim.tbl_contains(vim.opt.rtp:get(), config_path) then
	vim.opt.rtp:append(config_path)
end

-- Bootstrap configuration
require("bootstrap"):init(config_path)
