Class = require('src/utils/class')
Timer = require('src/utils/timer')
StateMachine = require('src/utils/stateMachine')
BaseState = require('src/utils/baseState')
Vector2 = require('src/utils/vector2')

Player = require('src/entities/player')
Enemy = require('src/entities/enemy/enemy')
IdleState = require('src/entities/enemy/states/idle')
AlertState = require('src/entities/enemy/states/alert')

function love.load()
    player = Player{ x = love.graphics.getWidth() / 2, y = love.graphics.getHeight() / 2 }
    enemies = {}
    for i = 1, 5 do
        table.insert(enemies, Enemy{ x = love.graphics.getWidth() * love.math.random(), y = love.graphics.getHeight() * love.math.random() })
    end
end

function love.update(dt)
    for _, e in pairs(enemies) do
        e:update(dt)
    end
    player:update(dt)
end

function love.draw()
    love.graphics.setBackgroundColor(0.25, 0.25, 0.25)
    for _, e in pairs(enemies) do
        e:drawVisionCone()
    end
    for _, e in pairs(enemies) do
        e:draw()
    end
    player:draw()
end

function love.keypressed(key)
    if key == 'escape' then
        love.event.quit()
    end
end