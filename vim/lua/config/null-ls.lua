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
local null_ls = require("null-ls")
local utils = require("lspconfig.util")
-- local command_resolver = require("null-ls.helpers.command_resolver")
-- local root_dir = utils.root_pattern('.venv')
local root_dir = utils.root_pattern('.venv')

-- print('vim.fn.getcwd()')
-- print(vim.fn.getcwd())
-- print('root_dir')
-- print(root_dir)

local sources = {
    debug = true,
    -- Diagnostics
    -- null_ls.builtins.diagnostics.flake8.with({
    --     command = 'python3 -m flake8',
    --     prefer_local = '.venv/bin',
    --     -- diagnostics_postprocess = function(diagnostic)
    --     --     -- レベルをWARNに変更
    --     --     diagnostic.severity =  vim.diagnostic.severity["WARN"]
    --     -- end,
    -- }),
    null_ls.builtins.diagnostics.mypy.with({
        prefer_local = '.venv/bin',
        -- command = '.venv/bin/mypy',
        -- method = null_ls.methods.DIAGNOSTICS_ON_SAVE,
        -- diagnostics_postprocess = function(diagnostic)
        --     -- レベルをWARNに変更
        --     diagnostic.severity =  vim.diagnostic.severity["WARN"]
        -- end,
        -- cwd = function(params)
        --     -- falls back to root if return value is nil
        --     print(params.root)
        --     print(dump(params))
        --     return params.root
        -- end,
        --cwd = root_dir,
        -- runtime_condition = function(params)
        --     print(params.root)
        --     print(dump(params))
        --     return params.root:match("my-monorepo-subdir") ~= nil
        -- end,
        -- condition = function(params)
        --     print(dump(params))
        --     params.root_has_file({'.venv'})
        --     return params.root_has_file({ ".venv" })
        -- end,
        -- extra_args = {
        --     "--cache-dir",
        --     "/dev/null",
        -- }
    }),
    -- null_ls.builtins.diagnostics.cspell.with({
    --     -- extra_args = {
    --     --     '--config',
    --     --     '~/.config/cspell/cspell.json',
    --     -- },
    --     diagnostics_postprocess = function(diagnostic)
    --         -- レベルをINFOに変更
    --         diagnostic.severity =  vim.diagnostic.severity["INFO"]
    --     end,
    --     -- condition = function()
    --     --     -- cpellが実行できるときのみ実行
    --     --     return vim.fn.executable('cspell') > 0
    --     -- end,
    -- }),
    -- Formatting
    null_ls.builtins.formatting.isort.with({
        command = 'python3 -m isort',
        prefer_local = '.venv/bin',
        -- diagnostics_postprocess = function(diagnostic)
        --     -- レベルをWARNに変更
        --     diagnostic.severity =  vim.diagnostic.severity["WARN"]
        -- end,
    }),
    null_ls.builtins.formatting.djlint.with({
        command = 'python3 -m djlint',
        prefer_local = '.venv/bin',
        -- diagnostics_postprocess = function(diagnostic)
        --     -- レベルをWARNに変更
        --     diagnostic.severity =  vim.diagnostic.severity["WARN"]
        -- end,
    }),
}

null_ls.setup({
    debug = true,
    -- diagnostics_format = '#{m} [#{c}]',
    -- diagnostics_format = '#{m} (#{s})',
    diagnostics_format = '#{s}: #{m}',
    sources = sources,
    -- root_dir = utils.root_pattern('.venv'),
    -- root_dir = utils.root_pattern(root_dir),
    root_dir = utils.root_pattern('.venv')
    -- on_attach = on_attach
    -- on_attach = function(_, bufnr)
    --     vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>ca',
    --       '<cmd>lua vim.lsp.buf.code_action()<CR>', {noremap = true, silent = true})

    --     vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
    -- end
})
