local Enemy = Class()

local speed = 100

function Enemy:init(params)
    self.x = params.x or 0
    self.y = params.y or 0
    self.rot = love.math.random() * 2 * math.pi
    self.viewDist = 100
    self.viewAngle = math.pi / 2
end

function Enemy:update(dt)
    local dx, dy = math.cos(self.rot), math.sin(self.rot)
    self.x, self.y = self.x + dx * speed * dt, self.y + dy * speed * dt
    self:collisionCheck()
end

function Enemy:draw()
    love.graphics.setColor(0.75, 0, 0, 1)
    love.graphics.circle('fill', self.x, self.y, 10)
    love.graphics.setColor(1, 1, 1, 1)
end

function Enemy:drawVisionCone()
    love.graphics.setColor(0, 0.75, 0, 0.5)
    love.graphics.arc("fill", self.x, self.y, self.viewDist, self.rot + self.viewAngle / 2, self.rot - self.viewAngle / 2)
    love.graphics.setColor(1, 1, 1, 1)
end

function Enemy:collisionCheck()
    if self.x < 0 then
        self.x = 0
        local dx, dy = math.cos(self.rot), math.sin(self.rot)
        self.rot = math.atan2(dy, -dx)
    end
    if self.x > love.graphics.getWidth() then
        self.x = love.graphics.getWidth()
        local dx, dy = math.cos(self.rot), math.sin(self.rot)
        self.rot = math.atan2(dy, -dx)
    end
    if self.y < 0 then
        self.y = 0
        local dx, dy = math.cos(self.rot), math.sin(self.rot)
        self.rot = math.atan2(-dy, dx)
    end
    if self.y > love.graphics.getHeight() then
        self.y = love.graphics.getHeight()
        local dx, dy = math.cos(self.rot), math.sin(self.rot)
        self.rot = math.atan2(-dy, dx)
    end
end

return Enemy