local has_words_before = function()
    local col = vim.api.nvim_win_get_cursor(0)[2]
    if col == 0 then
        return false
    end
    local line = vim.api.nvim_get_current_line()
    return line:sub(col, col):match '%s' == nil
end

-- If completion hasn't been triggered yet, insert the first suggestion; if it has, cycle to the next suggestion.
local trigger_cmp = function(cmp)
    if has_words_before() then
        return cmp.insert_next()
    end
end

return {
    { -- Autocompletion
        'saghen/blink.cmp',
        event = 'VimEnter',
        version = '1.*',
        dependencies = {
            -- Snippet Engine
            {
                'L3MON4D3/LuaSnip',
                version = '2.*',
                build = (function()
                    -- Build Step is needed for regex support in snippets.
                    -- This step is not supported in many windows environments.
                    -- Remove the below condition to re-enable on windows.
                    if vim.fn.has 'win32' == 1 or vim.fn.executable 'make' == 0 then
                        return
                    end
                    return 'make install_jsregexp'
                end)(),
                dependencies = {
                    -- `friendly-snippets` contains a variety of premade snippets.
                    --    See the README about individual language/framework/plugin snippets:
                    --    https://github.com/rafamadriz/friendly-snippets
                    -- {
                    --   'rafamadriz/friendly-snippets',
                    --   config = function()
                    --     require('luasnip.loaders.from_vscode').lazy_load()
                    --   end,
                    -- },
                },
                opts = {},
            },
            'folke/lazydev.nvim',
        },
        --- @module 'blink.cmp'
        --- @type blink.cmp.Config
        opts = {
            keymap = {
                -- 'default' (recommended) for mappings similar to built-in completions
                --   <c-y> to accept ([y]es) the completion.
                --    This will auto-import if your LSP supports it.
                --    This will expand snippets if the LSP sent a snippet.
                -- 'super-tab' for tab to accept
                -- 'enter' for enter to accept
                -- 'none' for no mappings
                --
                -- For an understanding of why the 'default' preset is recommended,
                -- you will need to read `:help ins-completion`
                --
                -- No, but seriously. Please read `:help ins-completion`, it is really good!
                --
                -- All presets have the following mappings:
                -- <tab>/<s-tab>: move to right/left of your snippet expansion
                -- <c-space>: Open menu or open docs if already open
                -- <c-n>/<c-p> or <up>/<down>: Select next/previous item
                -- <c-e>: Hide menu
                -- <c-k>: Toggle signature help
                -- See :h blink-cmp-config-keymap for defining your own keymap
                preset = 'none',

                -- ['<C-space>'] = { 'show', 'show_documentation', 'hide_documentation' },
                ['<C-d>'] = { 'show', 'show_documentation', 'hide_documentation' },
                ['<C-A-d>'] = { 'show', 'show_documentation', 'hide_documentation' },
                ['<Up>'] = { 'scroll_documentation_up', 'fallback' },
                ['<Down>'] = { 'scroll_documentation_down', 'fallback' },
                ['<C-s>'] = { 'show_signature', 'hide_signature', 'fallback' },
                -- ['<C-k>'] = false,
                -- <C-K> and <C-J> is already covered by general vim.keymap.set('c', ...) - see keymaps.lua
                ['<C-e>'] = { 'hide', 'fallback' },
                --
                -- ['<Tab>'] = { 'show_and_insert', 'fallback' },
                ['<CR>'] = { 'accept', 'fallback' },
                ['<Tab>'] = { 'select_next', 'fallback' },
                -- ['<Tab>'] = { 'show', 'select_next', 'fallback' },
                -- completion = {
                --     menu = { enabled = false },
                --     list = { selection = { preselect = false }, cycle = { from_top = false } },
                -- }
                -- ['<C-b>'] = false,
                -- ['<C-f>'] = false,
                -- For more advanced Luasnip keymaps (e.g. selecting choice nodes, expansion) see:
                --    https://github.com/L3MON4D3/LuaSnip?tab=readme-ov-file#keymaps
            },
            appearance = {
                -- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
                -- Adjusts spacing to ensure icons are aligned
                nerd_font_variant = 'mono',
            },

            sources = {
                default = { 'lazydev', 'lsp', 'path', 'snippets', 'buffer' },
                providers = {
                    lazydev = {
                        module = 'lazydev.integrations.blink',
                        -- make lazydev completions top priority (see `:h blink.cmp`)
                        score_offset = 100,
                    },
                    cmdline = {
                        -- ignores cmdline completions when executing shell commands
                        enabled = function()
                            return vim.fn.getcmdtype() ~= ':' or not vim.fn.getcmdline():match "^[%%0-9,'<>%-]*!"
                        end,
                    },
                },
            },
            --
            -- Blink.cmp includes an optional, recommended rust fuzzy matcher,
            -- which automatically downloads a prebuilt binary when enabled.
            --
            -- By default, we use the Lua implementation instead, but you may enable
            -- the rust implementation via `'prefer_rust_with_warning'`
            --
            -- See :h blink-cmp-config-fuzzy for more information
            -- fuzzy = { implementation = 'lua' },
            fuzzy = {
                implementation = 'prefer_rust_with_warning',
                sorts = {
                    'score', -- Primary sort: by fuzzy matching score
                    'sort_text', -- Secondary sort: by sortText field if scores are equal
                    'label', -- Tertiary sort: by label if still tied
                },
            },
            --

            -- Shows a signature help window while you type arguments for a function
            signature = { enabled = true },
            completion = {
                menu = { auto_show = false },
                documentation = { auto_show = false },
                signature = { auto_show = false },
                ghost_text = { enabled = true },
                list = { selection = { preselect = false } },
                -- keyword = { range = 'prefix' },
            },
            cmdline = {
                keymap = {
                    -- ['<Tab>'] = { 'show', 'accept' },
                    -- ['<Tab>'] = { trigger_cmp, 'fallback' },
                    -- ['<Tab>'] = { 'show_and_insert_or_accept_single', 'fallback' },
                    ['<Tab>'] = { 'show', 'select_next', 'fallback' },
                    ['<CR>'] = { 'accept_and_enter', 'fallback' },
                },
                completion = {
                    -- menu = { auto_show = false },
                    list = { selection = { preselect = false } },
                    menu = {
                        auto_show = function(ctx, _)
                            return ctx.mode == 'cmdwin'
                        end,
                    },
                    ghost_text = { enabled = true },
                },
                sources = function()
                    local type = vim.fn.getcmdtype()
                    -- Search forward and backward
                    if type == '/' or type == '?' then
                        return { 'buffer' }
                    end
                    -- Commands
                    if type == ':' or type == '@' then
                        return { 'cmdline', 'buffer' }
                    end
                    return {}
                end,
                fuzzy = { sorts = { 'exact', 'score', 'score_text' } },
            },
            snippets = { preset = 'luasnip' },
        },
    },
}
