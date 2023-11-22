local safely_load = _G.neos.base.safely_load

local lspconfig = safely_load("lspconfig", vim.log.levels.WARN)
if not lspconfig then
    return
end

local mason_lspconfig = safely_load("mason-lspconfig", vim.log.levels.WARN)
if not mason_lspconfig then
    return
end

---Function to be called when attaching
local function on_attach(client, bufnr)
    -- On attach function to attach some highlighting and keymaps
    if client.name == "tsserver" then
        client.server_capabilities.document_formatting = false
    end

    -- Set some required functionalities on attach
    require("lsp.utils").lsp_highlight_document(client)
    require("lsp.utils").lsp_keymaps(bufnr)
end

-- Get all the server settings
local server_configs = require("lsp.servers")

-- Iterate through all pairs
for _, server in ipairs(mason_lspconfig.get_installed_servers()) do
    -- Basic server configuration
    local config = { on_attach = on_attach }

    -- If a configuration is present, then add it
    if server_configs[server] ~= nil then
        config = vim.tbl_deep_extend("force", config, server_configs[server])
    end

    -- Call the setup method
    lspconfig[server].setup(config)
end
