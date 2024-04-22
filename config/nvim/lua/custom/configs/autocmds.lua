local autocmd = vim.api.nvim_create_autocmd

function copy_table(t)
    local t2 = {}
    for k, v in pairs(t) do
        if type(v) == "table" then
            t2[k] = table.copy(v)
        else
            t2[k] = v
        end
    end
    return t2
end

-- Filetype mappings
local filetype_mappings = copy_table(require("custom.mappings").filetype_mappings)
filetype_mappings.plugin = nil -- To not iterate over this

autocmd("BufEnter", {
    callback = function()
        for mode, mappings in pairs(filetype_mappings) do
            for mapping, mapping_info in pairs(mappings) do
                if vim.fn.maparg(mapping, mode, 0, 0) ~= "" then
                    vim.keymap.del(mode, mapping)
                end

                for _, filetype in ipairs(mapping_info.filetypes) do
                    if filetype == vim.bo.filetype then
                        local opts = {}
                        opts.desc = mapping_info[2] or {}
                        vim.keymap.set(mode, mapping, mapping_info[1], opts)
                    end
                end
            end
        end
    end,
})
