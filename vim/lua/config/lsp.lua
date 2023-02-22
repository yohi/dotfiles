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

local signs = {
    { name = "DiagnosticSignError", text = "" },
    { name = "DiagnosticSignWarn", text = "" },
    { name = "DiagnosticSignHint", text = "" },
    { name = "DiagnosticSignInfo", text = "" },
}

for _, sign in ipairs(signs) do
    vim.fn.sign_define(
        sign.name,
        {
            texthl = sign.name,
            text = sign.text,
            numhl = "",
        }
    )
end

local config = {
    virtual_text = false,
    signs = {
        active = signs,
    },
    update_in_insert = false,
    underline = true,
    severity_sort = true,
    float = {
        focusable = false,
        style = "minimal",
        source = "always",
        header = "",
        prefix = "",
        border = "rounded",
    },
}

vim.diagnostic.config(config)


local function on_cursor_hold()
    if vim.lsp.buf.server_ready() then
        vim.diagnostic.open_float()
    end
end

local diagnostic_hover_augroup_name = "lspconfig-diagnostic"

vim.api.nvim_set_option('updatetime', 500)

vim.api.nvim_create_augroup(
    diagnostic_hover_augroup_name,
    {
        clear = true,
    }
)

vim.api.nvim_create_autocmd(
    {
        "CursorHold",
    },
    {
        group = diagnostic_hover_augroup_name,
        callback = on_cursor_hold,
    }
)

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
    vim.lsp.handlers.hover, {
        border = "rounded",
    }
)

vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
    border = "rounded",
})

local function lsp_highlight_document(client)
    -- illuminate.on_attach(client)
end

local mason = require('mason')
local mason_lspconfig = require('mason-lspconfig')
local lspconfig = require('lspconfig')
local mason_tool_installer = require('mason-tool-installer')

-- local root_dir = lspconfig.util.root_pattern('.venv')
-- local python_path = lspconfig.util.path.join(root_dir, '.venv', 'bin', 'python')

-- 1. LSP Sever management
mason.setup({
    -- PATH = 'skip',
    log_level = vim.log.levels.DEBUG,
    ui = {
        icons = {
            -- server_installed = "✓",
            -- server_pending = "➜",
            -- server_uninstalled = "✗",
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗",
        }
    }
})

-- mason_tool_installer.setup({
--     ensure_installed = {
--         -- LSP
--         'bash-language-server',
--         'dockerfile-language-server',
--         'dot-language-server',
--         'html-lsp',
--         'json-lsp',
--         'lua-language-server',
--         'pyright',
--         'sqlls',
--         'vim-language-server',
--         'yaml-language-server',
--         'sourcery',
--         -- Formatter
--         'isort',
--         -- Linter
--         'cspell',
--         'flake8',
--         'pydocstyle',
--         'shellcheck',
--         'rstcheck',
--         'vulture',
--         'yamllint',
--         'mypy',
--         'sql-formatter',
--         -- Formatter/Linter
--         'djlint',
--         'markdownlint',
--         -- DAP
--         'debugpy',
--         -- Other
--         'json-to-struct',
--     },
--     auto_update = true,
--     run_on_start = true,
--     start_delay = 0,
-- })
-- 
-- vim.api.nvim_create_autocmd('User', {
--   pattern = 'MasonToolsUpdateCompleted',
--   callback = function()
--     vim.schedule(function()
--       print 'mason-tool-installer has finished'
--     end)
--   end,
-- })

mason_lspconfig.setup({
    ensure_installed = {
        'pyright',
        -- 'pylsp',
        -- 'mypy',
        -- 'flake8',
        -- 'isort',
        -- 'bashls',
        -- 'dockerls',
        -- 'dotls',
        -- 'html',
        -- 'jsonls',
        -- -- 'sourcery',
        -- 'sqlls',
        -- 'lua_ls',
        -- 'vimls',
        -- 'yamlls',
    },
    automatic_installation = false,
})



