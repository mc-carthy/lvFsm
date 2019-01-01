local V = {}

function V.unit(x, y)
    if x == 0 and y == 0 then return x, y end
    local ratio = 1 / math.sqrt(math.pow(x, 2) + math.pow(y, 2))
    return x * ratio, y * ratio
end

return V