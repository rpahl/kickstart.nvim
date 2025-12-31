-- Remove trailing whitespace on save
vim.api.nvim_create_autocmd('BufWritePre', {
    pattern = '*',
    callback = function()
        -- Save cursor position (and view) so the substitution doesn't jump your screen
        local view = vim.fn.winsaveview()
        -- Remove trailing whitespace
        vim.cmd [[%s/\s\+$//e]]
        vim.fn.winrestview(view)
    end,
})

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.hl.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
    desc = 'Highlight when yanking (copying) text',
    group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
    callback = function()
        vim.hl.on_yank()
    end,
})
