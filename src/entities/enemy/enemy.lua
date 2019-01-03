local Enemy = Class()

function Enemy:init(params)
    self.x = params.x or 0
    self.y = params.y or 0
    self.speed = 0
    self.rot = love.math.random() * 2 * math.pi
    self.viewDist = 0
    self.viewAngle = 0
    self.coneColour = { 0, 0, 0, 1 }
    self.state = StateMachine {
        ['idle'] = function() return IdleState() end,
        ['caution'] = function() return CautionState() end,
        ['alert'] = function() return AlertState() end,
    }
    self.state:change('idle', self)
    self.timer = Timer.new()
end

function Enemy:update(dt)
    local dx, dy = math.cos(self.rot), math.sin(self.rot)
    self.x, self.y = self.x + dx * self.speed * dt, self.y + dy * self.speed * dt
    self:collisionCheck()
    self.state:update(dt)
end

function Enemy:draw()
    love.graphics.setColor(0.75, 0, 0, 1)
    love.graphics.circle('fill', self.x, self.y, 10)
    love.graphics.setColor(1, 1, 1, 1)
end

function Enemy:drawVisionCone()
    love.graphics.setColor(unpack(self.coneColour))
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

function Enemy:isInViewCone(target)
    if self:isInViewAngle(target) and self:isInViewRange(target) then
        return true
    end
end

function Enemy:isInViewAngle(target)
    local absoluteAngleToTarget = Vector2.angle(self, target)
    local relativeAngleToTarget = (absoluteAngleToTarget - self.rot) % (2 * math.pi)
    if relativeAngleToTarget > math.pi then relativeAngleToTarget = relativeAngleToTarget - (2 * math.pi) end
    relativeAngleToTarget = math.abs(relativeAngleToTarget)

    return relativeAngleToTarget < self.viewAngle / 2
end

function Enemy:isInViewRange(target)
    return Vector2.distance(self, target) < self.viewDist
end

return Enemy