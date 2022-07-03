-- null-ls --
local null_ls = require("null-ls")

local sources = {
    null_ls.builtins.diagnostics.djlint,
    null_ls.builtins.diagnostics.cspell,
    null_ls.builtins.diagnostics.mypy,
    null_ls.builtins.diagnostics.flake8,
}

null_ls.setup({
    -- diagnostics_format = '#{m} [#{c}]',
    -- diagnostics_format = '#{m} (#{s})',
    diagnostics_format = '#{s}: #{m}',
    sources = sources,
    -- on_attach = on_attach
})
