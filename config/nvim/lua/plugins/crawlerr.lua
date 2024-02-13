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

---Move cursor to the pattern in the current buffer
---@param pattern string
local function jump_to_pattern(pattern)
    local bufnr = vim.api.nvim_get_current_buf()
    local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
    for row, line in ipairs(lines) do
        local start_col, _ = string.find(line, pattern)
        if start_col then
            -- Pattern found, move the cursor to the matched position
            vim.api.nvim_win_set_cursor(0, { row, start_col })
            return
        end
    end
    vim.print("Pattern " .. pattern .. " not found")
end

---Jump to the texts of the currently hovered node for the given language
---@param language string
M.jump_to_texts = function(language)
    local node = vim.treesitter.get_node()
    local bufnr = vim.api.nvim_get_current_buf()
    local node_text = vim.treesitter.get_node_text(node, bufnr)

    edit_if_exists("network/texts/" .. language .. ".yaml")

    local type = node:type()
    if type:find("integer") ~= nil then
        local pattern = "[^%w]" .. node_text .. ":"
        jump_to_pattern(pattern)
    else
        node_text = node_text:gsub("[%(%)]", "%%%1") -- Escape parentheses
        local pattern = "[^%w]name: " .. node_text
        jump_to_pattern(pattern)
    end
end

return M
