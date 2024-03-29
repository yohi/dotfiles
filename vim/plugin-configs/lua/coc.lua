-- lua_add {{{

print('read coc.lua')
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

local lspconfig = require('lspconfig')
-- 
-- 
-- -- let g:coc_enable = 0
-- -- vim.g.coc_enable = true
-- 
-- let b:coc_suggest_disable = 1
-- vim.b.coc_suggest_disable = true
-- 
-- -- highlight CocInlayHint ctermbg=NONE ctermfg=250 cterm=italic guibg=NONE guifg=#555555 gui=italic
-- vim.api.nvim_set_hl(0, 'CocInlayHint', {
--     fg = '#555555',
--     bg = nil,
--     italic = true,
--     -- ctermbg = nil,
--     -- ctermfg = 250,
--     -- cterm = 'italic',
--     -- guibg = nil,
--     -- guifg = '#555555',
--     -- gui = 'italic',
-- })
-- 
-- -- vim.api.nvim_create_autocmd('FileType', {
-- --     pattern = 'py',
-- --     callback = function()
-- --         print('coc nvim_create_cmd callback function')
-- --         local root_dir = lspconfig.util.root_pattern('.venv')
-- --         vim.g.coc_user_config['python']['venv'] = '.venv'
-- --         vim.g.coc_user_config['python']['venvPath'] = root_dir
-- --         vim.g.coc_user_config['python']['pythonPath'] = lspconfig.util.path.join(root_dir, '.venv', 'bin', 'python')
-- --     end,
-- -- })
-- vim.g.coc_enable = false
-- vim.g.coc_enabled = false
-- 
-- local group = vim.api.nvim_create_augroup("MyCocToggle", { clear = true })
-- vim.api.nvim_create_autocmd("BufNewFile,BufRead", {
--     group = group,
--     pattern = 'python',
--     callback = function()
--         vim.g.coc_enable = true
--         vim.g.coc_enabled = true
--         vim.b.coc_suggest_disable = true
--     end,
-- })

vim.api.nvim_create_autocmd(
    {
        -- "BufNewFile",
        -- "BufReadPost",
        -- "BufReadPost",
        -- 'FileType',
        'BufEnter',
    },
    {
    pattern = "*",
    callback = function()
        -- print("dump(vim.fn.expand('%:t'))")
        -- print(dump(vim.fn.expand('%:t')))
        -- print('dump(vim.bo.filetype)')
        -- print(dump(vim.bo.filetype))
        -- print("dump(vim.o.filetype)")
        -- print(dump(vim.o.filetype))
        -- -- print("dump(vim.wo.filetype)")
        -- -- print(dump(vim.wo.filetype))
        -- print("dump(vim.bo)")
        -- print(dump(vim.bo))
        local filetype = vim.bo.filetype
        -- ファイルタイプがPythonでない場合
        vim.b.coc_suggest_disable = true
        if filetype == "python" then
            -- メッセージを表示
            -- print("This is a Python file.")
            vim.g.coc_enable = true
            vim.g.coc_enabled = true

            -- local root_dir = lspconfig.util.root_pattern('.venv')
            -- vim.g.coc_user_config['python']['venv'] = '.venv'
            -- vim.g.coc_user_config['python']['venvPath'] = root_dir
            -- vim.g.coc_user_config['python']['pythonPath'] = lspconfig.util.path.join(root_dir, '.venv', 'bin', 'python')
        else
            -- print("This is not a Python file.")
            vim.g.coc_enable = false
            vim.g.coc_enabled = false
        end
    end,
})

-- vim.api.nvim_create_autocmd("BufReadPost", {
--   pattern = "!.py",
--   callback = function()
--     vim.g.coc_enable = false
--     vim.g.coc_enabled = false
--   end,
-- })
-- -- vim.api.nvim_create_autocmd('FileType', {
-- --     pattern = 'python',
-- --     callback = function()
-- --         vim.g.coc_enable = true
-- --     end,
-- -- })
-- -- 
-- -- -- Create a new augroup called fileTypeIndent
-- -- vim.api.nvim_create_augroup('fileTypeIndent', {})
-- -- 
-- -- -- Add autocmds to the augroup
-- -- vim.api.nvim_create_autocmd('BufNewFile,BufRead', '*.yaml', 'setlocal tabstop=2 softtabstop=2 shiftwidth=2', 'fileTypeIndent')
-- -- vim.api.nvim_create_autocmd('BufNewFile,BufRead', '*.yml', 'setlocal tabstop=2 softtabstop=2 shiftwidth=2', 'fileTypeIndent')
-- 
-- 
-- -- callback関数の定義
-- local function MyCallback()
--   -- ファイルタイプを取得
-- end
-- 
-- -- 自動コマンドの作成
-- vim.api.nvim_create_autocmd("BufEnter", {
--   pattern = "*", -- 全てのファイルにマッチするパターン
--   callback = MyCallback, -- 上で定義したcallback関数を指定
-- })


-- }}}
