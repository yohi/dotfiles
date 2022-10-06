local function export_docker_environment()
    print('export docker environment')
    -- print(os.execute('docker compose config --format json | jq ".services.app.environment" > /dev/null'))
        local handle = io.popen('docker compose config --format json | jq ".services.app.environment"')
        -- local handle = io.popen('docker compose config --format json | jq ".services.app.environment" > /dev/null')
        -- print(handle)
        if handle ~= nil then
            local result = handle:read("*a")
            local docker_env = vim.fn.json_decode(result)
            for key, value in pairs(docker_env) do
                vim.fn.setenv(key, value)
            end
        end
    -- end
end
pcall(export_docker_environment)
