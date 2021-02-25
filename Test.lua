list = {['menu'] = {x = 3, y = 2}, {x = 4, y = 5}, {x = 3, y = 4, z = 5}}




for x, y in ipairs(list) do
    print(x, y.x, y.y, y.z)
end

