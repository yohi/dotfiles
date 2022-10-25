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


-- 1. LSP Sever management
mason.setup()

mason_lspconfig.setup({
    -- ensure_installed = {
    --     'bash-language-server',
    --     'cspell',
    --     'djlint',
    --     'dockerfile-language-server',
    --     'dot-language-server',
    --     'flake8',
    --     'html-lsp',
    --     'isort',
    --     'json-lsp',
    --     'json-to-struct',
    --     'lua-language-server',
    --     'markdownlint',
    --     'mypy',
    --     'pyright',
    --     'shellcheck',
    --     'sql-formatter',
    --     'sqlls',
    --     'vim-language-server',
    --     'yaml-language-server',
    --     'yamllint',
    -- },
    automatic_installation = false,
})

mason_lspconfig.setup_handlers({ function(server_name)
    local navic = require("nvim-navic")
    local opt = {
      -- Function executed when the LSP server startup
      on_attach = function(client, bufnr)
        navic.attach(client, bufnr)
      end,
      --   local opts = { noremap=true, silent=true }
      --   vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
      --   vim.cmd 'autocmd BufWritePre * lua vim.lsp.buf.formatting_sync(nil, 1000)'
      -- end,
    }

    ---@diagnostic disable: undefined-global
    if lsp_capabilities ~= nil then
        opts.capabilities = lsp_capabilities
    end
    ---@diagnostic enable: undefined-global

    -- serverに対応しているfiletypeのbufferを開いたら、
    if server_name == 'sumneko_lua' then
      -- print('hello world')
    elseif server_name == 'pyright' then
      -- print('hello pyright')
      opt.root_dir = lspconfig.util.root_pattern(".venv")
    end

    lspconfig[server_name].setup(opt)
end })


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


lspconfig.pyright.setup(handle_lsp{
    root_dir = lspconfig.util.root_pattern('.venv'),
    -- https://github.com/microsoft/pyright/blob/main/docs/settings.md
    settings = {
        pyright = {
            -- disableLanguageService = true,
            -- disableOrganizeImports = true,
        },
        python = {
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
            pythonPath = lspconfig.util.path.join(vim.env.VIRTUAL_ENV, 'bin', 'python'),
            venvPath = '.',
            venv='.venv',
        }
    }
})

lspconfig.sumneko_lua.setup{
    settings = {
        Lua = {
            diagnostics = {
                globals = {'vim'},
            }
        }
    }
}
