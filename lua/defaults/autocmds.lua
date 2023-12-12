---Table containing all opened timed_callbacks
---@type table<string, any>
local all_opened_timed_callbacks = {}

---@type number
local THREE_MINUTES = 3

---Wrapper around callback function that generates a timed call
---@param callback function #Callback function to wrap
---@param start number #Time (in miliseconds) to pass after callback starts being called
---@param every number #Time (in miliseconds) to wait between sequential calls of the function
---@param identifier string #String identifier for the wrapped callback
---@return function #Callback function wrapped on a timed loop
local function start_timed_callback(callback, start, every, identifier)
    local bufnr = vim.api.nvim_buf_get_name(0)
    local timers_key = string.format("%s_%s", identifier, bufnr)
    return function()
        local lambda = vim.schedule_wrap(function()
            callback(bufnr)
        end)
        all_opened_timed_callbacks[timers_key] = vim.loop.new_timer()
        all_opened_timed_callbacks[timers_key]:start(start, every, lambda)
    end
end

---Function to stop a timer on a callback function
---@param identifier string #String identifier for the wrapped callback
local function end_timed_callback(identifier)
    local timers_key = string.format("%s_%s", identifier, vim.api.nvim_buf_get_name(0))
    -- If the timer does exist, then close it
    if all_opened_timed_callbacks[timers_key] ~= nil then
        all_opened_timed_callbacks[timers_key]:close()
        all_opened_timed_callbacks[timers_key] = nil
    end
end

---Transform minutes to miliseconds
---@param minutes number #Minutes to convert into miliseconds
---@return number #Number in miliseconds
local function minutes_to_miliseconds(minutes)
    return minutes * 60 * 1000
end

-- Table containing all autogroups/autocommands definitions
return {
    BaseDefaults = {
        {
            event = "BufRead",
            opts = {
                pattern = "*",
                command = [[call setpos(".", getpos("'\""))]],
            },
        },
        { event = "VimLeave", opts = { pattern = "*", command = "wshada!" } },
    },
    TerminalDefaults = {
        {
            event = "TermOpen",
            opts = {
                pattern = "*",
                command = [[tnoremap <buffer> <Esc> <c-\><c-n>]],
            },
        },
        { event = "TermOpen", opts = { pattern = "*", command = "startinsert" } },
        {
            event = "TermOpen",
            opts = {
                pattern = "*",
                command = [[setlocal nonumber norelativenumber]],
            },
        },
        {
            event = "TermOpen",
            opts = { pattern = "*", command = [[setlocal filetype=term]] },
        },
        {
            event = "TermOpen",
            opts = { pattern = "*", command = [[setlocal spell!]] },
        },
    },
    MarkupDefaults = {
        {
            event = { "BufEnter", "WinEnter" },
            opts = {
                pattern = { "*.tex", "*.txt", "*.md", "*.norg", "*.rst" },
                command = [[setlocal textwidth=100 colorcolumn=+1]],
            },
        },
        {
            event = "BufEnter",
            opts = {
                pattern = { "*.tex", "*.md", "*.norg", "*.rst" },
                callback = start_timed_callback(
                    function(bufnr)
                        vim.cmd(":w " .. bufnr)
                    end,
                    minutes_to_miliseconds(THREE_MINUTES),
                    minutes_to_miliseconds(THREE_MINUTES),
                    "markup_autosave"
                ),
            },
        },
        {
            event = "BufLeave",
            opts = {
                pattern = { "*.tex", "*.md", "*.norg", "*.rst" },
                callback = function()
                    end_timed_callback("markup_autsave")
                end,
            },
        },
    },
    WebDevDefaults = {
        {
            event = "FileType",
            opts = {
                pattern = { "javascript", "css" },
                command = "setlocal tabstop=2 shiftwidth=2 softtabstop=2",
            },
        },
    },
    NorgDefaults = {
        {
            event = "FileType",
            opts = {
                pattern = { "norg" },
                command = "setlocal tabstop=2 shiftwidth=2 softtabstop=2",
            },
        },
    },
}
