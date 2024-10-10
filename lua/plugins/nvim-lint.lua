local M = {
    "mfussenegger/nvim-lint",
}

function M.config()
    local is_present, _ = _G.neos.base.safely_load("lint", vim.log.levels.WARN)
    if not is_present then
        return
    end

    -- Setup the linters for each file type
    require("lint").linters_by_ft = {
        python = {
            "mypy",
        },
    }

    -- Setup some linter arguments
    require("lint").linters.mypy.args = {
        "--show-column-numbers",
        "--disallow-untyped-defs",
        "--check-untyped-defs",
        "--ignore-missing-imports",
    }
end

return M
