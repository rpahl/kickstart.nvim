-- NOTE: Plugins can specify dependencies.
--
-- The dependencies are proper plugin specifications as well - anything
-- you do for a plugin at the top level, you can do for a dependency.
--
-- Use the `dependencies` key to specify the dependencies of a particular plugin

return {
  { -- Fuzzy Finder (files, lsp, etc)
    'nvim-telescope/telescope.nvim',
    event = 'VimEnter',
    dependencies = {
      'nvim-lua/plenary.nvim',
      { -- If encountering errors, see telescope-fzf-native README for installation instructions
        'nvim-telescope/telescope-fzf-native.nvim',

        -- `build` is used to run some command when the plugin is installed/updated.
        -- This is only run then, not every time Neovim starts up.
        build = 'make',

        -- `cond` is a condition used to determine whether this plugin should be
        -- installed and loaded.
        cond = function()
          return vim.fn.executable 'make' == 1
        end,
      },
      { 'nvim-telescope/telescope-ui-select.nvim' },

      -- Useful for getting pretty icons, but requires a Nerd Font.
      { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
    },
    config = function()
      -- Telescope is a fuzzy finder that comes with a lot of different things that
      -- it can fuzzy find! It's more than just a "file finder", it can search
      -- many different aspects of Neovim, your workspace, LSP, and more!
      --
      -- The easiest way to use Telescope, is to start by doing something like:
      --  :Telescope help_tags
      --
      -- After running this command, a window will open up and you're able to
      -- type in the prompt window. You'll see a list of `help_tags` options and
      -- a corresponding preview of the help.
      --
      -- Two important keymaps to use while in Telescope are:
      --  - Insert mode: <c-/>
      --  - Normal mode: ?
      --
      -- This opens a window that shows you all of the keymaps for the current
      -- Telescope picker. This is really useful to discover what Telescope can
      -- do as well as how to actually do it!

      -- [[ Configure Telescope ]]
      -- See `:help telescope` and `:help telescope.setup()`

      local actions = require 'telescope.actions'
      require('telescope').setup {
        -- You can put your default mappings / updates / etc. in here
        --  All the info you're looking for is in `:help telescope.setup()`
        --
        defaults = {
          sorting_strategy = 'ascending',
          layout_config = { prompt_position = 'top' },
          mappings = {
            i = {
              ['<C-j>'] = actions.move_selection_next,
              ['<C-k>'] = actions.move_selection_previous,
              ['<Down>'] = actions.preview_scrolling_down,
              ['<Up>'] = actions.preview_scrolling_up,
              ['<Left>'] = actions.preview_scrolling_left,
              ['<Right>'] = actions.preview_scrolling_right,
            },
            n = {
              ['q'] = actions.close,
            },
          },
        },
        pickers = {
          find_files = {
            file_ignore_patterns = {
              'node_modules',
              '.git',
              '.venv',
              '.swp',
              'tmp',
              '.Rcheck',
              '.Rhistory',
              '.Rproj',
            },
            hidden = true,
          },
          buffers = {
            sort_mru = true,
            mappings = {
              n = { ['d'] = actions.delete_buffer },
              i = { ['<C-d>'] = actions.delete_buffer },
            },
          },
          marks = {
            initial_mode = 'insert',
          },
          oldfiles = {
            initial_mode = 'insert',
          },
        },
        extensions = {
          ['ui-select'] = {
            require('telescope.themes').get_dropdown(),
          },
        },
      }

      -- Enable Telescope extensions if they are installed
      pcall(require('telescope').load_extension, { 'fzf', 'ui-select' })

      -- See `:help telescope.builtin`
      local set = vim.keymap.set
      local tel = require 'telescope.builtin'

      set('n', '<leader>/', function()
        tel.current_buffer_fuzzy_find(
          require('telescope.themes').get_dropdown {
          winblend = 10,
          previewer = false,
          layout_config = { width = 100 }
        }
      )
      end, { desc = 'Fuzzy Search current Buffer' })

      ---------------------
      -- Find files/buffers
      set(
        'n', '<leader>f/', function()
          tel.live_grep {
            grep_open_files = true, -- i.e. basically greps in all buffers
            prompt_title = 'Live Grep in all buffers',
          }
        end, { desc = 'Fuzzy Search all Buffers' }
      )
      set('n', '<leader>fb', tel.buffers, { desc = 'Buffer by Name' })
      set('n', '<leader>fg', tel.live_grep, { desc = 'grep Files' })
      set('n', '<leader>ff', tel.find_files, { desc = 'File by Name' })
      set('n', '<leader>fo', tel.oldfiles, { desc = 'Old File by Name' })
      set('n', '<leader>fw', tel.grep_string, { desc = 'grep Word under cursor' })
      set(
        'n', '<leader>fn', function()
          tel.find_files { cwd = vim.fn.stdpath 'config' } -- find in cwd
        end, { desc = 'find neovim config files' }
      )

      -----------------
      -- General search
      set('n', '<leader>fd', tel.diagnostics, { desc = 'Diagnostics' })
      set('n', '<leader>fh', tel.help_tags, { desc = 'Help' })
      set('n', '<leader>fk', tel.keymaps, { desc = 'Keybindings' })
      -- set('n', '<leader>fm', tel.marks, { desc = 'marks' })
      -- set('n', '<leader>fr', tel.registers, { desc = 'registers' })
      set('n', '<leader>fr', tel.resume, { desc = 'Resume last Search' })
      set('n', '<leader>f?', tel.builtin, { desc = 'Telescope builtins' })

    end,
  },
}
-- vim: ts=2 sts=2 sw=2 et
