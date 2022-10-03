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

local function export_docker_environment()
    print('export docker environment')
        local handle = io.popen('docker compose config --format json | jq ".services.app.environment"')
        if handle ~= nil then
            local result = handle:read("*a")
            local docker_env = vim.fn.json_decode(result)
            for key, value in pairs(docker_env) do
                vim.fn.setenv(key, value)
            end
        end
end
pcall(export_docker_environment)
print(vim.env.VIRTUAL_ENV)

local function install_pip_package(package_name, bin)
    print('install pip package ' .. package_name)
    local bin = bin or false
    local f = io.open(vim.env.VIRTUAL_ENV .. '.venv/bin/' .. package_name)
    if bin and f ~= nil then
        print(vim.g.python3_host_prog .. ' -m pip install --force-reinstall '  .. package_name)
        io.open(vim.g.python3_host_prog .. ' -m pip install --force-reinstall '  .. package_name)
        io.close(f)
    else
        local check = io.open(vim.g.python3_host_prog .. ' -m pip show '  .. package_name) == nil
        if check == nil then
            print(vim.g.python3_host_prog .. ' -m pip install -U  '  .. package_name)
            io.open(vim.g.python3_host_prog .. ' -m pip install -U  '  .. package_name)
        end
    end
end
pcall(install_pip_package, 'pynvim')
pcall(install_pip_package, 'mypy', true)
pcall(install_pip_package, 'flake8', true)
pcall(install_pip_package, 'isort', true)
pcall(install_pip_package, 'djlint', true)


-- null-ls --
local null_ls = require("null-ls")
local utils = require("lspconfig.util")
-- local command_resolver = require("null-ls.helpers.command_resolver")
-- local root_dir = utils.root_pattern('.venv')
local root_dir = utils.root_pattern('.venv')

-- print('vim.fn.getcwd()')
-- print(vim.fn.getcwd())
-- print('root_dir')
-- print(root_dir)

local sources = {
    debug = true,
    -- Diagnostics
    null_ls.builtins.diagnostics.flake8.with({
        prefer_local = vim.env.VIRTUAL_ENV .. '/bin',
        diagnostics_postprocess = function(diagnostic)
            -- レベルをWARNに変更
            diagnostic.severity =  vim.diagnostic.severity["WARN"]
        end,
    }),
    null_ls.builtins.diagnostics.mypy.with({
        prefer_local = vim.env.VIRTUAL_ENV .. '/bin',
        -- prefer_local = '.venv/bin',
        timeout = 60000,
        method = null_ls.methods.DIAGNOSTICS_ON_SAVE,
        -- diagnostics_postprocess = function(diagnostic)
        --     -- レベルをWARNに変更
        --     diagnostic.severity =  vim.diagnostic.severity["WARN"]
        -- end,
        extra_args = {
            "--cache-dir",
            "/dev/null",
        }
    }),
    null_ls.builtins.diagnostics.cspell.with({
        -- extra_args = {
        --     '--config',
        --     '~/.config/cspell/cspell.json',
        -- },
        diagnostics_postprocess = function(diagnostic)
            -- レベルをINFOに変更
            diagnostic.severity =  vim.diagnostic.severity["INFO"]
        end,
        -- condition = function()
        --     -- cpellが実行できるときのみ実行
        --     return vim.fn.executable('cspell') > 0
        -- end,
    }),
    -- Formatting
    null_ls.builtins.formatting.isort.with({
        command = 'isort',
        timeout = 60000,
        -- prefer_local = '.venv/bin',
        prefer_local = vim.env.VIRTUAL_ENV .. '/bin',
        diagnostics_postprocess = function(diagnostic)
            -- レベルをWARNに変更
            diagnostic.severity =  vim.diagnostic.severity["WARN"]
        end,
    }),
    null_ls.builtins.formatting.djlint.with({
        command = 'djlint',
        -- prefer_local = '.venv/bin',
        prefer_local = vim.env.VIRTUAL_ENV .. '/bin',
        diagnostics_postprocess = function(diagnostic)
            -- レベルをWARNに変更
            diagnostic.severity =  vim.diagnostic.severity["WARN"]
        end,
    }),
}

null_ls.setup({
    -- debug = true,
    -- diagnostics_format = '#{m} [#{c}]',
    -- diagnostics_format = '#{m} (#{s})',
    diagnostics_format = '#{s}: #{m}',
    sources = sources,
    -- root_dir = utils.root_pattern('.venv'),
    -- root_dir = utils.root_pattern(root_dir),
    root_dir = utils.root_pattern('.venv')
    -- on_attach = on_attach
    -- on_attach = function(_, bufnr)
    --     vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>ca',
    --       '<cmd>lua vim.lsp.buf.code_action()<CR>', {noremap = true, silent = true})

    --     vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
    -- end
})
