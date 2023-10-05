print('read coc.lua')
-- local lspconfig = require('lspconfig')
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
vim.g.coc_enable = false
-- vim.b.coc_suggest_disable = true

vim.api.nvim_create_autocmd('FileType', {
    pattern = 'python',
    callback = function()
        vim.g.coc_enable = true
        vim.b.coc_suggest_disable = true
    end,
})
