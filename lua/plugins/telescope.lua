local M = {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "nvim-lua/popup.nvim" },
    cmd = { "Telescope" },
}

function M.init()
    if not vim.fn.executable("rgrep") then
        vim.notify("ripgrep is not installed, please run the commmand:", vim.log.levels.WARN)
        local os_name = vim.loop.os_uname().sysname
        if os_name == "Linux" then
            vim.notify("sudo apt install ripgrep", vim.log.levels.WARN)
        else
            vim.notify("brew install ripgrep", vim.log.levels.WARN)
        end
    end

    local opts = { noremap = true, silent = true }
    vim.keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>", opts)
    vim.keymap.set("n", "<leader>fg", "<cmd>Telescope live_grep<cr>", opts)
    vim.keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<cr>", opts)
    vim.keymap.set("n", "<leader>fq", "<cmd>Telescope quickfix<cr>", opts)
    vim.keymap.set("n", "<leader>fr", "<cmd>Telescope resume<cr>", opts)
end

function M.config()
    local telescope = _G.neos.base.safely_load("telescope", vim.log.levels.WARN)
    if not telescope then
        return
    end

    -- Grab some modules
    local actions = require("telescope.actions")

    -- Setup telescope plugin
    telescope.setup({
        defaults = {
            vimgrep_arguments = {
                "rg",
                "-L",
                "--color=never",
                "--no-heading",
                "--with-filename",
                "--line-number",
                "--column",
                "--smart-case",
            },
            prompt_prefix = " ",
            selection_caret = " ",
            entry_prefix = "  ",
            initial_mode = "insert",
            selection_strategy = "reset",
            sorting_strategy = "ascending",
            layout_strategy = "horizontal",
            layout_config = {
                horizontal = {
                    prompt_position = "top",
                    preview_width = 0.55,
                    results_width = 0.8,
                },
                vertical = {
                    mirror = false,
                },
                width = 0.87,
                height = 0.80,
                preview_cutoff = 120,
            },
            mappings = {
                i = {
                    ["<C-n>"] = actions.cycle_history_next,
                    ["<C-p>"] = actions.cycle_history_prev,
                    ["<C-j>"] = actions.move_selection_next,
                    ["<C-k>"] = actions.move_selection_previous,
                    ["<C-c>"] = actions.close,
                    ["<CR>"] = actions.select_default,
                    ["<C-x>"] = actions.select_horizontal,
                    ["<C-v>"] = actions.select_vertical,
                    ["<C-t>"] = actions.select_tab,
                    ["<C-u>"] = actions.preview_scrolling_up,
                    ["<C-d>"] = actions.preview_scrolling_down,
                    ["<PageUp>"] = actions.results_scrolling_up,
                    ["<PageDown>"] = actions.results_scrolling_down,
                    ["<Tab>"] = actions.toggle_selection,
                    ["<C-s>"] = actions.send_selected_to_qflist + actions.open_qflist,
                    ["<C-a>"] = actions.send_to_qflist + actions.open_qflist,
                    ["<C-l>"] = actions.complete_tag,
                    ["<C-w>"] = actions.which_key, -- keys from pressing <C-/>
                },
                n = {
                    ["<esc>"] = actions.close,
                    ["<CR>"] = actions.select_default,
                    ["<C-x>"] = actions.select_horizontal,
                    ["<C-v>"] = actions.select_vertical,
                    ["<C-t>"] = actions.select_tab,
                    ["<Tab>"] = actions.toggle_selection + actions.move_selection_next,
                    ["<C-a>"] = actions.send_to_qflist + actions.open_qflist,
                    ["<C-s>"] = actions.send_selected_to_qflist + actions.open_qflist,
                    ["j"] = actions.move_selection_next,
                    ["k"] = actions.move_selection_previous,
                    ["H"] = actions.move_to_top,
                    ["M"] = actions.move_to_middle,
                    ["L"] = actions.move_to_bottom,
                    ["<Down>"] = actions.move_selection_next,
                    ["<Up>"] = actions.move_selection_previous,
                    ["gg"] = actions.move_to_top,
                    ["G"] = actions.move_to_bottom,
                    ["<C-u>"] = actions.preview_scrolling_up,
                    ["<C-d>"] = actions.preview_scrolling_down,
                    ["<PageUp>"] = actions.results_scrolling_up,
                    ["<PageDown>"] = actions.results_scrolling_down,
                    ["?"] = actions.which_key,
                },
            },
        },
        file_sorter = require("telescope.sorters").get_fuzzy_file,
        file_ignore_patterns = { "node_modules" },
        generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
        path_display = { "truncate" },
        winblend = 0,
        border = {},
        borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
        color_devicons = true,
        set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
        file_previewer = require("telescope.previewers").vim_buffer_cat.new,
        grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
        qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
        buffer_previewer_maker = require("telescope.previewers").buffer_previewer_maker,
        pickers = {
            find_files = {
                hidden = true,
            }
        },
        extensions = {
            file_browser = {
                theme = "ivy",
            },
        },
    })
end

return M
