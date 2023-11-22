-- Table containing some server configurations
local M = {}

-- Add all the servers
local servers = { "jsonls", "lua_ls", "pylsp" }

for _, name in ipairs(servers) do
    M[name] = require(string.format("lsp.servers.%s", name))
end

return M
