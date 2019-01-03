local V = {}

function V.unit(x, y)
    if x == 0 and y == 0 then return x, y end
    local ratio = 1 / math.sqrt(math.pow(x, 2) + math.pow(y, 2))
    return x * ratio, y * ratio
end

function V.distance(a, b)
    assert(a.x ~= nil and a.y ~= nil and b.x ~= nil and b.y ~= nil)
    return math.sqrt(math.pow(a.x - b.x, 2) + math.pow(a.y - b.y, 2))
end

function V.angle(a, b)
    local x1, y1 = a.x, a.y
    local x2, y2 = b.x, b.y
    -- TODO: Verify the inverted y terms
    local ang = -math.atan2(y1 - y2, x2 - x1)

    if ang < 0 then ang = ang + (2 * math.pi) end

    return ang
end

return V