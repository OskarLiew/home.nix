-- Functionality to work navigate in the Red Robin network

local M = {}

---Open a path if it exists
---@param path string
local function edit_if_exists(path)
    local file = io.open(path, "r")

    if file == nil then
        vim.print("File " .. path .. " does not exist")
        return
    end

    file:close()

    path = vim.fn.fnameescape(path)
    vim.api.nvim_command("edit " .. path)

    vim.print("Editing " .. path)
end

M.jump_to_node = function()
    local node = vim.treesitter.get_node()
    local bufnr = vim.api.nvim_get_current_buf()
    local node_text = vim.treesitter.get_node_text(node, bufnr)

    local type = node:type()
    if type:find("integer") ~= nil then
        local path = "network/node_" .. node_text .. ".yaml"
        edit_if_exists(path)
    else
        vim.print("Not a valid NodeID: " .. node_text)
    end
end

vim.keymap.set("n", "<leader>q", M.jump_to_node)

return M
