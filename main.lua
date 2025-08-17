local paddle = require("src.objects.paddle")

local player1, player2

function love.load()
    player1 = paddle.new(paddle.width, SCREEN_HEIGHT / 2 - paddle.height / 2)
    player2 = paddle.new(SCREEN_WIDTH - 2 * paddle.width, SCREEN_HEIGHT / 2 - paddle.height / 2)
end

function love.update(dt)
    player1:update("w", "s", dt)
    player2:update("up", "down", dt)
end

function love.keypressed(key)
    if (key == "escape") then
        love.event.quit()
    end
end

function love.draw()
    player1:draw()
    player2:draw()
end
