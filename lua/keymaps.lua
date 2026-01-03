-- [[ Keymaps ]]
--  See `:help set()`
--
local nore = { noremap = true }
local silent = { silent = true }
local silent_nore = { noremap = true, silent = true }
local set = vim.keymap.set
local umi = require 'custom.utils.misc'

-- Clear highlights on search when pressing <Esc> in normal mode
set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

--------------
-- Diagnoskics
-- -----------
set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics [q]uickfix list' })

-- Toggle diagnostic messages
set('n', '<leader>td', umi.diag_toggle, { desc = '[t]oggle [d]iagnostics messages' }) -- TODO: map to <leader><leader>d

-- Jump quickly between diagnostics
local fdigo = umi.diag_goto
set('n', ']d', fdigo(true), { desc = 'next [d]iagnostic' })
set('n', '[d', fdigo(false), { desc = 'prev [d]iagnostic' })
set('n', ']e', fdigo(true, 'ERROR'), { desc = 'next [e]rror' })
set('n', '[e', fdigo(false, 'ERROR'), { desc = 'prev [e]rror' })

----------
-- Editing
-- -------
set({ 'i' }, '<C-s>', '<Esc><S-s>', { noremap = true }) -- delete whole line in insert mode
-- Remember: to delete word by word backwards in insert mode, use builtin <C-w>

set('v', 'p', '"_dP', silent_nore) -- Keep last yanked when pasting

-- Replace word under cursor
vim.keymap.set('n', '<leader>j', '*``cgn')

-- Normal mode: move current line
-- set('n', '<C-A-j>', ':m .+1<CR>==', silent_nore)
-- set('n', '<C-A-k>', ':m .-2<CR>==', silent_nore)
--
-- -- Insert mode: move current line (then return to insert at previous position)
-- set('i', '<C-A-j>', '<Esc>:m .+1<CR>==gi', silent_nore)
-- set('i', '<C-A-k>', '<Esc>:m .-2<CR>==gi', silent_nore)
--
-- -- Visual mode: move selected lines (then reselect and reindent)
-- set('v', '<C-A-j>', ":m '>+1<CR>gv=gv", silent_nore)
-- set('v', '<C-A-k>', ":m '<-2<CR>gv=gv", silent_nore)

set('n', '<leader>w', '<cmd>WhichKey<CR>', { silent = true, desc = 'Show [w]hich keybindings are available' })

-------------
-- Navigation
-- ----------
-- Allow moving the cursor through wrapped lines with j, k
-- set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
-- set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
--
-- Lazy block-moving
set({ 'n', 'v' }, '<C-j>', '5j', { silent = true, noremap = true, desc = 'Move 5 lines down' })
set({ 'n', 'v' }, '<C-k>', '5k', { silent = true, noremap = true, desc = 'Move 5 lines up' })

set('n', 'dm', umi.delmarks, { silent = true, desc = 'Delete marks on current line' })

-- Jump quickly between buffers
-- TODO: I'd like to have <leader><leader>b for this
--
-- Use CTRL+<hjkl> to switch between windows
--
-- See `:help wincmd` for a list of all window commands
-- set('n', '<A-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
-- set('n', '<A-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
-- set('n', '<A-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
-- set('n', '<A-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- Make adjusting split sizes easy
-- set('n', '<C-A-h>', '<cmd>vertical resize +3<CR>', { silent = true })
-- set('n', '<C-A-l>', '<cmd>vertical resize -3<CR>', { silent = true })
-- set('n', '<C-A-k>', '<cmd>resize +3<CR>', { silent = true })
-- set('n', '<C-A-j>', '<cmd>resize -3<CR>', { silent = true })

-- set("n", "<C-S-h>", "<C-w>H", { desc = "Move window to the left" })
-- set("n", "<C-S-l>", "<C-w>L", { desc = "Move window to the right" })
-- set("n", "<C-S-j>", "<C-w>J", { desc = "Move window to the lower" })
-- set("n", "<C-S-k>", "<C-w>K", { desc = "Move window to the upper" })

------------
-- Save/Load
-- ---------
set('n', '<leader>ss', ':mksession! .session.vim<CR>', { noremap = true, desc = '[s]ave [s]ession' })
set('n', '<leader>so', ':source .session.vim<CR>', { noremap = true, desc = '[so]urce session' })
set('n', '<leader>sn', '<cmd>noautocmd w <CR>', silent_nore) -- save file without auto-formatting

--
-- Plugins to install maybe
-- https://github.com/folke/trouble.nvim
-- https://github.com/mbbill/undotree
-- https://github.com/tpope/vim-fugitive
-- vimium browser and/or w3m with yuratomo/w3m.vim
-- keyboard
-- folke/zen-mode
-- github/copilot.vim

-- tjdevries
