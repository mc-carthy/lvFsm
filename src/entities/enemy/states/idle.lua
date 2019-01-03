local IdleState = Class{ __includes = BaseState }

local viewDist = 100
local viewAngle = math.pi / 2
local coneColour = { 0, 0.75, 0, 0.5 }

function IdleState:enter(body)
    self.body = body
    self.body.viewDist = viewDist
    self.body.viewAngle = viewAngle
    self.body.coneColour = coneColour
end

function IdleState:update(dt)
    if self.body:isInViewCone(player) then
        self.body.state:change('alert', self.body)
    end
end

return IdleState