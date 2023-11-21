local M = {}

---Set a collection of commands into Neovim
---@param command_table table; Table containing the command names and command options
function M.set_commands(command_table)
    for command_name, command_opts in pairs(command_table) do
        local callback = command_opts.callback
        command_opts.callback = nil
        vim.api.nvim_create_user_command(command_name, callback, command_opts)
    end
end

---Initialise the commands module. This is a wrapper over set_commands.
---@param options table; Table defining the options to set.
function M:init(options)
    M.set_commands(options)
end

return M
