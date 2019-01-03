local AlertState = Class{ __includes = BaseState }

local viewDist = 150
local viewAngle = math.pi * 0.75
local coneColour = { 0.75, 0, 0, 0.5 }

function AlertState:enter(body)
    self.body = body
    self.body.viewDist = viewDist
    self.body.viewAngle = viewAngle
    self.body.coneColour = coneColour
end

function AlertState:update(dt)
    if not self.body:isInViewCone(player) then
        self.body.state:change('idle', self.body)
    end
end

return AlertState