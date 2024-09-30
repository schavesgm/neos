local tbl_append = require("core.base").tbl_append

---Table containing all opened timed_callbacks
---@type table<string, any>
local TIMED_CALLBACKS = {}

---Wrapper around callback function that generates a timed call
---@param callback function #Callback function to wrap
---@param start number #Time (in miliseconds) to pass after callback starts being called
---@param every number #Time (in miliseconds) to wait between sequential calls of the function
---@param identifier string #String identifier for the wrapped callback
---@return function #Callback function wrapped on a timed loop
local function start_timed_callback(callback, start, every, identifier)
    return function()
        local buffer_name = vim.api.nvim_buf_get_name(0)
        local timers_key = string.format("%s_%s", identifier, buffer_name)
        local lambda = vim.schedule_wrap(function()
            callback(buffer_name)
        end)
        TIMED_CALLBACKS[timers_key] = vim.loop.new_timer()
        TIMED_CALLBACKS[timers_key]:start(start, every, lambda)
    end
end

---Function to stop a timer on a callback function
---@param identifier string #String identifier for the wrapped callback
local function end_timed_callback(identifier)
    local timers_key = string.format("%s_%s", identifier, vim.api.nvim_buf_get_name(0))
    -- If the timer does exist, then close it
    if TIMED_CALLBACKS[timers_key] ~= nil then
        TIMED_CALLBACKS[timers_key]:close()
        TIMED_CALLBACKS[timers_key] = nil
    end
end

---Transform minutes to miliseconds
---@param minutes number #Minutes to convert into miliseconds
---@return number #Number in miliseconds
local function minutes_to_miliseconds(minutes)
    return minutes * 60 * 1000
end

---Create a timed callback autocommand for a given identifier on "BufEnter" and "BufLeave"
---@param callback function Function to use in the callback operation
---@param identifier string Identifier for the callback operation
---@param minutes number Minutes to elapse between callbacks
---@param options table Optional table adding options to the events
local function _add_timed_autocommand(callback, identifier, minutes, options)
    local miliseconds = minutes_to_miliseconds(minutes)
    local options_enter = vim.tbl_extend(
        "error",
        options,
        { callback = start_timed_callback(callback, miliseconds, miliseconds, identifier) }
    )
    local options_exit = vim.tbl_extend("error", options, {
        callback = function()
            end_timed_callback(identifier)
        end,
    })
    return {
        { event = "BufEnter", opts = options_enter },
        { event = "BufLeave", opts = options_exit },
    }
end

---Try linting the code using "nvim-lint"
local function _lint()
    local is_present, lint = pcall(require, "lint")
    if is_present then
        lint.try_lint()
    end
end

-- Table containing all autogroups/autocommands definitions
return {
    base = {
        {
            event = "BufRead",
            opts = {
                pattern = "*",
                command = [[call setpos(".", getpos("'\""))]],
            },
        },
        { event = "VimLeave", opts = { pattern = "*", command = "wshada!" } },
    },
    terminal = {
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
    lint = tbl_append(
        _add_timed_autocommand(_lint, "lint", 0.1, {}),
        { event = "BufWritePost", opts = { callback = _lint } }
    ),
    markup = tbl_append(
        _add_timed_autocommand(
            function(buffer_name)
                vim.cmd(":w " .. buffer_name)
            end,
            "markup_autosave",
            0.1,
            {
                pattern = { "*.tex", "*.txt", "*.md", "*.norg", "*.rst" },
            }
        ),
        {
            event = { "BufEnter", "WinEnter" },
            opts = {
                pattern = { "*.tex", "*.txt", "*.md", "*.norg", "*.rst" },
                command = [[setlocal textwidth=100 colorcolumn=+1]],
            },
        }
    ),
    rust = {
        {
            event = "FileType",
            opts = {
                pattern = { "rust" },
                command = "set makeprg=cargo\\ run",
            },
        },
    },
    norg = {
        {
            event = "FileType",
            opts = {
                pattern = { "norg" },
                command = "setlocal tabstop=2 shiftwidth=2 softtabstop=2",
            },
        },
        {
            event = "FileType",
            opts = {
                pattern = { "norg" },
                callback = function()
                    if vim.fn.exists(":IBLDisable") > 0 then
                        vim.cmd("IBLDisable")
                    end
                end,
            },
        },
    },
}
