-- null-ls --
local mason = require("mason")
local null_ls = require("null-ls")
local utils = require("lspconfig.util")
local mason_null_ls = require("mason-null-ls")
-- local command_resolver = require("null-ls.helpers.command_resolver")
-- local root_dir = utils.root_pattern('.venv')
local root_dir = utils.root_pattern('.venv')
vim.fn.setenv('MYPYPATH', vim.env.VIRTUAL_ENV)


mason.setup()
mason_null_ls.setup({
  automatic_installation = true,
  automatic_setup = false,
  root_dir = utils.root_pattern(".venv", ".git"),
  diagnostics_format = '#{s}: #{m}',
  ensure_installed = {
    "phpcs",
    "cspell",
    "djlint",
    "isort",
    "mypy",
  }
})

local sources = {
  null_ls.builtins.diagnostics.phpcs.with({
      method = null_ls.methods.DIAGNOSTICS,
      args = {
        '--standard=./phpcs.xml',
      },
      diagnostics_postprocess = function(diagnostics)
        -- レベルをWARNに変更
        diagnostics.severity =  vim.diagnostics.severity["WARN"]
      end,
  }),
  null_ls.builtins.diagnostics.cspell.with({
      diagnostics_postprocess = function(diagnostics)
        -- レベルをWARNに変更
        -- diagnostics.severity =  vim.diagnostics.severity["WARN"]
      end,
      condition = function()
        -- cpellが実行できるときのみ実行
        return vim.fn.filereadable('.cspell.json') > 0
      end,
  }),
  null_ls.builtins.diagnostics.djlint.with({
      diagnostics_postprocess = function(diagnostics)
        -- レベルをWARNに変更
        diagnostics.severity =  vim.diagnostics.severity["WARN"]
      end,
  }),
}

null_ls.setup({
  root_dir = utils.root_pattern('.venv'),
  diagnostics_format = '#{s}: #{m}',
  sources = sources,
  root_dir = utils.root_pattern('.venv', '.git'),
  on_attach = function(_, bufnr)
      vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>ca',
        '<cmd>lua vim.lsp.buf.code_action()<CR>', {noremap = true, silent = true})
 
      vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
  end
})

mason_null_ls.setup_handlers{
  function(source_name, methods)
    -- all sources with no handler get passed here

    -- To keep the original functionality of `automatic_setup = true`,
    -- please add the below.
    require("mason-null-ls.automatic_setup")(source_name, methods)
  end,
  flake8 = function(source_name, methods)
    null_ls.register(
      null_ls.builtins.diagnostics.flake8.with({
          prefer_local = vim.env.VIRTUAL_ENV .. '/bin',
          diagnostics_postprocess = function(diagnostic)
              -- レベルをWARNに変更
              diagnostic.severity =  vim.diagnostic.severity["WARN"]
          end,
      })
    )
  end,
  cspell = function(source_name, methods)
    null_ls.register(
      null_ls.builtins.diagnostics.cspell.with({
          -- extra_args = {
          --     '--config',
          --     '~/.config/cspell/cspell.json',
          -- },
          diagnostics_postprocess = function(diagnostic)
              -- レベルをINFOに変更
              diagnostic.severity =  vim.diagnostic.severity["INFO"]
          end,
          method = null_ls.methods.DIAGNOSTICS_ON_SAVE,
          -- condition = function()
          --     -- cpellが実行できるときのみ実行
          --     return vim.fn.executable('cspell') > 0
          -- end,
      })
    )
  end,
  isort = function(source_name, methods)
    null_ls.register(
      null_ls.builtins.formatting.isort.with({
          command = 'isort',
          timeout = 60000,
          -- prefer_local = '.venv/bin',
          prefer_local = vim.env.VIRTUAL_ENV .. '/bin',
          diagnostics_postprocess = function(diagnostic)
              -- レベルをWARNに変更
              diagnostic.severity =  vim.diagnostic.severity["WARN"]
          end,
      })
    )
  end,
  djlint = function(source_name, methods)
    null_ls.register(
      null_ls.builtins.formatting.djlint.with({
          command = 'djlint',
          -- prefer_local = '.venv/bin',
          prefer_local = vim.env.VIRTUAL_ENV .. '/bin',
          diagnostics_postprocess = function(diagnostic)
              -- レベルをWARNに変更
              diagnostic.severity =  vim.diagnostic.severity["WARN"]
          end,
      })
    )
  end,
  mypy = function(source_name, methods)
    null_ls.register(
      null_ls.builtins.diagnostics.mypy.with({
          prefer_local = vim.env.VIRTUAL_ENV .. '/bin',
          -- prefer_local = '.venv/bin',
          timeout = 60000,
          method = null_ls.methods.DIAGNOSTICS_ON_SAVE,
          -- diagnostics_postprocess = function(diagnostic)
          --     -- レベルをWARNに変更
          --     diagnostic.severity =  vim.diagnostic.severity["WARN"]
          -- end,
          extra_args = {
              -- '--use-fine-grained-cache',
              '--cache-dir',
              '/dev/null',
              -- "--incremental",
              -- "--follow-imports",
              -- "silent",
          }
      })
    )
  end,
}
