local signs = {
    { name = "DiagnosticSignError", text = "E" },
    { name = "DiagnosticSignWarn", text = "W" },
    { name = "DiagnosticSignHint", text = "H" },
    { name = "DiagnosticSignInfo", text = "I" },
    -- { name = "DiagnosticSignError", text = "" },
    -- { name = "DiagnosticSignWarn", text = "" },
    -- { name = "DiagnosticSignHint", text = "" },
    -- { name = "DiagnosticSignInfo", text = "" },
}

for _, sign in ipairs(signs) do
    vim.fn.sign_define(
        sign.name,
        {
            texthl = sign.name,
            text = sign.text,
            numhl = ""
        }
    )
end

local config = {
    virtual_text = false,
    -- virtual_text = {
    --     prefix: '',
    -- },
    signs = {
        active = signs,
    },
    update_in_insert = true,
    underline = true,
    severity_sort = true,
    float = {
        focusable = false,
        style = "minimal",
        border = "rounded",
        source = "always",
        header = "",
        prefix = "",
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
        -- Use a sharp border with `FloatBorder` highlights
        -- border = "single"
        border = "rounded",
    }
)

vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
    border = "rounded",
})

-- nvim-lsp-installer --
local lsp_installer = require("nvim-lsp-installer")

-- local function _lsp_keymaps(bufnr)
--     local bufopts = {
--         noremap = true,
--         silent = true,
--     }
--     vim.api.nvim_buf_set_keymap(bufnr, "n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", bufopts)
--     vim.api.nvim_buf_set_keymap(bufnr, "n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", bufopts)
--     vim.api.nvim_buf_set_keymap(bufnr, "n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", bufopts)
--     vim.api.nvim_buf_set_keymap(bufnr, "n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", bufopts)
--     vim.api.nvim_buf_set_keymap(bufnr, "n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", bufopts)
--     vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", bufopts)
--     vim.api.nvim_buf_set_keymap(bufnr, "n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", bufopts)
--     vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", bufopts)
--     vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>f", "<cmd>lua vim.diagnostic.open_float()<CR>", bufopts)
--     vim.api.nvim_buf_set_keymap(bufnr, "n", "[d", '<cmd>lua vim.diagnostic.goto_prev({ border = "rounded" })<CR>', bufopts)
--     vim.api.nvim_buf_set_keymap(bufnr, "n", "]d", '<cmd>lua vim.diagnostic.goto_next({ border = "rounded" })<CR>', bufopts)
--     vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>q", "<cmd>lua vim.diagnostic.setloclist()<CR>", bufopts)
--     vim.cmd [[ command! Format execute 'lua vim.lsp.buf.formatting()' ]]
-- end

local function lsp_highlight_document(client)
    -- illuminate.on_attach(client)
end

local function lsp_keymaps(bufnr)
    -- Mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local bufopts = { noremap=true, silent=true, buffer=bufnr }
    -- vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
    vim.keymap.set('n', '<F12>', vim.lsp.buf.definition, bufopts)
    -- vim.keymap.set('n', '<Leader>lk', vim.lsp.buf.hover, bufopts)
    -- vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
    -- vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
    -- vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
    -- vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
    -- vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)

    -- vim.keymap.set('n', '<space>wl', function()
    --   print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    -- end, bufopts)

    -- vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
    -- vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
    -- vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
    -- vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
    -- vim.keymap.set('n', '<space>f', vim.lsp.buf.formatting, bufopts)
end


-- installしているserverの起動準備をします。
-- `server` に格納しているのはServer classで、
-- server nameやsetup functionを含んでいます。
lsp_installer.on_server_ready(function(server)
    local opts = {}

    if server.name == 'sumneko_lua' then
        print('hello world')
    elseif server.name == 'tsserver' or server.name == 'eslint' then
        opts.root_dir = nvim_lsp.util.root_pattern("package.json")
    elseif server.name == 'denols' then
        opts.root_dir = nvim_lsp.util.root_pattern("deno.json", "deno.jsonc", "deps.ts")
        opts.init_options = { lint = true, unstable = true, }
    end

    -- serverに対応しているfiletypeのbufferを開いたら、
    -- 実行するfunctionを設定します。
    -- sumneko_luaはluaのLSP serverなので、
    -- luaのbufferを開いたら、実行するfunctionです。
    opts.on_attach = function(client, bufnr)
        -- print(vim.inspect(client))
        -- print(bufnr)
        lsp_highlight_document(client)
        lsp_keymaps(bufnr)
    end

    -- LSPのsetupをします。
    -- setupをしないとserverは動作しません。
    server:setup(opts)

    -- vim.diagnostic.open_float()

    vim.cmd [[ do User LspAttachBuffers ]]

end)






-- local function lsp_keymaps(bufnr)
--     local opts = {
--         noremap = true,
--         silent = true
--     }
--     vim.api.nvim_buf_set_keymap(bufnr, "n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
--     vim.api.nvim_buf_set_keymap(bufnr, "n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
--     vim.api.nvim_buf_set_keymap(bufnr, "n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
--     vim.api.nvim_buf_set_keymap(bufnr, "n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
--     vim.api.nvim_buf_set_keymap(bufnr, "n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
--     -- vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
--     vim.api.nvim_buf_set_keymap(bufnr, "n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
--     -- vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
--     -- vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>f", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
--     vim.api.nvim_buf_set_keymap(bufnr, "n", "[d", '<cmd>lua vim.diagnostic.goto_prev({ border = "rounded" })<CR>', opts)
--     vim.api.nvim_buf_set_keymap(
--         bufnr,
--         "n",
--         "gl",
--         '<cmd>lua vim.diagnostic.open_float({ border = "rounded" })<CR>',
--         opts
--     )
--     vim.api.nvim_buf_set_keymap(bufnr, "n", "]d", '<cmd>lua vim.diagnostic.goto_next({ border = "rounded" })<CR>', opts)
--     vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>q", "<cmd>lua vim.diagnostic.setloclist()<CR>", opts)
--     vim.cmd [[ command! Format execute 'lua vim.lsp.buf.formatting()' ]]
-- end




-- lspconfig --

local lspconfig = require('lspconfig')

lspconfig.pyright.setup {
    settings = {
        python = {
            analysis = {
                autoImportCompletions = true,
                autoSearchPaths = true,
                diagnosticMode = "workspace",
                diagnosticSeverityOverrides = "none",
                -- extraPaths = '',
                logLevel = 'Information',
                -- stubPath = '',
                typeCheckingMode = 'off',
                -- typeshedPaths = '',
                useLibraryCodeForType = true,
            }
        },
    },
}
