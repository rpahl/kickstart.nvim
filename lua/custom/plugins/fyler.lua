return {
    'A7Lavinraj/fyler.nvim',
    dependencies = { 'nvim-mini/mini.icons' },
    branch = 'stable', -- Use stable branch for production
    lazy = false, -- Necessary for `default_explorer` to work properly
    opts = {
        views = {
            finder = {
                close_on_select = false,
                default_explorer = true,
                delete_to_trash = true,
                mappings = {
                    ['l'] = 'GotoNode',
                },
            },
        },
    },

    keys = {
        { '<leader>e', '<Cmd>Fyler<Cr>', desc = 'Open Fyler View' },
    },
}
