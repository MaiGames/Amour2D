local Math = {}

Math.clip = function(value, min, max)

    if value > max then
        return max
    elseif value < min then
        return min
    end

    return value

end

Math.round = function(value)
    return math.floor(value+0.5)
end

Math.hypot = function(x, y)
    return math.sqrt(x^2 + y^2)
end

return Math
