-- Define some helper functions
local M = {}

-- Delete all lowercase marks (a–z) set on the current line
function M.delmarks()
    local cur_line = vim.fn.line '.'
    local marks = {}

    for c = string.byte 'a', string.byte 'z' do
        local m = string.char(c)
        if vim.fn.line("'" .. m) == cur_line then
            marks[#marks + 1] = m
        end
    end

    if #marks > 0 then
        vim.cmd('delmarks ' .. table.concat(marks, ''))
    end
end

-- Jump to certain diagnostics
function M.diag_goto(next, severity)
    return function()
        vim.diagnostic.jump {
            count = (next and 1 or -1) * vim.v.count1,
            severity = severity and vim.diagnostic.severity[severity] or nil,
            float = true,
        }
    end
end

-- Toggle diagnostics on/off
function M.toggle_diag()
    local isEnabled = vim.diagnostic.is_enabled()

    if isEnabled then
        vim.diagnostic.enable(false)
    else
        vim.diagnostic.enable(true)
    end
end

-- Toggle highlight - shamelessly stolen from
-- https://github.com/tjdevries/config.nvim/blob/master/plugin/keymaps.lua
function M.toggle_highlight()
    if vim.v.hlsearch == 1 then
        vim.cmd.nohl()
        return ''
    else
        return vim.keycode '<CR>'
    end
end

-- Toggle inlay hints - also from
-- https://github.com/tjdevries/config.nvim/blob/master/plugin/keymaps.lua
function M.toggle_hints()
    vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = 0 }, { bufnr = 0 })
end

return M
