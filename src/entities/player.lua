local Player = Class()

local speed = 400

function Player:init(params)
    self.x = params.x or 0
    self.y = params.y or 0
end

function Player:update(dt)
    local dx, dy = 0, 0
    if love.keyboard.isDown('up') or love.keyboard.isDown('w') then
        dy = dy - 1
    end
    if love.keyboard.isDown('down') or love.keyboard.isDown('s') then
        dy = dy + 1
    end
    if love.keyboard.isDown('left') or love.keyboard.isDown('a') then
        dx = dx - 1
    end
    if love.keyboard.isDown('right') or love.keyboard.isDown('d') then
        dx = dx + 1
    end

    dx, dy = Vector2.unit(dx, dy)
    self.x, self.y = self.x + dx * speed * dt, self.y + dy * speed * dt
end

function Player:draw()
    love.graphics.setColor(0, 0.75, 0.75, 1)
    love.graphics.circle('fill', self.x, self.y, 10)
    love.graphics.setColor(1, 1, 1, 1)
end

return Player