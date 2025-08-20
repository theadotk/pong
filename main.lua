local Paddle = require("src.classes.paddle")
local Ball = require("src.classes.ball")
local Boundary = require("src.classes.boundary")

local font

local centerPosition, scorePositionGap, scoreY

local world, player1, player2, ball, boundary1, boundary2

Score1 = 0
Score2 = 0

function love.load()
    math.randomseed(os.time())
    world = love.physics.newWorld(0, 0)

    local function beginContact(fixtureA, fixtureB)
        local objectA = fixtureA:getUserData()
        local objectB = fixtureB:getUserData()
        if objectA and objectB and objectA.tag and objectB.tag then
            if (objectA.tag == "ball" and objectB.tag == "paddle") or
                (objectB.tag == "ball" and objectA.tag == "paddle") then
                ball:collideWithPaddle()
            elseif (objectA.tag == "ball" and objectB.tag == "boundary") or
                (objectA.tag == "boundary" and objectB.tag == "ball") then
                ball:collideWithBoundary()
            end
        end
    end

    local function endContact(fixtureA, fixtureB)
        local objectA = fixtureA:getUserData()
        local objectB = fixtureB:getUserData()
        if objectA and objectB and objectA.tag and objectB.tag then
            if (objectA.tag == "ball" and objectB.tag == "paddle") or
                (objectB.tag == "ball" and objectA.tag == "paddle") then
                ball:playCollisionWithPaddle()
            elseif (objectA.tag == "ball" and objectB.tag == "boundary") or
                (objectA.tag == "boundary" and objectB.tag == "ball") then
                ball:playCollisionWithBoundary()
            end
        end
    end

    world:setCallbacks(beginContact, endContact)

    player1 = Paddle.new(world, Paddle.width, SCREEN_HEIGHT / 2 - Paddle.height / 2)
    player2 = Paddle.new(world, SCREEN_WIDTH - 2 * Paddle.width, SCREEN_HEIGHT / 2 - Paddle.height / 2)

    ball = Ball.new(world, SCREEN_WIDTH / 2 - Ball.width / 2, SCREEN_HEIGHT / 2 - Ball.height / 2)

    boundary1 = Boundary.new(world, Boundary.width / 2, Boundary.height * 0.75)
    boundary2 = Boundary.new(world, Boundary.width / 2, SCREEN_HEIGHT - Boundary.height)

    font = love.graphics.newFont(24)
    love.graphics.setFont(font)

    centerPosition = SCREEN_WIDTH / 2
    scorePositionGap = 36
    scoreY = 15

    ball:reset()
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
    love.graphics.line(centerPosition + 0.5, 0, centerPosition + 0.5, SCREEN_HEIGHT)
    love.graphics.print(tostring(Score1), centerPosition - scorePositionGap - font:getWidth(tostring(Score1)) / 2, scoreY)
    love.graphics.print(tostring(Score2), centerPosition + scorePositionGap - font:getWidth(tostring(Score2)) / 2, scoreY)
    player1:draw()
    player2:draw()
    ball:draw()
    boundary1:draw()
    boundary2:draw()
end
