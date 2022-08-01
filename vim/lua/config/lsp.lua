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


-- local mason_lspconfig = require('mason-lspconfig')
-- 
-- mason_lspconfig.setup({
--     ensure_installed = {
--         'bash-language-server',
--         'cspell',
--         'djlint',
--         'dockerfile-language-server',
--         'dot-language-server',
--         'flake8',
--         'html-lsp',
--         'isort',
--         'json-lsp',
--         'json-to-struct',
--         'lua-language-server',
--         'luacheck',
--         'luaformatter',
--         'markdownlint',
--         'mypy',
--         'pyright',
--         'shellcheck',
--         'sql-formatter',
--         'sqlls',
--         'vim-language-server',
--         'yaml-language-server',
--         'yamllint',
--     },
--     automatic_installation = true,
-- })
-- 
-- local lspconfig = require('lspconfig')
-- mason_lspconfig.setup_handlers({
--     function(server_name)
--         local opts = {}
-- 
--         ---@diagnostic disable: undefined-global
--         if lsp_capabilities ~= nil then
--             opts.capabilities = lsp_capabilities
--         end
--         ---@diagnostic enable: undefined-global
-- 
--         -- serverに対応しているfiletypeのbufferを開いたら、
--         if server_name == 'sumneko_lua' then
--             print('hello world')
--         elseif server_name == 'tsserver' or server_name == 'eslint' then
--             opts.root_dir = lspconfig.util.root_pattern("package.json")
--         elseif server_name == 'denols' then
--             opts.root_dir = lspconfig.util.root_pattern("deno.json", "deno.jsonc", "deps.ts")
--             opts.init_options = { lint = true, unstable = true, }
--         elseif server_name == 'pyright' then
--             print('hello pyright')
--             opts.root_dir = lspconfig.util.root_pattern(".venv")
--         end
-- 
--         -- 実行するfunctionを設定します。
--         -- sumneko_luaはluaのLSP serverなので、
--         -- luaのbufferを開いたら、実行するfunctionです。
--         opts.on_attach = function(client, bufnr)
--             print('hello setup')
--             -- Key Mappings.
--             -- See `:help vim.lsp.*` for documentation on any of the below functions
--             local bufopts = { noremap=true, silent=true, buffer=bufnr }
--             -- vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
--             vim.keymap.set('n', '<F12>', vim.lsp.buf.definition, bufopts)
--             -- vim.keymap.set('n', '<Leader>lk', vim.lsp.buf.hover, bufopts)
--             -- vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
--             -- vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
--             -- vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
--             -- vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
--             -- vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
-- 
--             -- vim.keymap.set('n', '<space>wl', function()
--             --   print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
--             -- end, bufopts)
-- 
--             -- vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
--             -- vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
--             -- vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
--             -- vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
--             -- vim.keymap.set('n', '<space>f', vim.lsp.buf.formatting, bufopts)
--         end
-- 
--         -- LSPのsetupをします。
--         -- setupをしないとserverは動作しません。
--         lspconfig[server_name].setup(opts)
-- 
--         -- vim.diagnostic.open_float()
-- 
--         -- vim.cmd [[ do User LspAttachBuffers ]]
--     end
-- })
-- 
-- print(lspconfig.util.path.join(vim.env.VIRTUAL_ENV, 'bin', 'python'))
-- 














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

local mason = require('mason')
mason.setup({
    ui = {
        icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗"
        }
    }
})

local mason_lspconfig = require('mason-lspconfig')

mason_lspconfig.setup({
    ensure_installed = {
        'bash-language-server',
        'cspell',
        'djlint',
        'dockerfile-language-server',
        'dot-language-server',
        'flake8',
        'html-lsp',
        'isort',
        'json-lsp',
        'json-to-struct',
        'lua-language-server',
        'luacheck',
        'luaformatter',
        'markdownlint',
        'mypy',
        'pyright',
        'shellcheck',
        'sql-formatter',
        'sqlls',
        'vim-language-server',
        'yaml-language-server',
        'yamllint',
    },
    automatic_installation = true,
})

local lspconfig = require('lspconfig')
mason_lspconfig.setup_handlers({
    function(server_name)
        local opts = {}

        ---@diagnostic disable: undefined-global
        if lsp_capabilities ~= nil then
            opts.capabilities = lsp_capabilities
        end
        ---@diagnostic enable: undefined-global

        -- serverに対応しているfiletypeのbufferを開いたら、
        if server_name == 'sumneko_lua' then
            print('hello world')
        elseif server_name == 'tsserver' or server_name == 'eslint' then
            opts.root_dir = lspconfig.util.root_pattern("package.json")
        elseif server_name == 'denols' then
            opts.root_dir = lspconfig.util.root_pattern("deno.json", "deno.jsonc", "deps.ts")
            opts.init_options = { lint = true, unstable = true, }
        elseif server_name == 'pyright' then
            print('hello pyright')
            opts.root_dir = lspconfig.util.root_pattern(".venv")
        end

        -- LSPのsetupをします。
        -- setupをしないとserverは動作しません。
        lspconfig[server_name].setup(opts)

    -- LSPのsetupをします。
    -- setupをしないとserverは動作しません。
    server:setup(opts)

    -- vim.diagnostic.open_float()

local handle_lsp = function(opts)
    return opts
end

lspconfig.pyright.setup(handle_lsp {
    root_dir = lspconfig.util.root_pattern('.venv'),
    settings = {
        python = {
            analysis = {
                -- disableLanguageService = true,
                -- disableOrganizeImports = true,
                -- openFilesOnly = false,
                -- useLibraryCodeForType = false
                autoImportCompletions = true,
                autoSearchPaths = true,
                diagnosticMode = "workspace",
                diagnosticSeverityOverrides = "warning",
                -- extraPaths = '',
                logLevel = 'Information',
                -- stubPath = '',
                typeCheckingMode = 'off',
                -- typeshedPaths = '',
                useLibraryCodeForType = true,
            },
            pythonPath = lspconfig.util.path.join(vim.env.VIRTUAL_ENV, 'bin', 'python'),
            venvPath = '.',
            venv='.venv'
        },
    },
    -- before_init = function(_, config)
    --     config.settings.python.venvPath = lspconfig.util.path.join(vim.env.VIRTUAL_ENV, 'bin', 'python')
    -- end
})
