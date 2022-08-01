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
local utils = require("null-ls.utils")
local command_resolver = require("null-ls.helpers.command_resolver")
local root_dir = utils.root_pattern('.venv')

local sources = {
    debug = true,
    -- null_ls.builtins.diagnostics.flake8.with({
    --     prefer_local = '.venv/bin',
    --         --extra_args = { "--config", "./.flake8" },
    --         -- prefer_local = root_dir .. ".venv/bin",
    --         -- extra_args = function(params)
    --         --     return  {
    --         --         '--config',
    --         --         params.root .. '/.flake8'
    --         --     }
    --         -- end,
    -- }),
    null_ls.builtins.diagnostics.mypy.with({
        prefer_local = '.venv/bin',
        --extra_args = { "--config", "./.flake8" },
        prefer_local = root_dir .. ".venv/bin",
        -- filetypes = { '*' },
        -- extra_args = function(params)
        --     return  {
        --         '--config',
        --         params.root .. '/.mypy.ini'
        --     }
        -- end,
    }),
    -- null_ls.builtins.formatting.isort.with({
    --     prefer_local = '.venv/bin',
    --         --extra_args = { "--config", "./.flake8" },
    --         -- prefer_local = root_dir .. ".venv/bin",
    --         -- extra_args = function(params)
    --         --     return  {
    --         --         '--config',
    --         --         params.root .. '/.flake8'
    --         --     }
    --         -- end,
    -- }),
    -- null_ls.builtins.formatting.djhtml.with({
    --     prefer_local = '.venv/bin',
    --         -- extra_args = { "--config", "./.flake8" },
    --         -- prefer_local = root_dir .. ".venv/bin",
    --         -- extra_args = function(params)
    --         --     return  {
    --         --         '--config',
    --         --         params.root .. '/.flake8'
    --         --     }
    --         -- end,
    -- }),
    -- null_ls.builtins.diagnostics.djlint.with({
    --     prefer_local = '.venv/bin',
    --     --extra_args = { "--config", "./.flake8" },
    --     -- prefer_local = root_dir .. ".venv/bin",
    --     -- extra_args = function(params)
    --     --     return  {
    --     --         '--config',
    --     --         params.root .. '/.djlintrc'
    --     --     }
    --     -- end,
    -- }),
    -- null_ls.builtins.diagnostics.cspell.with({
    --     --extra_args = { "--config", "./.flake8" },
    --     -- prefer_local = root_dir .. ".venv/bin",
    --     diagnostics_postprocess = function(diagnostic)
    --         diagnostic.severity =  vim.diagnostic.severity["INFO"]
    --     end,
    --     extra_args = {
    --         '--config',
    --         cspell_files.config,
    --     }
    --     -- extra_args = function(params)
    --     --     return  {
    --     --         '--config',
    --     --         params.root .. '/.cspell'
    --     --     }
    --     -- end,
    -- }),
}

-- print('sources')
-- print(dump(sources))
-- print('========================')
-- for k, v in pairs(sources) do
--     print(k, v)
--     for k1, v1 in pairs(v) do
--         print(k1, v1)
--     end
--     print('========================')
-- end
local root_dir = utils.root_pattern('.venv')
null_ls.setup({
    debug = true,
    -- diagnostics_format = '#{m} [#{c}]',
    -- diagnostics_format = '#{m} (#{s})',
    diagnostics_format = '#{s}: #{m}',
    sources = sources,
    -- sources = { null_ls.builtins.diagnostics.mypy },
    root_dir = utils.root_pattern('.venv'),
    -- on_attach = on_attach
    -- on_attach = function(_, bufnr)
    --     vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>ca',
    --       '<cmd>lua vim.lsp.buf.code_action()<CR>', {noremap = true, silent = true})

    --     vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
    -- end
})
