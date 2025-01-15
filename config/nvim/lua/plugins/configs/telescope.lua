local function get_last_path_component(path)
    -- Check if filePath ends with '/'
    if string.sub(path, -1) == "/" then
        -- Remove trailing '/'
        path = string.sub(path, 1, -2)
    end

    -- Find the last occurrence of '/'
    local last_slash_index, _ = string.find(path, "/[^/]*$")
    -- Extract the last component
    local last_component = string.sub(path, (last_slash_index or 0) + 1)
    if last_component then
        return last_component
    end
end

local function get_file_name(str)
    local index = str:find("%.")
    if index then
        return str:sub(1, index - 1)
    else
        return str
    end
end

local function filename_cmp(current, existing, prompt)
    local current_file_name = get_file_name(current)
    if current_file_name == prompt then
        local existing_file_name = get_file_name(existing)
        if current_file_name ~= existing_file_name then
            return true
        end
    end
end

local function first_match_cmp(current, existing, prompt)
    local start_pos1, _ = current:find(prompt)
    local start_pos2, _ = existing:find(prompt)
    if start_pos1 then
        if start_pos2 then
            if start_pos1 < start_pos2 then -- If same pos, then continue
                return true
            end
        else
            return true
        end
    end
end

local function tiebreak(current_ordinal, existing_ordinal, prompt)
    local current_last = get_last_path_component(current_ordinal)
    local existing_last = get_last_path_component(existing_ordinal)

    -- Perfect file name matches
    if filename_cmp(current_last, existing_last, prompt) then
        return true
    end

    -- Files with prompt early in file component
    if first_match_cmp(current_last, existing_last, prompt) then
        return true
    end

    -- Fallback to alphabetical
    return current_ordinal < existing_ordinal
end

local options = {
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
        prompt_prefix = "   ",
        selection_caret = "  ",
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
        -- Developer configurations: Not meant for general override
        buffer_previewer_maker = require("telescope.previewers").buffer_previewer_maker,
        mappings = {
            n = { ["q"] = require("telescope.actions").close },
        },
        tiebreak = function(current_entry, existing_entry, prompt)
            return tiebreak(current_entry.ordinal, existing_entry.ordinal, prompt)
        end,
        preview = { filesize_limit = 0.2 },
    },

    extensions_list = { "themes", "terms", "fzf" },
    extensions = {
        fzf = {
            fuzzy = true,
            override_generic_sorter = true,
            override_file_sorter = true,
            case_mode = "smart_case",
        },
    },
}

return options