mason_lspconfig.setup_handlers({
    -- The first entry (without a key) will be the default handler
    -- and will be called for each installed server that doesn't have
    -- a dedicated handler.

    function(server_name)
        lspconfig[server_name].setup({})
    end,

    -- Next, you can provide targeted overrides for specific servers.
    pyright = function()
        lspconfig.pyright.setup {
            root_dir = lspconfig.util.root_pattern('.venv'),
            -- https://github.com/microsoft/pyright/blob/main/docs/settings.md
            log_level = vim.log.levels.ERROR,
            settings = {
                pyright = {
                    disableLanguageService = false,
                    disableOrganizeImports = false,
                },
                python = {
                    pythonPath = lspconfig.util.path.join(root_dir, '.venv', 'bin', 'python'),
                    venvPath = root_dir,
                    venv = '.venv',
                    analysis = {
                        inlayHints = {
                            functionReturnTypes = true,
                            variableTypes = true,
                        },

                        --
                        autoImportCompletions = true,

                        -- 事前定義された名前にもどついて検索パスを自動的に追加するか
                        autoSearchPaths = true,

                        -- [openFilesOnly, workspace]
                        diagnosticMode = "workspace",

                        -- 診断のレベルを上書きする
                        -- https://github.com/microsoft/pylance-release/blob/main/DIAGNOSTIC_SEVERITY_RULES.md
                        diagnosticSeverityOverrides = {
                            reportGeneralTypeIssues = "none",
                            reportMissingTypeArgument = "none",
                            reportUnknownMemberType = "none",
                            reportUnknownVariableType = "none",
                            reportUnknownArgumentType = "none",
                        },

                        -- インポート解決のための追加検索パス指定
                        -- extraPaths = '',

                        -- default: Information [Error, Warning, Information, Trace]
                        logLevel = 'Information',

                        -- カスタムタイプのstubファイルを含むディレクトリ指定 default: ./typings
                        -- stubPath = '',

                        -- 型チェックの分析レベル default: off [off, basic, strict]
                        typeCheckingMode = 'off',

                        --
                        -- typeshedPaths = '',

                        -- default: false
                        useLibraryCodeForTypes = false,
                    },
                }
            }
        }
    end,
    pylsp = function()
        lspconfig.pylsp.setup {
            root_dir = lspconfig.util.root_pattern('.venv'),
            log_level = vim.log.levels.DEBUG,
            settings = {
                pylsp = {
                    configurationSources = {
                        'flake8'
                    },
                    plugins = {
                        flake8 = {
                            enabled = true,
                        },
                        pyls_isort = {
                            enabled = true,
                        },
                        pylsp_mypy = {
                            enabled = true,
                            live_mode = false,
                            dmypy = true,
                            report_progress = false,
                            strict = false,
                            overrides = {
                                -- '--use-fine-grained-cache',
                                -- '--cache-dir',
                                -- '/dev/null',
                                -- '--python-executable',
                                -- '/home/y_ohi/docker/scs2/django/project/.venv/bin/python',
                                -- true,
                                '--cache-dir', '/dev/null',
                                '--python-executable', lspconfig.util.path.join(root_dir, '.venv', 'bin', 'python'), true,
                            },
                            config_sub_paths = {
                              -- '/home/y_ohi/docker/scs2/django/project/',
                            }
                        },
                        pycodestyle = {
                            enabled = true,
                            maxLineLength = 120,
                        },
                        pyflakes = {
                            enabled = false,
                        },
                        autopep8 = {
                            enabled = false,
                        },
                        yapf = {
                            enabled = false,
                        },
                        pylsp_black = {
                            enabled = false,
                        },
                        memestra = {
                            enabled = false,
                        },
                        mccabe = {
                            enabled = false
                        },
                    },
                },
            },
        }
    end,
})

-- mason_lspconfig.setup_handlers({ function(server_name)
--     local navic = require("nvim-navic")
--     local opt = {
--       -- Function executed when the LSP server startup
--       on_attach = function(client, bufnr)
--         navic.attach(client, bufnr)
--       end,
--       --   local opts = { noremap=true, silent=true }
--       --   vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
--       --   vim.cmd 'autocmd BufWritePre * lua vim.lsp.buf.formatting_sync(nil, 1000)'
--       -- end,
--     }
-- 
--     ---@diagnostic disable: undefined-global
--     if lsp_capabilities ~= nil then
--         opts.capabilities = lsp_capabilities
--     end
--     ---@diagnostic enable: undefined-global
-- 
--     -- serverに対応しているfiletypeのbufferを開いたら、
--     if server_name == 'lua_ls' then
--       -- print('hello world')
--     elseif server_name == 'pyright' then
--       -- print('hello pyright')
--       opt.root_dir = lspconfig.util.root_pattern(".venv")
--     elseif server_name == 'pylsp' then
--       -- print('hello pyright')
--       opt.root_dir = lspconfig.util.root_pattern(".venv")
--     end
-- 
--     lspconfig[server_name].setup(opt)
-- end })


