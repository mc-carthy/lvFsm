local AlertState = Class{ __includes = BaseState }

local speed = 150
local viewDist = 150
local viewAngle = math.pi * 0.9
local coneColour = { 0.75, 0, 0, 0.5 }

function AlertState:enter(body)
    self.body = body
    self.body.speed = speed
    self.body.viewDist = viewDist
    self.body.viewAngle = viewAngle
    self.body.coneColour = coneColour
    self.coolDownAmount = 5
    self.currentCoolDownAmount = self.coolDownAmount
end

function AlertState:update(dt)
    if not self.body:isInViewCone(player) then
        self.currentCoolDownAmount = self.currentCoolDownAmount - dt
        if self.currentCoolDownAmount < 0 then
            self.body.state:change('caution', self.body)
        end
    else
        self.currentCoolDownAmount = self.coolDownAmount
    end
end

return AlertState