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
        extra_args = function(params)
            return  {
                '--config',
                params.root .. '/.djlintrc'
            }
        end,

    }),
    null_ls.builtins.diagnostics.cspell.with({
        --extra_args = { "--config", "./.flake8" },
        prefer_local = root_dir .. ".venv/bin",
        extra_args = function(params)
            return  {
                '--config',
                params.root .. '/.cspell'
            }
        end,

    }),
    null_ls.builtins.diagnostics.mypy.with({
        --extra_args = { "--config", "./.flake8" },
        prefer_local = root_dir .. ".venv/bin",
        filetypes = { '*' },
        extra_args = function(params)
            return  {
                '--config',
                params.root .. '/.mypy.ini'
            }
        end,

    }),
    null_ls.builtins.diagnostics.flake8.with(
        {
            --extra_args = { "--config", "./.flake8" },
            prefer_local = root_dir .. ".venv/bin",
            extra_args = function(params)
                return  {
                    '--config',
                    params.root .. '/.flake8'
                }
            end,
        }
    ),
}

null_ls.setup({
    debug = true,
    -- diagnostics_format = '#{m} [#{c}]',
    -- diagnostics_format = '#{m} (#{s})',
    diagnostics_format = '#{s}: #{m}',
    sources = sources,
    root_dir = null_ls_utils.root_pattern('.venv'),
    -- on_attach = on_attach
})
