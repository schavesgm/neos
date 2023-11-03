local M = {
    "kyazdani42/nvim-tree.lua",
    cmd = { "NvimTreeToggle", "NvimTreeFocus" },
}

function M.init()
    vim.keymap.set("n", "<leader>e", "<cmd>NvimTreeToggle<Cr>")
end

local function on_attach(bufnr)
    local nt_api = _G.neos.base.safely_load("nvim-tree.api", vim.log.levels.WARN)
    if not nt_api then
        return
    end

    local function opts(desc)
        return {
            desc = "nvim-tree: " .. desc,
            buffer = bufnr,
            noremap = true,
            silent = true,
            nowait = true,
        }
    end

    vim.keymap.set("n", "<C-]>", nt_api.tree.change_root_to_node, opts("CD"))
    vim.keymap.set("n", "<C-[>", nt_api.tree.change_root_to_parent, opts("Up"))
    vim.keymap.set("n", "<C-e>", nt_api.node.open.replace_tree_buffer, opts("Open: In Place"))
    vim.keymap.set("n", "<C-k>", nt_api.node.show_info_popup, opts("Info"))
    vim.keymap.set("n", "<C-r>", nt_api.fs.rename_sub, opts("Rename: Omit Filename"))
    vim.keymap.set("n", "<C-t>", nt_api.node.open.tab, opts("Open: New Tab"))
    vim.keymap.set("n", "<C-v>", nt_api.node.open.vertical, opts("Open: Vertical Split"))
    vim.keymap.set("n", "<C-x>", nt_api.node.open.horizontal, opts("Open: Horizontal Split"))
    vim.keymap.set("n", "<BS>", nt_api.node.navigate.parent_close, opts("Close Directory"))
    vim.keymap.set("n", "<CR>", nt_api.node.open.edit, opts("Open"))
    vim.keymap.set("n", "<Tab>", nt_api.node.open.preview, opts("Open Preview"))
    vim.keymap.set("n", ">", nt_api.node.navigate.sibling.next, opts("Next Sibling"))
    vim.keymap.set("n", "<", nt_api.node.navigate.sibling.prev, opts("Previous Sibling"))
    vim.keymap.set("n", ".", nt_api.node.run.cmd, opts("Run Command"))
    vim.keymap.set("n", "-", nt_api.tree.change_root_to_parent, opts("Up"))
    vim.keymap.set("n", "a", nt_api.fs.create, opts("Create"))
    vim.keymap.set("n", "bmv", nt_api.marks.bulk.move, opts("Move Bookmarked"))
    vim.keymap.set("n", "B", nt_api.tree.toggle_no_buffer_filter, opts("Toggle No Buffer"))
    vim.keymap.set("n", "c", nt_api.fs.copy.node, opts("Copy"))
    vim.keymap.set("n", "C", nt_api.tree.toggle_git_clean_filter, opts("Toggle Git Clean"))
    vim.keymap.set("n", "[c", nt_api.node.navigate.git.prev, opts("Prev Git"))
    vim.keymap.set("n", "]c", nt_api.node.navigate.git.next, opts("Next Git"))
    vim.keymap.set("n", "d", nt_api.fs.remove, opts("Delete"))
    vim.keymap.set("n", "D", nt_api.fs.trash, opts("Trash"))
    vim.keymap.set("n", "E", nt_api.tree.expand_all, opts("Expand All"))
    vim.keymap.set("n", "e", nt_api.fs.rename_basename, opts("Rename: Basename"))
    vim.keymap.set("n", "]e", nt_api.node.navigate.diagnostics.next, opts("Next Diagnostic"))
    vim.keymap.set("n", "[e", nt_api.node.navigate.diagnostics.prev, opts("Prev Diagnostic"))
    vim.keymap.set("n", "F", nt_api.live_filter.clear, opts("Clean Filter"))
    vim.keymap.set("n", "f", nt_api.live_filter.start, opts("Filter"))
    vim.keymap.set("n", "g?", nt_api.tree.toggle_help, opts("Help"))
    vim.keymap.set("n", "gy", nt_api.fs.copy.absolute_path, opts("Copy Absolute Path"))
    vim.keymap.set("n", "H", nt_api.tree.toggle_hidden_filter, opts("Toggle Dotfiles"))
    vim.keymap.set("n", "I", nt_api.tree.toggle_gitignore_filter, opts("Toggle Git Ignore"))
    vim.keymap.set("n", "J", nt_api.node.navigate.sibling.last, opts("Last Sibling"))
    vim.keymap.set("n", "K", nt_api.node.navigate.sibling.first, opts("First Sibling"))
    vim.keymap.set("n", "m", nt_api.marks.toggle, opts("Toggle Bookmark"))
    vim.keymap.set("n", "o", nt_api.node.open.edit, opts("Open"))
    vim.keymap.set("n", "O", nt_api.node.open.no_window_picker, opts("Open: No Window Picker"))
    vim.keymap.set("n", "p", nt_api.fs.paste, opts("Paste"))
    vim.keymap.set("n", "P", nt_api.node.navigate.parent, opts("Parent Directory"))
    vim.keymap.set("n", "q", nt_api.tree.close, opts("Close"))
    vim.keymap.set("n", "r", nt_api.fs.rename, opts("Rename"))
    vim.keymap.set("n", "R", nt_api.tree.reload, opts("Refresh"))
    vim.keymap.set("n", "s", nt_api.node.run.system, opts("Run System"))
    vim.keymap.set("n", "S", nt_api.tree.search_node, opts("Search"))
    vim.keymap.set("n", "U", nt_api.tree.toggle_custom_filter, opts("Toggle Hidden"))
    vim.keymap.set("n", "W", nt_api.tree.collapse_all, opts("Collapse"))
    vim.keymap.set("n", "x", nt_api.fs.cut, opts("Cut"))
    vim.keymap.set("n", "y", nt_api.fs.copy.filename, opts("Copy Name"))
    vim.keymap.set("n", "Y", nt_api.fs.copy.relative_path, opts("Copy Relative Path"))
    vim.keymap.set("n", "<2-LeftMouse>", nt_api.node.open.edit, opts("Open"))
    vim.keymap.set("n", "<2-RightMouse>", nt_api.tree.change_root_to_node, opts("CD"))
