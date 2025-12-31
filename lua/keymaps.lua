-- [[ Basic Keymaps ]]
--  See `:help set()`
--
local lib = require 'custom.lib'
local f_delmarks = lib.delmarks
local f_diag_goto = lib.diag_goto

local silent = { silent = true }
local set = vim.keymap.set

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch
set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
-- set('n', '<A-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
-- set('n', '<A-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
-- set('n', '<A-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
-- set('n', '<A-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

set('n', 'cc', 'gcc', { remap = true, desc = '[c]omment/un[c]omment line' })

-- Make adjusting split sizes easy
-- set('n', '<C-A-h>', '<cmd>vertical resize +3<CR>', { silent = true })
-- set('n', '<C-A-l>', '<cmd>vertical resize -3<CR>', { silent = true })
-- set('n', '<C-A-k>', '<cmd>resize +3<CR>', { silent = true })
-- set('n', '<C-A-j>', '<cmd>resize -3<CR>', { silent = true })

-- set("n", "<C-S-h>", "<C-w>H", { desc = "Move window to the left" })
-- set("n", "<C-S-l>", "<C-w>L", { desc = "Move window to the right" })
-- set("n", "<C-S-j>", "<C-w>J", { desc = "Move window to the lower" })
-- set("n", "<C-S-k>", "<C-w>K", { desc = "Move window to the upper" })

-- Move around quicker
set({ 'n', 'x', 'o' }, '<C-j>', '4j', { silent = true, noremap = true, desc = 'Move 4 lines down' })
set({ 'n', 'x', 'o' }, '<C-k>', '4k', { silent = true, noremap = true, desc = 'Move 4 lines up' })

-- Delete marks
set('n', 'dm', f_delmarks, { silent = true, desc = 'Delete marks on current line' })

set('n', '<leader>w', '<cmd>WhichKey<CR>', { silent = true, desc = 'Show [w]hich keybindings are available' })

-- Jump quickly between diagnostics
set('n', ']d', f_diag_goto(true), { desc = 'next [d]iagnostic' })
set('n', '[d', f_diag_goto(false), { desc = 'prev [d]iagnostic' })
set('n', ']e', f_diag_goto(true, 'ERROR'), { desc = 'next [e]rror' })
set('n', '[e', f_diag_goto(false, 'ERROR'), { desc = 'prev [e]rror' })
set('n', ']w', f_diag_goto(true, 'WARN'), { desc = 'next [w]arning' })
set('n', '[w', f_diag_goto(false, 'WARN'), { desc = 'prev [w]arning' })
