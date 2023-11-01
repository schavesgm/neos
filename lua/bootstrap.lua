-- Module used to bootstrap the configuration of neos
local M = {}

-- Minimum neovim version supported by the configuration
local MINIMUM_NVIM_VERSION = "0.9"

---Assert the NeoVim configuration is greater than a pre-defined value
local function _assert_miminum_nvim_version()
    local nvim_version = string.format("nvim-%s", MINIMUM_NVIM_VERSION)
    if vim.fn.has(nvim_version) ~= 1 then
        local error_message = string.format(
            "Please upgrade your Neovim base installation. Requires v%s+",
            MINIMUM_NVIM_VERSION
        )
        vim.notify(error_message, vim.log.levels.WARN)
        vim.wait(5000, function()
            return false
        end)
        vim.cmd("cquit")
    end
end

---Bootstrap lazy-nvim plugin manager: https://github.com/folke/lazy.nvim
local function _bootstrap_lazy_nvim()
    local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
    if not vim.loop.fs_stat(lazypath) then
        vim.notify("🥾 Bootstrapping lazy plugin manager")
        vim.fn.system({
            "git",
            "clone",
            "--filter=blob:none",
            "--single-branch",
            "https://github.com/folke/lazy.nvim.git",
            lazypath,
        })
    end
    vim.opt.runtimepath:prepend(lazypath)
end

---Initialise the configuration.
---@param path_to_config string; path to configuration to be saved as global
function M:init(path_to_config)
    _assert_miminum_nvim_version()
    _bootstrap_lazy_nvim()

    -- Set global configuration table with some functionality
    _G.neos = {
        path_to_config = path_to_config,
        options = require("core.options"),
    }

    _G.neos.options:init(require("defaults.options"))
end

---Reload the neovim configuration
function M:reload()
    M:init(_G.neos.path_to_config)
end

return M