-- 2. build-in LSP function
-- keyboard shortcut

-- カーソル下の変数情報表示
vim.keymap.set('n', 'K',  '<cmd>lua vim.lsp.buf.hover()<CR>')

-- 改行やインデントのフォーマティング
vim.keymap.set('n', 'gf', '<cmd>lua vim.lsp.buf.formatting()<CR>')

--
vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>')

--定義ジャンプ
vim.keymap.set('n', '<F12>', '<cmd>lua vim.lsp.buf.definition()<CR>')

-- 
vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.declaration()<CR>')

-- 
vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>')

-- 
vim.keymap.set('n', 'gt', '<cmd>lua vim.lsp.buf.type_definition()<CR>')

-- カーソル下の変数参照元一覧表示
vim.keymap.set('n', 'gn', '<cmd>lua vim.lsp.buf.rename()<CR>')

-- 変数名リネーム
vim.keymap.set('n', 'ga', '<cmd>lua vim.lsp.buf.code_action()<CR>')

-- 
vim.keymap.set('n', 'ge', '<cmd>lua vim.diagnostic.open_float()<CR>')

-- 
vim.keymap.set('n', 'g]', '<cmd>lua vim.diagnostic.goto_next()<CR>')

-- 
vim.keymap.set('n', 'g[', '<cmd>lua vim.diagnostic.goto_prev()<CR>')

-- 3, create user command
-- vim.api.nvim_create_user_command('Formatting', vim.lsp.buf.formatting, {})
vim.api.nvim_create_user_command("Formatting", "lua vim.lsp.buf.format {async = true}", {})



-- vim.lsp.buf.formatting is deprecated. Use vim.lsp.buf.format { async = true } instead


-- Reference highlight
-- vim.cmd [[
-- set updatetime=500
-- highlight LspReferenceText  cterm=underline ctermfg=1 ctermbg=8 gui=underline guifg=#A00000 guibg=#104040
-- highlight LspReferenceRead  cterm=underline ctermfg=1 ctermbg=8 gui=underline guifg=#A00000 guibg=#104040
-- highlight LspReferenceWrite cterm=underline ctermfg=1 ctermbg=8 gui=underline guifg=#A00000 guibg=#104040
-- augroup lsp_document_highlight
--   autocmd!
--   autocmd CursorHold,CursorHoldI * lua vim.lsp.buf.document_highlight()
--   autocmd CursorMoved,CursorMovedI * lua vim.lsp.buf.clear_references()
-- augroup END
-- ]]

local handle_lsp = function(opts)
    return opts
end

-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md

-- lspconfig.pyright.setup(handle_lsp{
--     root_dir = lspconfig.util.root_pattern('.venv'),
--     -- https://github.com/microsoft/pyright/blob/main/docs/settings.md
--     log_level = vim.log.levels.ERROR,
--     settings = {
--         pyright = {
--             disableLanguageService = false,
--             disableOrganizeImports = false,
--         },
--         python = {
--             analysis = {
--                 inlayHints = {
--                     functionReturnTypes = true,
--                     variableTypes = true,
--                 },
-- 
--                 --
--                 autoImportCompletions = true,
-- 
--                 -- 事前定義された名前にもどついて検索パスを自動的に追加するか
--                 autoSearchPaths = true,
-- 
--                 -- [openFilesOnly, workspace]
--                 diagnosticMode = "workspace",
-- 
--                 -- 診断のレベルを上書きする
--                 -- https://github.com/microsoft/pylance-release/blob/main/DIAGNOSTIC_SEVERITY_RULES.md
--                 diagnosticSeverityOverrides = {
--                     reportGeneralTypeIssues = "none",
--                     reportMissingTypeArgument = "none",
--                     reportUnknownMemberType = "none",
--                     reportUnknownVariableType = "none",
--                     reportUnknownArgumentType = "none",
--                 },
-- 
--                 -- インポート解決のための追加検索パス指定
--                 -- extraPaths = '',
-- 
--                 -- default: Information [Error, Warning, Information, Trace]
--                 logLevel = 'Information',
-- 
--                 -- カスタムタイプのstubファイルを含むディレクトリ指定 default: ./typings
--                 -- stubPath = '',
-- 
--                 -- 型チェックの分析レベル default: off [off, basic, strict]
--                 typeCheckingMode = 'off',
-- 
--                 --
--                 -- typeshedPaths = '',
-- 
--                 -- default: false
--                 useLibraryCodeForTypes = false,
--             },
--             pythonPath = lspconfig.util.path.join(vim.env.VIRTUAL_ENV, 'bin', 'python'),
--             venvPath = '.',
--             venv='.venv',
--         }
--     }
-- })
-- 
-- lspconfig.lua_ls.setup{
--     settings = {
--         Lua = {
--             diagnostics = {
--                 globals = {'vim'},
--             }
--         }
--     }
-- }

