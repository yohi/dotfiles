-- lua_add {{{

local plenary_async = require('plenary.async')

local read_file = function(path)
    local err, fd = plenary_async.uv.fs_open(path, "r", 438)
    assert(not err, err)

    local err, stat = plenary_async.uv.fs_fstat(fd)
    assert(not err, err)

    local err, data = plenary_async.uv.fs_read(fd, stat.size, 0)
    assert(not err, err)

    local err = plenary_async.uv.fs_close(fd)
    assert(not err, err)

    return data
end

-- }}}
