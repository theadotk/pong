local Sounds = require("src.sfx")

local Ball = {
    width = 14,
    height = 14
}

function Ball.new(world, x, y)
    local instance = {}
    instance.x = x
    instance.y = y
    instance.tag = "ball"
    instance.body = love.physics.newBody(world, x, y, "dynamic")
    instance.body:setFixedRotation(true)
    instance.shape = love.physics.newRectangleShape(Ball.width / 2, Ball.height / 2, Ball.width, Ball.height)
    instance.fixture = love.physics.newFixture(instance.body, instance.shape, 1)
    instance.fixture:setRestitution(1)
    instance.fixture:setFriction(0)
    instance.fixture:setUserData(instance)
    setmetatable(instance, { __index = Ball })
    return instance
end

function Ball:collideWithPaddle()
    local xSpeed, ySpeed = self.body:getLinearVelocity()
    xSpeed = xSpeed * 1.1
    ySpeed = math.random(15, 120)
    local yDirection = math.random(2) == 1 and 1 or -1
    self.body:setLinearVelocity(-xSpeed, yDirection * ySpeed)
end

function Ball:collideWithBoundary()
    local xSpeed, ySpeed = self.body:getLinearVelocity()
    self.body:setLinearVelocity(xSpeed, -ySpeed)
end

function Ball:playCollisionWithPaddle()
    Sounds.paddleCollision:play()
end

function Ball:playCollisionWithBoundary()
    Sounds.boundaryCollision:play()
end

function Ball:update(dt)
    self.x, self.y = self.body:getPosition()
end

function Ball:draw()
    love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
end

return Ball
