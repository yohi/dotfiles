-- lua_add {{{
--
print('barbecue.lua')

local barbecue = require('barbecue')

barbecue.setup({
    create_autocmd = false, -- prevent barbecue from updating itself automatically
    separator = "  ",
    icons_enabled = true,
    icons = {
        default = "",
        symlink = "",
        git = "",
        folder = "",
        ["folder-open"] = "",
    },
})

vim.api.nvim_create_autocmd({
    "WinScrolled", -- or WinResized on NVIM-v0.9 and higher
    "BufEnter",
    "BufWinEnter",
    "CursorHold",
    "InsertLeave",
    -- include this if you have set `show_modified` to `true`
    "BufModifiedSet",
    "BufReadPre",
    "BufNewFile",
},
{
    group = vim.api.nvim_create_augroup("barbecue.updater", {}),
    callback = function()
        require("barbecue.ui").update()
    end,
})

-- }}}
