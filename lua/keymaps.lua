-- [[ Keymaps ]]
--  See `:help set()`
--
local nore = { noremap = true }
local silent = { silent = true }
local silent_nore = { noremap = true, silent = true }
local set = vim.keymap.set
local umi = require 'custom.utils.misc'

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

----------
-- Editing
-- -------
set({ 'i' }, '<C-s>', '<Esc><S-s>', { noremap = true }) -- delete whole line in insert mode
-- Remember: to delete word by word backwards in insert mode, use builtin <C-w>

set('v', 'p', '"_dP', silent_nore) -- Keep last yanked when pasting

-- Move lines (and re-indent)
set('n', '<A-j>', ':m .+1<CR>==', { silent = true, noremap = true, desc = 'Move current line down' })
set('n', '<A-k>', ':m .-2<CR>==', { silent = true, noremap = true, desc = 'Move current line up' })
set('v', '<A-j>', ":m '>+1<CR>gv=gv", { silent = true, noremap = true, desc = 'Move selected lines down' })
set('v', '<A-k>', ":m '<-2<CR>gv=gv", { silent = true, noremap = true, desc = 'Move selected lines up' })

set('n', 'dm', umi.delmarks, { silent = true, desc = 'Delete marks on current line' })

--------
-- Infos
-- -----
set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics [q]uickfix list' })
set('n', '<leader>w', '<cmd>WhichKey<CR>', { silent = true, desc = 'Show [w]hich keybindings are available' })

-------------
-- Navigation
-- ----------
-- Allow moving the cursor through wrapped lines with j, k
set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Lazy block-moving
set({ 'n', 'v' }, '<C-j>', '5j', { silent = true, noremap = true, desc = 'Move 5 lines down' })
set({ 'n', 'v' }, '<C-k>', '5k', { silent = true, noremap = true, desc = 'Move 5 lines up' })

-- Jump quickly between diagnostics
local fdigo = umi.diag_goto
set('n', ']d', fdigo(true), { desc = 'next [d]iagnostic' })
set('n', '[d', fdigo(false), { desc = 'prev [d]iagnostic' })
set('n', ']e', fdigo(true, 'ERROR'), { desc = 'next [e]rror' })
set('n', '[e', fdigo(false, 'ERROR'), { desc = 'prev [e]rror' })

-- Jump quickly between buffers
-- TODO: I'd like to have <leader><leader>b for this

-- Split adjustment
set('n', '<A-h>', '<cmd>vertical resize +4<CR>', { silent = true, desc = '' })
set('n', '<A-l>', '<cmd>vertical resize -4<CR>', { silent = true })
set('n', '<A-k>', '<cmd>resize +2<CR>', { silent = true })
set('n', '<A-j>', '<cmd>resize -2<CR>', { silent = true })

-- TODO: consider creating maps to jump to next ], }, ) and prev [, {, (
-- if mapped using f, t motions, we then can proceed with ; and , as usual

------------
-- Save/Load
-- ---------
set('n', '<leader>ss', ':mksession! .session.vim<CR>', { noremap = true, desc = '[s]ave [s]ession' })
set('n', '<leader>so', ':source .session.vim<CR>', { noremap = true, desc = '[so]urce session' })
set('n', '<leader>sn', '<cmd>noautocmd w <CR>', silent_nore) -- save file without auto-formatting

----------
-- Toggles
-- -------
set('n', '<leader>td', umi.toggle_diag, { desc = '[t]oggle [d]iagnostics messages' }) -- TODO: map to <leader><leader>d
set('n', '<CR>', umi.toggle_highlight, { expr = true })
set('n', '<leader>tw', '<cmd>set wrap!<CR>', { noremap = true, desc = '[t]oggle line [w]rap' })

-- Plugins to install maybe
-- https://github.com/folke/trouble.nvim
-- https://github.com/mbbill/undotree
-- https://github.com/tpope/vim-fugitive
-- vimium browser and/or w3m with yuratomo/w3m.vim
-- keyboard
-- folke/zen-mode
-- github/copilot.vim

-- tjdevries
