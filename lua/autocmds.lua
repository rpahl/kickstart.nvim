
-- Remove trailing whitespace on save
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*",
  callback = function()
    -- Save cursor position (and view) so the substitution doesn't jump your screen
    local view = vim.fn.winsaveview()
    -- Remove trailing whitespace
    vim.cmd([[%s/\s\+$//e]])
    vim.fn.winrestview(view)
  end,
})
