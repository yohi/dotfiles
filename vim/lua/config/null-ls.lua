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

-- cspell --
local cspell_config_dir = '~/.config/cspell'
local cspell_data_dir = '~/.local/share/cspell'

local cspell_files = {
    config = vim.call('expand', cspell_config_dir .. '/cspell.json'),
    dotfiles = vim.call('expand', cspell_config_dir .. '/dotfiles.txt'),
    vim = vim.call('expand', cspell_data_dir .. '/vim.txt.gz'),
    user = vim.call('expand', cspell_data_dir .. '/user.txt'),
}

-- vim辞書がなければダウンロード
if vim.fn.filereadable(cspell_files.vim) ~= 1 then
  local vim_dictionary_url = 'https://github.com/iamcco/coc-spell-checker/raw/master/dicts/vim/vim.txt.gz'
  io.popen('curl -fsSLo ' .. cspell_files.vim .. ' --create-dirs ' .. vim_dictionary_url)
end

-- ユーザー辞書がなければ作成
if vim.fn.filereadable(cspell_files.user) ~= 1 then
  io.popen('mkdir -p ' .. cspell_data_dir)
  io.popen('touch ' .. cspell_files.user)
end


-- null-ls --
local null_ls = require("null-ls")
local null_ls_utils = require("null-ls.utils")
local root_dir = vim.env.PYTHONPATH
-- print(vim.inspect(vim))
local sources = {
    -- debug = true,
    null_ls.builtins.diagnostics.djlint.with({
        --extra_args = { "--config", "./.flake8" },
        prefer_local = root_dir .. ".venv/bin",
        -- extra_args = function(params)
        --     return  {
        --         '--config',
        --         params.root .. '/.djlintrc'
        --     }
        -- end,
    }),
    null_ls.builtins.diagnostics.cspell.with({
        --extra_args = { "--config", "./.flake8" },
        prefer_local = root_dir .. ".venv/bin",
        diagnostics_postprocess = function(diagnostic)
            diagnostic.severity =  vim.diagnostic.severity["INFO"]
        end,
        extra_args = {
            '--config',
            cspell_files.config,
        }
        -- extra_args = function(params)
        --     return  {
        --         '--config',
        --         params.root .. '/.cspell'
        --     }
        -- end,
    }),
    null_ls.builtins.diagnostics.mypy.with({
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
    null_ls.builtins.diagnostics.flake8.with(
        {
            --extra_args = { "--config", "./.flake8" },
            prefer_local = root_dir .. ".venv/bin",
            -- extra_args = function(params)
            --     return  {
            --         '--config',
            --         params.root .. '/.flake8'
            --     }
            -- end,
        }
    ),
    null_ls.builtins.formatting.djhtml.with(
        {
            --extra_args = { "--config", "./.flake8" },
            prefer_local = root_dir .. ".venv/bin",
            -- extra_args = function(params)
            --     return  {
            --         '--config',
            --         params.root .. '/.flake8'
            --     }
            -- end,
        }
    ),
    null_ls.builtins.formatting.djlint.with(
        {
            --extra_args = { "--config", "./.flake8" },
            prefer_local = root_dir .. ".venv/bin",
            -- extra_args = function(params)
            --     return  {
            --         '--config',
            --         params.root .. '/.flake8'
            --     }
            -- end,
        }
    ),
    null_ls.builtins.formatting.isort.with(
        {
            --extra_args = { "--config", "./.flake8" },
            prefer_local = root_dir .. ".venv/bin",
            -- extra_args = function(params)
            --     return  {
            --         '--config',
            --         params.root .. '/.flake8'
            --     }
            -- end,
        }
    ),

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
null_ls.setup({
    debug = true,
    -- diagnostics_format = '#{m} [#{c}]',
    -- diagnostics_format = '#{m} (#{s})',
    diagnostics_format = '#{s}: #{m}',
    sources = sources,
    -- sources = { null_ls.builtins.diagnostics.mypy },
    root_dir = null_ls_utils.root_pattern('.venv'),
    -- on_attach = on_attach
    -- on_attach = function(_, bufnr)
    --     vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>ca',
    --       '<cmd>lua vim.lsp.buf.code_action()<CR>', {noremap = true, silent = true})

    --     vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
    -- end
})
