print 'read lsp.lua'

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
    inlay_hints = {
      enabled = false,
    },
}

vim.diagnostic.config(config)


local function on_cursor_hold()
    -- if vim.lsp.buf.server_ready() then
        vim.diagnostic.open_float()
    -- end
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

vim.api.nvim_create_autocmd({
    "WinScrolled", -- or WinResized on NVIM-v0.9 and higher
    "BufWinEnter",
    "CursorHold",
    "InsertLeave",
    -- include this if you have set `show_modified` to `true`
    "BufModifiedSet",
},
{
    group = vim.api.nvim_create_augroup("barbecue.updater", {}),
    callback = function()
        require("barbecue.ui").update()
    end,
})

vim.api.nvim_create_autocmd(
    {
    'LspAttach',
    },
    {
        group = diagnostic_hover_augroup_name,
        callback = function(args)
            local bufnr = args.buf
            local client = vim.lsp.get_client_by_id(args.data.client_id)
            if client.supports_method("textDocument/inlayHint") then
                vim.lsp.inlay_hint(bufnr, true)
            end
        end,
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
local nvim_navic = require('nvim-navic')
local barbecue = require('barbecue')
-- local ddc_nvim_lsp_setup = require("ddc_nvim_lsp_setup")
-- local root_dir = lspconfig.util.root_pattern('.venv')
-- local python_path = lspconfig.util.path.join(root_dir, '.venv', 'bin', 'python')

-- require("ddc_nvim_lsp_setup").setup()

local bufnr = vim.api.nvim_get_current_buf()
local filepath = vim.api.nvim_buf_get_name(bufnr)
local venv_path = lspconfig.util.root_pattern('.venv')(filepath)
local python_path = nil
if (venv_path == nil) then
    python_path = vim.g.python3_host_prog
else
    python_path = lspconfig.util.path.join(
        venv_path,
        '.venv',
        'bin',
        'python'
    )
end
print('hokkaido consadole sapporo')
print(venv_path)
print(python_path)



-- 1. LSP Sever management
mason.setup({
    -- PATH = 'skip',
    log_level = vim.log.levels.WARN,
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

-- ddc_nvim_lsp_setup.setup()

mason_lspconfig.setup({
    ensure_installed = {
        'pyright',
        'pylsp',
        -- 'mypy',
        -- 'flake8',
        -- 'isort',
        'bashls',
        'dockerls',
        'dotls',
        'html',
        'jsonls',
        -- 'sourcery',
        -- 'sqlls',
        'lua_ls',
        'vimls',
        'yamlls',
        -- 'phpcs',
        'intelephense',
        -- 'sql_formatter',
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
    intelephense = function()
        lspconfig.intelephense.setup {
        }
    end,

    -- sqlls = function()
    --     lspconfig.sqlls.setup {
    --     }
    -- end,

    -- sql_formatter = function()
    --     lspconfig.sql_formatter.setup {
    --     }
    -- end,

    denols = function()
        lspconfig.denols.setup{}
    end,

    pyright = function()
        lspconfig.pyright.setup {
            -- root_dir = venv_dir,
            root_dir = lspconfig.util.root_pattern('.venv'),
            -- https://github.com/microsoft/pyright/blob/main/docs/settings.md
            log_level = vim.log.levels.Trace,
            settings = {
                pyright = {
                    disableLanguageService = false,
                    disableOrganizeImports = false,
                    openFilesOnly = false,
                },
                python = {
                    pythonPath = python_path,
                    venvPath = venv_path,
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
                        extraPaths = {
                        },

                        -- default: Information [Error, Warning, Information, Trace]
                        -- logLevel = 'Warning',
                        logLevel = 'Trace',

                        -- カスタムタイプのstubファイルを含むディレクトリ指定 default: ./typings
                        -- stubPath = '',

                        -- 型チェックの分析レベル default: off [off, basic, strict]
                        typeCheckingMode = 'off',
                        reportMissingImports = 'none',
                        reportMissingModuleSource = 'none',
                        reportUnusedImport = 'none',
                        reportUnusedVariable = 'none',
                        reportUnboundVariable = 'none',
                        reportUndefinedVariable = 'none',
                        reportGeneralTypeIssues = 'none',
                        reportMissingTypeArgument = 'none',
                        reportOptionalSubscript = 'none',
                        reportOptionalMemberAccess = 'none',

                        --
                        -- typeshedPaths = '',

                        -- default: false
                        useLibraryCodeForTypes = true,

                        pylintPath = {
                        },
                    },
                    good_names_rgxs = {'[a-z]{1,3}'},
                },
            }
        }
    end,
    pylsp = function()
        -- local venv_dir = function(fname) return lspconfig.util.root_pattern('.venv')(fname) or nil end
        -- local root_dir = venv_dir == nil and vim.fn.getcwd() or venv_dir
        -- local lspconfig = require('lspconfig')
        -- local root_dir = lspconfig.util.root_pattern('.venv')
        -- local pyton_path = lspconfig.util.path.join(root_dir, '.venv', 'bin', 'python')
        -- print(root_dir)
        -- local python_path = venv_dir == nil and vim.g.python3_host_prog or lspconfig.util.path.join(venv_dir, '.venv', 'bin', 'python')


        -- local lspconfig = require('lspconfig')
        lspconfig.pylsp.setup {
            root_dir = lspconfig.util.root_pattern('.venv'),
            log_level = vim.log.levels.WARN,
            settings = {
                pylsp = {
                    configurationSources = {
                        'flake8'
                    },
                    plugins = {
                        flake8 = {
                            enabled = true,
                            overrides = {
                                '--python-executable', python_path, true,
                            },
                        },
                        pyls_isort = {
                            enabled = true,
                        },
                        pylsp_mypy = {
                            enabled = true,
                            live_mode = false,
                            dmypy = true,
                            report_progress = true,
                            strict = false,
                            overrides = {
                                '--cache-fine-grained',
                                '--cache-dir', '/dev/null',
                                '--python-executable', python_path, true,
                            },
                            config_sub_paths = {
                              -- '/home/y_ohi/docker/scs2/django/project/',
                            }
                        },
                        pycodestyle = {
                            enabled = false,
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
                        pylint = {
                            enabled = false
                        },
                    },
                },
            },
        }
    end,
})

nvim_navic.setup {
    icons = {
        File = ' ',
        Module = ' ',
        Namespace = ' ',
        Package = ' ',
        Class = ' ',
        Method = ' ',
        Property = ' ',
        Field = ' ',
        Constructor = ' ',
        Enum = ' ',
        Interface = ' ',
        Function = ' ',
        Variable = ' ',
        Constant = ' ',
        String = ' ',
        Number = ' ',
        Boolean = ' ',
        Array = ' ',
        Object = ' ',
        Key = ' ',
        Null = ' ',
        EnumMember = ' ',
        Struct = ' ',
        Event = ' ',
        Operator = ' ',
        TypeParameter = ' ',
    },
    lsp = {
      auto_attach = true,
      preference = {
          'pyright',
      },
    },
    highlight = false,
    separator = " > ",
    depth_limit = 9,
    depth_limit_indicator = "..",
    safe_output = true,
    click = false
}
vim.o.winbar = "%{%v:lua.require'nvim-navic'.get_location()%}"

-- triggers CursorHold event faster
vim.opt.updatetime = 200

barbecue.setup({
  create_autocmd = false, -- prevent barbecue from updating itself automatically
  separator = "  ",
  icons_enabled = true,
  icons = {
    default = "",
    symlink = "",
    git = "",
    folder = "",
    ["folder-open"] = "",
  },
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
-- highlight LspReferenceWrite ctermTracerline ctermfg=1 ctermbg=8 gui=underline guifg=#A00000 guibg=#104040
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
