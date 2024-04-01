local cache_dir = vim.fn.expand('~/.cache/')
local dpp_base = cache_dir .. 'dpp/'
local repo_dir = dpp_base .. 'repos/'

local dpp_repo = 'github.com/Shougo/dpp.vim'
local denops_repo = 'github.com/vim-denops/denops.vim'

if vim.fn.isdirectory(cache_dir) == 0 then
    vim.fn.mkdir(cache_dir)
end

function init_plugin(plugin, prepend)
    print(plugin)
    local dir = repo_dir .. plugin
    if vim.fn.isdirectory(dir) == 0 then
        vim.fn.execute('!git clone https://' .. plugin .. ' ' .. dir)
    end
    if prepend then
        vim.opt.runtimepath:prepend(dir)
    else
        vim.opt.runtimepath:append(dir)
    end
end

-- if vim.opt.runtimepath:find(repo_dir .. dpp_repo) == nil then
--     -- dpp.vimのインストール
--     init_plugin(dpp_repo)
-- end

-- dpp.vimのインストール
init_plugin(dpp_repo, true)
print('we are sapporo')

local dpp = require('dpp')
print('j1 servive')
print('consadole sapporo')
local plugins = {
    -- 'github.com/vim-denops/denops.vim',
    'github.com/Shougo/dpp-ext-installer',
    'github.com/Shougo/dpp-ext-toml',
    'github.com/Shougo/dpp-ext-lazy',
    'github.com/Shougo/dpp-protocol-git',
    'github.com/Shougo/dpp-ext-installer',
}
for i, plugin in next, plugins do
    init_plugin(plugin, false)
end


if dpp.load_state(dpp_base) then
    print('consadole sapporo')
    -- local plugins = {
    --     'github.com/vim-denops/denops.vim',
    --     'github.com/Shougo/dpp-ext-installer',
    --     'github.com/Shougo/dpp-ext-toml',
    --     'github.com/Shougo/dpp-ext-lazy',
    --     'github.com/Shougo/dpp-protocol-git',
    --     'github.com/Shougo/dpp-ext-installer',
    -- }
    -- for i, plugin in next, plugins do
    --     init_plugin(plugin)
    -- end
    init_plugin(denops_repo, true)

    vim.api.nvim_create_autocmd('User', {
        pattern = 'DenopsReady',
        callback = function()
            vim.notify('dpp load_state() is failed')
            dpp.make_state(dpp_base, '~/dotfiles/vim/rc/dpp.ts')
        end,
    })
end

vim.api.nvim_create_autocmd('User', {
    pattern = 'Dpp:makeStatePost',
    callback = function()
        vim.notify('dpp make_state() is done')
    end,
})

vim.cmd('filetype indent plugin on')
vim.cmd('syntax on')
