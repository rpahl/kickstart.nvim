return {
  {
    'R-nvim/R.nvim',
    lazy = false,
    config = function()
      require('r').setup {
        R_args = { '--no-save', '--no-restore' },
        hook = {
          on_filetype = function()
            -- Send line / selection to R with <Enter>
            vim.keymap.set('n', '<Enter>', '<Plug>RDSendLine', { buffer = true })
            vim.keymap.set('v', '<Enter>', '<Plug>RDSendSelection', { buffer = true })
          end,
        },
        -- Open R in a vertical split
        rconsole_width = 60,
        -- Don't replace neovim's built-in LSP with R.nvim's older completion
        R_nvim_wd = -1,
      }
    end,
  },
}