-- lspconfig.sourcery.setup{
--     init_options = {
--         --- The Sourcery token for authenticating the user.
--         --- This is retrieved from the Sourcery website and must be
--         --- provided by each user. The extension must provide a
--         --- configuration option for the user to provide this value.
--         token = 'user_bhLcgZ_lSulx5RTMLvnQBUvHJyro9QUX3g_jWfHqzxhAY6LJosb78fCJBdw',  -- TODO
-- 
--         --- The extension's name and version as defined by the extension.
--         extension_version = 'vim.lsp',
-- 
--         --- The editor's name and version as defined by the editor.
--         editor_version = 'vim',
--     },
-- }

-- lspconfig.pylsp.setup{
--   root_dir = lspconfig.util.root_pattern('.venv'),
--   -- cmd = {'python3', '-m', 'pylsp'},
--   settings = {
--     pylsp = {
--       plugins = {
--         pylsp_mypy = {
--             enabled = true,
--             live_mode = true,
--             dmypy = false,
--             -- overrides = {
--             --     '--use-fine-grained-cache',
--             --     -- '--cache-dir',
--             --     -- '/dev/null',
--             -- },
--             config_sub_paths = {
--                 '/home/y_ohi/docker/scs2/django/project/',
--             }
--         },
--         autopep8 = { enabled = false },
--         flake8 = { enabled = false },
--         pydocstyle = { enabled = false },
--         pycodestyle = { enabled = false },
--         pyflakes = { enabled = false },
--         pylint = { enabled = false },
--         rope_completion = { enabled = false },
--         rope_rename = { enabled = false },
--         yapf = { enabled = false },
--       }
--     }
--   }
-- }

-- pip install git+https://github.com/python-lsp/python-lsp-server@03c53724654477b8a85eb816275a9ea06b13c7eb
-- pip install git+https://github.com/syphar/python-lsp-server@initialize-progress-token
-- lspconfig.pylsp.setup(handle_lsp{
--     root_dir = lspconfig.util.root_pattern('.venv'),
--     -- cmd = {'python3', '-m', 'pylsp'},
--     -- cmd_env = {
--     --     VIRTUAL_ENV = vim.env,VIRTUAL_ENV,
--     --     PATH = '/home/y_ohi/docker/scs2/django/project/.venv/bin' .. ':' .. vim.env.PATH,
--     -- },
--     log_level = vim.log.levels.DEBUG,
--     settings = {
--       pylsp = {
--         plugins = {
--           pylsp_mypy = {
--               enabled = false,
--               live_mode = true,
--               report_progress = true,
--               dmypy = false,
--               overrides = {
--                 '--python-executable',
--                 '/home/y_ohi/docker/scs2/django/project/.venv/bin/python',
--                 true,
--                 '--cache-dir',
--                 '/dev/null',
--                 -- '--use-fine-grained-cache',
--               },
--               config_sub_paths = {
--                   '/home/y_ohi/docker/scs2/django/project/',
--               },
--           },
--           autopep8 = { enabled = false },
--           flake8 = { enabled = false },
--           pydocstyle = { enabled = false },
--           pycodestyle = { enabled = false },
--           pyflakes = { enabled = false },
--           pylint = { enabled = false },
--           rope_completion = { enabled = false },
--           rope_rename = { enabled = false },
--           yapf = { enabled = false },
--         }
--       }
--     }
-- })
