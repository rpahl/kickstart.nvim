-- [[ Setting options ]]
-- See `:help opt`
-- NOTE: You can change these options as you wish!
--  For more options, you can see `:help option-list`

local opt = vim.opt

opt.termguicolors = true -- set termguicolors to enable highlight groups
opt.hlsearch = true -- Set highlight on search
opt.backup = false -- creates a backup file
opt.whichwrap = 'bs<>[]hl' -- which "horizontal" keys are allowed to travel to prev/next line
opt.wrap = false -- display lines as one long line
opt.linebreak = true -- break long lines smartly (i.e. not in the middle of a word)
opt.showtabline = 1 -- show if there are at least two tabs
opt.backspace = 'indent,eol,start' -- allow backspace on
opt.conceallevel = 0 -- make `` is visible in markdown files
opt.fileencoding = 'utf-8' -- the encoding written to a file
opt.shortmess:append 'c' -- don't give |ins-completion-menu| messages
opt.iskeyword:append '-' -- hyphenated words recognized by searches
opt.autoindent = true -- copy indent from current line when starting new one
opt.breakindent = true -- auto-indent lines that were broken to align in block
opt.smartindent = true -- smart auto-indenting when starting new line
opt.cursorline = false -- Don't hightlight current line
opt.shiftwidth = 4 -- the number of spaces inserted for each indentation
opt.smoothscroll = false
opt.shiftwidth = 4 -- the number of spaces inserted for each indentation
opt.softtabstop = 4 -- Number of spaces that a tab counts for while performing editing operations for
opt.tabstop = 4 -- insert n spaces for a tab
opt.mouse = 'a' -- enable mouse
opt.number = true -- show line numbers
opt.relativenumber = true -- use relative line numbersj:w
opt.showmode = false -- mode already shown in status line
opt.undofile = true -- Save undo history
opt.ignorecase = true -- Case-insensitive searching UNLESS \C or capital in search
opt.smartcase = true
opt.swapfile = false -- we don't need swap files
opt.signcolumn = 'yes' -- Keep signcolumn showing the git status on by default
opt.timeoutlen = 300 -- Time in ms to wait for a mapped sequence to complete (default 1000)
opt.splitbelow = true -- force all horizontal splits to go below current window
opt.splitright = true -- force all vertical splits to go to the right of current window
opt.inccommand = 'split' -- preview substitutions (i.e., :%s/<pattern>/<relace>) live while typing
opt.scrolloff = 4 -- minimal number of screen lines to keep above and below the cursor
opt.confirm = true -- ask before closing unsaved files
opt.expandtab = true -- always conver tab characters to spaces
opt.wildignore:append([[*/tmp/*]], [[*/cache/*]], '*.swp', '*.zip', '*.exe', '*.o', '*.obj', '.git')
opt.more = false -- auto-scroll list to end instead of asking for confirm to show more

-- Don't insert the current comment leader automatically for auto-wrapping comments
-- using 'textwidth', hitting <Enter> in insert mode, or hitting 'o' or 'O' in normal mode.
opt.formatoptions:remove { 'c', 'r', 'o' }

-- Sync clipboard between OS and Neovim.
--  Schedule the setting after `UiEnter` because it can increase startup-time.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.schedule(function()
    opt.clipboard = 'unnamedplus'
end)

-- Sets how neovim will display certain whitespace characters in the editor.
--   See `:help lua-options`
--   and `:help lua-options-guide`
opt.list = true
opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Completely ignore file modelines like: vim: ts=2 sts=2 sw=2 et
-- as it overrides the global shiftwidth and tabstop option values
-- opt.modeline = false
