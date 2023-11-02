local M = {}

---Define a set of autogroups with their respective autocommands
---@param autocommands_table table #Table containing augroups and their respective autocommands.
function M.set_augroup_autocmds(autocommands_table)
    for augroup, autocmds in pairs(autocommands_table) do
        local group = vim.api.nvim_create_augroup(augroup, { clear = true })
        for _, autocmd in ipairs(autocmds) do
            vim.api.nvim_create_autocmd(
                autocmd.event,
                vim.tbl_extend("keep", autocmd.opts, {
                    group = group,
                })
            )
        end
    end
end

---Delete a collection of augroups by their names
---@param augroups table #Table containing the names of the augroups to delete
function M.delete_augroups(augroups)
    for _, augroup in ipairs(augroups) do
        vim.api.nvim_del_augroup_by_name(augroup)
    end
end

---Set the default autocommands on the system
---@param options table #Table containing all the autogroups and autocommands of the system
function M:init(options)
    M.set_augroup_autocmds(options)
end

return M
