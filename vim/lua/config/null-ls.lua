-- null-ls --
local mason = require('mason')
local null_ls = require('null-ls')
local utils = require('lspconfig.util')
local mason_null_ls = require('mason-null-ls')

if vim.env.VIRTUAL_ENV ~= nil then
    vim.fn.setenv('MYPYPATH', vim.env.VIRTUAL_ENV)
end

mason.setup()
mason_null_ls.setup({
    ensure_installed = {
        'stylua',
        'phpcs',
        'phpcsfixer',
        'cspell',
        'djlint',
        'flake8',
        'isort',
        'mypy',
    },
    automatic_installation = true,
    automatic_setup = true,
    handlers = {
        function() end, -- disables automatic setup of all null-ls sources
        shfmt = function(source_name, methods)
          -- custom logic
          require('mason-null-ls').default_setup(source_name, methods) -- to maintain default behavior
        end,
        stylua = function(source_name, methods)
          null_ls.register(null_ls.builtins.formatting.stylua)
        end,
        phpcs = function(source_name, methods)
            -- phpcs
            null_ls.register(
                null_ls.builtins.diagnostics.phpcs.with({
                    method = null_ls.methods.DIAGNOSTICS,
                    args = {
                        '--standard=./phpcs.xml',
                    },
                    diagnostics_postprocess = function(diagnostic)
                        -- レベルをWARNに変更
                        diagnostic.severity = vim.diagnostic.severity['WARN']
                    end,
                })
            )
        end,
        phpcsfixer = function(source_name, methods)
            -- phpcs
            null_ls.register(
                null_ls.builtins.formatting.phpcsfixer.with({
                    args = {
                        '--standard=./phpcs.xml',
                    },
                    diagnostics_postprocess = function(diagnostic)
                        -- レベルをWARNに変更
                        diagnostic.severity =  vim.diagnostic.severity['WARN']
                    end,

                })
            )
        end,
        cspell = function(source_name, methods)
            -- cspell
            null_ls.register(
                null_ls.builtins.diagnostics.cspell.with({
                    diagnostics_postprocess = function(diagnostic)
                        -- レベルをINFOに変更
                        diagnostic.severity = vim.diagnostic.severity['INFO']
                    end,
                    condition = function()
                      -- cpellが実行できるときのみ実行
                      return vim.fn.filereadable('.cspell.json') > 0
                    end,
                })
            )
        end,
        djlint = function(source_name, methods)
            -- djlint
            null_ls.register(
                null_ls.builtins.diagnostics.djlint.with({
                    -- prefer_local = vim.env.VIRTUAL_ENV .. '/bin',  TODO
                    diagnostics_postprocess = function(diagnostic)
                      -- レベルをWARNに変更
                      diagnostic.severity = vim.diagnostic.severity['WARN']
                    end,
                })
            )
        end,
        flake8 = function(source_name, methods)
            -- flake8
            null_ls.register(
                null_ls.builtins.diagnostics.flake8.with({
                    -- prefer_local = vim.env.VIRTUAL_ENV .. '/bin',  TODO
                    diagnostics_postprocess = function(diagnostic)
                        -- レベルをWARNに変更
                        diagnostic.severity = vim.diagnostic.severity['WARN']
                    end,
                })
            )
        end,
        isort = function(source_name, methods)
            -- isort
            null_ls.register(
                null_ls.builtins.formatting.isort.with({
                    -- prefer_local = vim.env.VIRTUAL_ENV .. '/bin',  TODO
                    command = 'isort',
                    timeout = 60000,
                    diagnostics_postprocess = function(diagnostic)
                        -- レベルをWARNに変更
                        diagnostic.severity =  vim.diagnostic.severity['WARN']
                    end,
                })
            )
        end,
        mypy = function(source_name, methods)
            -- mypy
            null_ls.register(
                null_ls.builtins.diagnostics.mypy.with({
                    -- prefer_local = vim.env.VIRTUAL_ENV .. '/bin',  TODO
                    timeout = 60000,
                    method = null_ls.methods.DIAGNOSTICS_ON_SAVE,
                    -- diagnostics_postprocess = function(diagnostic)
                    --     -- レベルをWARNに変更
                    --     diagnostic.severity =  vim.diagnostic.severity['WARN']
                    -- end,
                    extra_args = {
                        -- '--use-fine-grained-cache',
                        '--cache-dir',
                        '/dev/null',
                        -- '--incremental',
                        -- '--follow-imports',
                        -- 'silent',
                    },
                    condition = function()
                        -- TODO 一旦無効に
                        return false
                    end,
                })
            )
        end,
    },
})

null_ls.setup({
    debug = true,
    root_dir = utils.root_pattern('.venv', '.git'),
    diagnostics_format = '#{s}: #{m}',
    on_attach = function(_, bufnr)
        vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>ca',
          '<cmd>lua vim.lsp.buf.code_action()<CR>', {noremap = true, silent = true})
        vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
    end
})
