-- Table containing the default options of the configuration
return {
    -- Options to set. Equivalent to vim's :set option=value
    set = {
        -- Basic options
        backup = false,
        swapfile = false,
        undofile = true,
        writebackup = false,
        guifont = "monospace:h17",
        clipboard = "unnamedplus",
        fileencoding = "utf-8",
        mouse = "a",
        showmode = false,
        termguicolors = true,
        updatetime = 300,
        timeoutlen = 1000,
        history = 50,
        conceallevel = 0,
        cmdheight = 1,
        pumheight = 10,
        signcolumn = "yes",
        inccommand = "split",
        infercase = true,
        showtabline = 2,
        laststatus = 3,
        colorcolumn = "100",

        -- Navigation options
        wrap = false,
        scrolloff = 8,
        sidescrolloff = 8,
        splitbelow = true,
        splitright = true,
        cursorline = true,
        numberwidth = 2,
        number = true,
        relativenumber = true,

        -- Buffer manipulation options
        hidden = true,
        autoread = true,

        -- Invisible characters options
        showbreak = "↪\\",
        listchars = "tab:→\\ ,eol:↲,nbsp:␣,trail:•,extends:⟩,precedes:⟨",

        -- Search options
        hlsearch = true,
        ignorecase = true,
        smartcase = true,

        -- Command line menu options
        wildmenu = true,
        wildmode = "full",

        -- Spelling options
        spell = true,
        spelllang = "en",

        -- Indent options
        smartindent = true,
        autoindent = true,
        expandtab = true,
        tabstop = 4,
        shiftwidth = 4,
        softtabstop = 4,

        -- Special options
        completeopt = { "menuone", "noselect" },
        -- shortmess = "TOIftxoclinF",
        -- whichwrap = "<,>,[,],b,h,l,s",
    },
    -- Options to append. Equivalent to vim's :set option+=value
    append = {
        shortmess = { "c", "I" },
        whichwrap = { "<", ">", "[", "]", "h", "l" },
        clipboard = { "unnamedplus" },
    },
    -- Options to prepend. Equivalent to vim's :set option^=value
    prepend = {},
    -- Options to remove. Equivalent to vim's :set option-=value
    remove = {},
}
