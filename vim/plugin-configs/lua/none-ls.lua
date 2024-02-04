local null_ls = require('null-ls')
local sources = {
  null_ls.builtins.diagnostics.cspell.with({
    diagnostics_postprocess = function(diagnostic)
      -- レベルをWARNに変更（デフォルトはERROR）
      diagnostic.severity = vim.diagnostic.severity["WARN"]
    end,
    condition = function()
      -- cspellが実行できるときのみ有効
      return vim.fn.executable('cspell') > 0
    end
  }),
  null_ls.builtins.diagnostics.mypy.with({
    diagnostics_postprocess = function(diagnostic)
      -- レベルをWARNに変更（デフォルトはERROR）
      diagnostic.severity = vim.diagnostic.severity["WARN"]
    end,
    condition = function()
      -- cspellが実行できるときのみ有効
      return vim.fn.executable('mypy') > 0
    end
  }),

}

null_ls.setup({
  sources = sources
})
