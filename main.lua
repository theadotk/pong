local Paddle = require("src.classes.paddle")
local Ball = require("src.classes.ball")
local Boundary = require("src.classes.boundary")

local world, player1, player2, ball, boundary1, boundary2

function love.load()
    math.randomseed(os.time())
    world = love.physics.newWorld(0, 0)
    player1 = Paddle.new(world, Paddle.width, SCREEN_HEIGHT / 2 - Paddle.height / 2)
    player2 = Paddle.new(world, SCREEN_WIDTH - 2 * Paddle.width, SCREEN_HEIGHT / 2 - Paddle.height / 2)
    ball = Ball.new(world, SCREEN_WIDTH / 2 - Ball.width / 2, SCREEN_HEIGHT / 2 - Ball.height / 2)
    boundary1 = Boundary.new(world, Boundary.width / 2, Boundary.height * 0.75)
    boundary2 = Boundary.new(world, Boundary.width / 2, SCREEN_HEIGHT - Boundary.height)
    local xDirection = math.random(2) == 1 and 1 or -1
    local yDirection = math.random(2) == 1 and 1 or -1
    ball.body:setLinearVelocity(xDirection * math.random(200, 250), yDirection * math.random(15, 50))
end

function love.update(dt)
    world:update(dt)
    player1:update("w", "s", dt)
    player2:update("up", "down", dt)
    ball:update(dt)
end

function love.keypressed(key)
    if (key == "escape") then
        love.event.quit()
    end
end

function love.keyreleased(key)
    if (key == "w") or (key == "s") then
        player1.speed = 0
        player1.body:setLinearVelocity(0, 0)
    elseif (key == "up") or (key == "down") then
        player2.speed = 0
        player2.body:setLinearVelocity(0, 0)
    end
end

function love.draw()
    love.graphics.clear(10 / 255, 10 / 255, 15 / 255, 255 / 255)
    love.graphics.line(SCREEN_WIDTH / 2, 0, SCREEN_WIDTH / 2, SCREEN_HEIGHT)
    player1:draw()
    player2:draw()
    ball:draw()
    boundary1:draw()
    boundary2:draw()
end
