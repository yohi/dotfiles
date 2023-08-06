print 'nvim-navic.lua'

local nvim_navic = require('nvim-navic')
local barbecue = require('barbecue')
nvim_navic.setup {
    icons = {
        File = ' ',
        Module = ' ',
        Namespace = ' ',
        Package = ' ',
        Class = ' ',
        Method = ' ',
        Property = ' ',
        Field = ' ',
        Constructor = ' ',
        Enum = ' ',
        Interface = ' ',
        Function = ' ',
        Variable = ' ',
        Constant = ' ',
        String = ' ',
        Number = ' ',
        Boolean = ' ',
        Array = ' ',
        Object = ' ',
        Key = ' ',
        Null = ' ',
        EnumMember = ' ',
        Struct = ' ',
        Event = ' ',
        Operator = ' ',
        TypeParameter = ' ',
    },
    lsp = {
      auto_attach = true,
      preference = {
          'pyright',
      },
    },
    highlight = false,
    separator = " > ",
    depth_limit = 9,
    depth_limit_indicator = "..",
    safe_output = true,
    click = false
}
vim.o.winbar = "%{%v:lua.require'nvim-navic'.get_location()%}"

-- triggers CursorHold event faster
vim.opt.updatetime = 200

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
  "BufWinEnter",
  "CursorHold",
  "InsertLeave",

  -- include this if you have set `show_modified` to `true`
  "BufModifiedSet",
}, {
  group = vim.api.nvim_create_augroup("barbecue.updater", {}),
  callback = function()
    require("barbecue.ui").update()
  end,
})
