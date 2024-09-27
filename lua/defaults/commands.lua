-- Collection of default commands

---Return the range in which the command is applied from the command arguments
---@param command_args table Table containing the command arguments
---@return table|nil
local function _get_range(command_args)
    local range = nil
    if command_args.count ~= -1 then
        local end_line =
            vim.api.nvim_buf_get_lines(0, command_args.line2 - 1, command_args.line2, true)[1]
        range = {
            start = { command_args.line1, 0 },
            ["end"] = { command_args.line2, end_line:len() },
        }
    end
    return range
end

return {
    ["Format"] = {
        callback = function(command_args)
            --- Obtain the range to allow passing arguments to the function
            local range = _get_range(command_args)

            -- Fetch the conform plugin in case it is present in the configuration
            local is_available, conform = pcall(require, "conform")
            print(is_available)

            -- Run conform formatting if possible, otherwise LSP formatting
            if is_available then
                conform.format({ async = true, lsp_format = "fallback", range = range })
            else
                vim.lsp.buf.format({ async = true, range = range })
            end
        end,
        range = true,
    },
}
