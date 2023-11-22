local M = {
    "williamboman/mason.nvim",
    cmd = { "Mason", "MasonInstall", "MasonLog", "MasonUninstall", "MasonUninstallAll" },
}

-- Configure the plugin
function M.config()
    local mason = _G.neos.base.safely_load("mason", vim.log.levels.WARN)
    if not mason then
        return
    end

    mason.setup({
        PATH = "prepend",
        ui = {
            icons = {
                package_pending = " ",
                package_installed = " ",
                package_uninstalled = " ﮊ",
            },
            keymaps = {
                toggle_server_expand = "<CR>",
                install_server = "i",
                update_server = "u",
                check_server_version = "c",
                update_all_servers = "U",
                check_outdated_servers = "C",
                uninstall_server = "X",
                cancel_installation = "<C-c>",
            },
        },
        max_concurrent_installers = 10,
    })
end

return M
