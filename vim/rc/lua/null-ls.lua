-- null-ls --
local null_ls = require("null-ls")
-- print(vim.inspect(vim))
local sources = {
    debug = true,
    null_ls.builtins.diagnostics.djlint.with({
        --extra_args = { "--config", "./.flake8" },
        extra_args = function(params)
            return  {
                '--config',
                params.root .. '/django/project/.djlintrc'
            }
        end,

    }),
    null_ls.builtins.diagnostics.cspell.with({
        --extra_args = { "--config", "./.flake8" },
        extra_args = function(params)
            return  {
                '--config',
                params.root .. '/django/project/.cspell'
            }
        end,

    }),
    null_ls.builtins.diagnostics.mypy.with({
        --extra_args = { "--config", "./.flake8" },
        extra_args = function(params)
            return  {
                '--config',
                params.root .. '/django/project/.mypy.ini'
            }
        end,

    }),
    null_ls.builtins.diagnostics.flake8.with(
        {
            --extra_args = { "--config", "./.flake8" },
            extra_args = function(params)
                return  {
                    '--config',
                    params.root .. '/django/project/.flake8'
                }
            end,
        }
    ),
}

null_ls.setup({
    -- diagnostics_format = '#{m} [#{c}]',
    -- diagnostics_format = '#{m} (#{s})',
    diagnostics_format = '#{s}: #{m}',
    sources = sources,
    -- on_attach = on_attach
})