end

function M.config()
    local nvim_tree = _G.neos.base.safely_load("nvim-tree", vim.log.levels.WARN)
    if not nvim_tree then
        return
    end

    nvim_tree.setup({
        filters = {
            dotfiles = false,
            exclude = { vim.fn.stdpath("config") .. "/lua/custom" },
        },
        disable_netrw = true,
        hijack_netrw = true,
        hijack_cursor = true,
        hijack_unnamed_buffer_when_opening = false,
        update_cwd = true,
        update_focused_file = {
            enable = true,
            update_cwd = false,
        },
        on_attach = on_attach,
        view = {
            adaptive_size = false,
            side = "left",
            width = 25,
        },
        git = {
            enable = true,
            ignore = false,
        },
        filesystem_watchers = {
            enable = true,
        },
        actions = {
            open_file = {
                resize_window = false,
            },
        },
        renderer = {
            -- Append a trailing slash to folder names.
            add_trailing = true,

            -- Compact folders that only contain a single folder into one node in the file tree.
            group_empty = true,

            -- Display node whose name length is wider than the width in floating window.
            full_name = true,

            -- Enable file highlight for git attributes using `NvimTreeGit*` highlight groups.
            highlight_git = true,

            -- Highlight icons and/or names for |bufloaded()| files using the
            highlight_opened_files = "all",

            -- Highlight icons and/or names for modified files using the
            highlight_modified = "all",

            -- Format to show root folder
            root_folder_label = false,

            indent_markers = {
                enable = false,
            },

            icons = {
                show = {
                    file = true,
                    folder = true,
                    folder_arrow = true,
                    git = true,
                },
                glyphs = {
                    default = "",
                    symlink = "",
                    folder = {
                        default = "",
                        empty = "",
                        empty_open = "",
                        open = "",
                        symlink = "",
                        symlink_open = "",
                        arrow_open = "",
                        arrow_closed = "",
                    },
                    git = {
                        unstaged = "",
                        staged = "",
                        unmerged = "",
                        renamed = "",
                        untracked = "",
                        deleted = "",
                        ignored = "",
                    },
                },
            },
        },
    })
end

return M
