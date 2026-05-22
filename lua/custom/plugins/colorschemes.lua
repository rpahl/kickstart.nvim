-- Load and configure color schemes
return {
    --[[
    { "EdenEast/nightfox.nvim" },
    { "ellisonleao/gruvbox.nvim" },
    { "ribru17/bamboo.nvim" },
    { "shaunsingh/moonlight.nvim" },
    --]]
    { "craftzdog/solarized-osaka.nvim" },
    { "marko-cerovac/material.nvim" },
    {
        "maxmx03/solarized.nvim",
        priority = 1000,
        config = function()
            vim.cmd.colorscheme 'solarized'
        end,
    },
}
