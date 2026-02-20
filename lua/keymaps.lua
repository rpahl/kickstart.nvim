-- [[ Keymaps ]]
--  See `:help set()`
--
local nore = { noremap = true }
local silent = { silent = true }
local silent_nore = { noremap = true, silent = true }
local set = vim.keymap.set
local umi = require 'custom.utils.misc'

-- This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- Key remaps to mitigate german keyboard layout
set({ 'n', 'x', 'o' }, 'ö', '[', { remap = true, silent = true, desc = 'ö as [' })
set({ 'n', 'x', 'o' }, 'ä', ']', { remap = true, silent = true, desc = 'ä as ]' })

----------
-- Editing
-- -------
set('v', 'p', '"_dP', silent_nore) -- Keep last yanked when pasting
set({ 'i' }, '<C-s>', '<Esc><S-s>', { noremap = true }) -- delete whole line in insert mode
-- Remember: to delete word by word backwards in insert mode, use builtin <C-w>

-- Move lines (and re-indent)
set('v', '<A-j>', ":m '>+1<CR>gv=gv", { silent = true, noremap = true, desc = 'Move selected lines down' })
set('v', '<A-k>', ":m '<-2<CR>gv=gv", { silent = true, noremap = true, desc = 'Move selected lines up' })

--------
-- Infos
-- -----
set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics [q]uickfix list' })
set('n', '<leader>?', '<cmd>WhichKey<CR>', { silent = true, desc = 'Show global keybindings' })
set('n', 'dm', umi.delmarks, { silent = true, desc = 'Delete marks on current line' })

-------------
-- Navigation
-- ----------
-- Allow moving the cursor through wrapped lines with j, k
set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Vertical scroll and center
vim.keymap.set('n', '<C-d>', '<C-d>zz', silent_nore)
vim.keymap.set('n', '<C-u>', '<C-u>zz', silent_nore)

-- Jump quickly between diagnostics
local fdigo = umi.diag_goto
set('n', ']d', fdigo(true), { desc = 'next [D]iagnostic' })
set('n', '[d', fdigo(false), { desc = 'prev [D]iagnostic' })
set('n', ']e', fdigo(true, 'ERROR'), { desc = 'next [E]rror' })
set('n', '[e', fdigo(false, 'ERROR'), { desc = 'prev [E]rror' })

set('n', 'g.', '`.', { noremap = true, desc = 'goto last edit' })

-- Buffers
set('n', '<leader>bb', '<cmd>e #<cr>', { desc = 'Switch to Other Buffer' })
set('n', '<leader><leader>b', '<cmd>e #<cr>', { desc = 'Switch to Other Buffer' })

-- Split adjustment
set('n', '<C-w>p', '<cmd>vertical resize +4<CR>')
set('n', '<C-w>u', '<cmd>vertical resize -4<CR>')
set('n', '<C-w>o', '<cmd>resize +2<CR>')
set('n', '<C-w>i', '<cmd>resize -2<CR>')

-- TODO: consider creating maps to jump to next ], }, ) and prev [, {, (
-- if mapped using f, t motions, we then can proceed with ; and , as usual
-- set('n', '<leader>f0', { desc = 'prev [e]rror' })

----------
-- Session
-- -------
set('n', '<leader>ss', ':mksession! .session.vim<CR>', { noremap = true, desc = 'Save session' })
set('n', '<leader>so', ':source .session.vim<CR>', { noremap = true, desc = 'Open session' })
set('n', '<leader>sc', ':qa<CR>', { desc = 'Close session' })

----------
-- Toggles
-- -------
set('n', '<leader><leader>d', umi.toggle_diag, { desc = 'Toggle [d]iagnostics messages on/off' })
set('n', '<CR>', umi.toggle_highlight, { expr = true, desc = 'Toggle highlight on/off' })
set('n', '<leader><leader>w', '<cmd>set wrap!<CR>', { noremap = true, desc = 'Toggle line [w]rap' })

-- Plugins to install maybe
-- https://github.com/folke/trouble.nvim
-- https://github.com/mbbill/undotree
-- https://github.com/tpope/vim-fugitive
-- vimium browser and/or w3m with yuratomo/w3m.vim
-- folke/zen-mode
-- github/copilot.vim
--
-- new keyboard?
