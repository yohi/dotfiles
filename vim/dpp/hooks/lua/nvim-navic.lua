-- lua_add {{{
print('read navic.lua !! lua_add!!')

local nvim_navic = require('nvim-navic')
nvim_navic.setup({
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
            'basedpyright',
        },
    },
    highlight = false,
    separator = " > ",
    depth_limit = 9,
    depth_limit_indicator = "..",
    safe_output = true,
    click = false
})
vim.o.winbar = "%{%v:lua.require'nvim-navic'.get_location()%}"

-- }}}
