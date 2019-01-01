Class = require('src/utils/class')
Timer = require('src/utils/timer')
StateMachine = require('src/utils/stateMachine')
Vector2 = require('src/utils/vector2')

Player = require('src/entities/player')

function love.load()
    player = Player{ x = love.graphics.getWidth() / 2, y = love.graphics.getHeight() / 2}
end

function love.update(dt)
    player:update(dt)
end

function love.draw()
    player:draw()
end

function love.keypressed(key)
    if key == 'escape' then
        love.event.quit()
    end
end