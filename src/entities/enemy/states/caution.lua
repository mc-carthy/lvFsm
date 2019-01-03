local CautionState = Class{ __includes = BaseState }

local viewDist = 125
local viewAngle = math.pi * 0.75
local coneColour = { 0.75, 0.75, 0, 0.5 }

function CautionState:enter(body)
    self.body = body
    self.body.viewDist = viewDist
    self.body.viewAngle = viewAngle
    self.body.coneColour = coneColour
    self.coolDownAmount = 5
    self.currentCoolDownAmount = self.coolDownAmount
end

function CautionState:update(dt)
    if not self.body:isInViewCone(player) then
        self.currentCoolDownAmount = self.currentCoolDownAmount - dt
        if self.currentCoolDownAmount < 0 then
            self.body.state:change('idle', self.body)
        end
    else
        self.body.state:change('alert', self.body)
    end
end

return CautionState