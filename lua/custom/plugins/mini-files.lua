return {
    'nvim-mini/mini.files',
    opts = {
        mappings = {
            close = 'q',
            go_in = 'l',
            go_in_plus = '<CR>',
            go_out = 'h',
            go_out_plus = 'H',
            reset = '<BS>',
            show_help = 'g?',
            synchronize = '=',
            trim_left = '<Left>',
            trim_right = '<Right>',
        },
        windows = {
            preview = true,
            width_focus = 40,
            width_preview = 60,
        },
        options = {
            -- Whether to use for editing directories
            -- Disabled by default in LazyVim because neo-tree is used for that
            use_as_default_explorer = true,
            -- If set to false, files are not deleted but moved to the trash directory
            -- mini.files/trash, which is created in the following dir:
            -- :echo stdpath('data')
            permanent_delete = false,
        },
    },
    keys = {
        {
            -- Open the directory of the file currently being edited
            -- If the file doesn't exist because you maybe switched to a new git branch
            -- open the current working directory
            '<leader>em',
            function()
                local buf_name = vim.api.nvim_buf_get_name(0)
                local dir_name = vim.fn.fnamemodify(buf_name, ':p:h')
                if vim.fn.filereadable(buf_name) == 1 then
                    -- Pass the full file path to highlight the file
                    require('mini.files').open(buf_name, true)
                elseif vim.fn.isdirectory(dir_name) == 1 then
                    -- If the directory exists but the file doesn't, open the directory
                    require('mini.files').open(dir_name, true)
                else
                    -- If neither exists, fallback to the current working directory
                    require('mini.files').open(vim.uv.cwd(), true)
                end
            end,
            desc = 'Open mini.files (Directory of Current File or CWD if not exists)',
        },
        {
            '<leader>eM',
            function()
                require('mini.files').open(vim.uv.cwd(), true)
            end,
            desc = 'Open mini.files (cwd)',
        },
    },
}
