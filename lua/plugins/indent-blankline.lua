local M = {
    "lukas-reineke/indent-blankline.nvim",
}

function M.config()
    local is_present, plugin = pcall(require, "ibl")
    if not is_present then
        return
    end

    plugin.setup()
end

return M
