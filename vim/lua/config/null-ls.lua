local function dump(o)
   if type(o) == 'table' then
      local s = '{ '
      for k,v in pairs(o) do
         if type(k) ~= 'number' then k = '"'..k..'"' end
         s = s .. '['..k..'] = ' .. dump(v) .. ','
      end
      return s .. '} '
  else
      return tostring(o)
   end
end

-- null-ls --
local mason = require("mason")
local null_ls = require("null-ls")
local utils = require("lspconfig.util")
local mason_null_ls = require("mason-null-ls")
-- local command_resolver = require("null-ls.helpers.command_resolver")
-- local root_dir = utils.root_pattern('.venv')
local root_dir = utils.root_pattern('.venv')
vim.fn.setenv('MYPYPATH', vim.env.VIRTUAL_ENV)

-- local sources = {
--     debug = false,
--     -- Diagnostics
--     null_ls.builtins.diagnostics.flake8.with({
--         prefer_local = vim.env.VIRTUAL_ENV .. '/bin',
--         diagnostics_postprocess = function(diagnostic)
--             -- レベルをWARNに変更
--             diagnostic.severity =  vim.diagnostic.severity["WARN"]
--         end,
--     }),
--     -- null_ls.builtins.diagnostics.mypy.with({
--     --     prefer_local = vim.env.VIRTUAL_ENV .. '/bin',
--     --     -- prefer_local = '.venv/bin',
--     --     timeout = 60000,
--     --     -- method = null_ls.methods.DIAGNOSTICS_ON_SAVE,
--     --     -- diagnostics_postprocess = function(diagnostic)
--     --     --     -- レベルをWARNに変更
--     --     --     diagnostic.severity =  vim.diagnostic.severity["WARN"]
--     --     -- end,
--     --     extra_args = {
--     --         "--cache-dir",
--     --         "/dev/null",
--     --         "--incremental",
--     --         "--follow-imports",
--     --         "silent",
--     --     }
--     -- }),
--     null_ls.builtins.diagnostics.cspell.with({
--         -- extra_args = {
--         --     '--config',
--         --     '~/.config/cspell/cspell.json',
--         -- },
--         diagnostics_postprocess = function(diagnostic)
--             -- レベルをINFOに変更
--             diagnostic.severity =  vim.diagnostic.severity["INFO"]
--         end,
--         method = null_ls.methods.DIAGNOSTICS_ON_SAVE,
--         -- condition = function()
--         --     -- cpellが実行できるときのみ実行
--         --     return vim.fn.executable('cspell') > 0
--         -- end,
--     }),
--     -- Formatting
--     null_ls.builtins.formatting.isort.with({
--         command = 'isort',
--         timeout = 60000,
--         -- prefer_local = '.venv/bin',
--         prefer_local = vim.env.VIRTUAL_ENV .. '/bin',
--         diagnostics_postprocess = function(diagnostic)
--             -- レベルをWARNに変更
--             diagnostic.severity =  vim.diagnostic.severity["WARN"]
--         end,
--     }),
--     null_ls.builtins.formatting.djlint.with({
--         command = 'djlint',
--         -- prefer_local = '.venv/bin',
--         prefer_local = vim.env.VIRTUAL_ENV .. '/bin',
--         diagnostics_postprocess = function(diagnostic)
--             -- レベルをWARNに変更
--             diagnostic.severity =  vim.diagnostic.severity["WARN"]
--         end,
--     }),
--     -- null_ls.builtins.diagnostics.pydocstyle.with({
--     -- }),
--     null_ls.builtins.diagnostics.rstcheck.with({
--     }),
--     -- null_ls.builtins.diagnostics.vulture.with({
--     -- }),
--   }

mason.setup()
-- null_ls.setup({
--     -- debug = true,
--     -- diagnostics_format = '#{m} [#{c}]',
--     -- diagnostics_format = '#{m} (#{s})',
--     diagnostics_format = '#{s}: #{m}',
--     sources = sources,
--     -- root_dir = utils.root_pattern('.venv'),
--     -- root_dir = utils.root_pattern(root_dir),
--     root_dir = utils.root_pattern('.venv')
--     -- on_attach = on_attach
--     -- on_attach = function(_, bufnr)
--     --     vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>ca',
--     --       '<cmd>lua vim.lsp.buf.code_action()<CR>', {noremap = true, silent = true})
-- 
--     --     vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
--     -- end
-- })

mason_null_ls.setup({
    ensure_installed = {
      ---- Formatter
      -- 'isort',
      ---- Linter
      'cspell',
      -- 'flake8',
      -- 'pydocstyle',
      'shellcheck',
      'rstcheck',
      -- 'vulture',
      'yamllint',
      -- 'mypy',
      'sql-formatter',
      ---- Formatter/Linter
      'djlint',
      'markdownlint',
    },
    automatic_installation = false,
    automatic_setup = true,
})

null_ls.setup({
  root_dir = utils.root_pattern('.venv'),
  diagnostics_format = '#{s}: #{m}',
  sources = {
  },
})

mason_null_ls.setup_handlers{
  function(source_name, methods)
    -- all sources with no handler get passed here

    -- To keep the original functionality of `automatic_setup = true`,
    -- please add the below.
    require("mason-null-ls.automatic_setup")(source_name, methods)
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
  djlint = function(source_name, methods)
    null_ls.register(
      null_ls.builtins.formatting.djlint.with({
          command = 'djlint',
          prefer_local = '.venv/bin',
          -- prefer_local = vim.env.VIRTUAL_ENV .. '/bin',
          diagnostics_postprocess = function(diagnostic)
              -- レベルをWARNに変更
              diagnostic.severity =  vim.diagnostic.severity["WARN"]
          end,
      })
    )
  end,
  -- flake8 = function(source_name, methods)
  --   null_ls.register(
  --     null_ls.builtins.diagnostics.flake8.with({
  --         prefer_local = vim.env.VIRTUAL_ENV .. '/bin',
  --         diagnostics_postprocess = function(diagnostic)
  --             -- レベルをWARNに変更
  --             diagnostic.severity =  vim.diagnostic.severity["WARN"]
  --         end,
  --     })
  --   )
  -- end,
  -- isort = function(source_name, methods)
  --   null_ls.register(
  --     null_ls.builtins.formatting.isort.with({
  --         command = 'isort',
  --         timeout = 60000,
  --         -- prefer_local = '.venv/bin',
  --         prefer_local = vim.env.VIRTUAL_ENV .. '/bin',
  --         diagnostics_postprocess = function(diagnostic)
  --             -- レベルをWARNに変更
  --             diagnostic.severity =  vim.diagnostic.severity["WARN"]
  --         end,
  --     })
  --   )
  -- end,
  -- mypy = function(source_name, methods)
  --   null_ls.register(
  --     null_ls.builtins.diagnostics.mypy.with({
  --         disabled_filetypes = { "python" },
  --         prefer_local = vim.env.VIRTUAL_ENV .. '/bin',
  --         -- prefer_local = '.venv/bin',
  --         timeout = 60000,
  --         method = null_ls.methods.DIAGNOSTICS_ON_SAVE,
  --         -- diagnostics_postprocess = function(diagnostic)
  --         --     -- レベルをWARNに変更
  --         --     diagnostic.severity =  vim.diagnostic.severity["WARN"]
  --         -- end,
  --         extra_args = {
  --             -- '--use-fine-grained-cache',
  --             '--cache-dir',
  --             '/dev/null',
  --             -- "--incremental",
  --             -- "--follow-imports",
  --             -- "silent",
  --         }
  --     })
  --   )
  -- end,
}
