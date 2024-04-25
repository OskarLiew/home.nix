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
            local function get_last_path_component(file_path)
                -- Check if filePath ends with '/'
                if string.sub(file_path, -1) == "/" then
                    -- Remove trailing '/'
                    file_path = string.sub(file_path, 1, -2)
                end

                -- Find the last occurrence of '/'
                local last_slash_index, _ = string.find(file_path, "/[^/]*$")
                -- Extract the last component
                local last_component = string.sub(file_path, (last_slash_index or 0) + 1)
                if last_component then
                    return last_component
                end
            end

            local current_last = get_last_path_component(current_entry.ordinal)
            local existing_last = get_last_path_component(existing_entry.ordinal)

            -- Prefer files with prompt in last component
            local start_pos1, _ = current_last:find(prompt)
            if start_pos1 then
                local start_pos2, _ = existing_last:find(prompt)
                if start_pos2 then
                    if start_pos1 ~= start_pos2 then -- If same pos, then continue
                        return start_pos1 < start_pos2
                    end
                else
                    return true
                end
            end

            -- Fallback to shortest first
            return #current_entry.ordinal < #existing_entry.ordinal
        end,
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
