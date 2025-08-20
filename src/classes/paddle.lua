local Paddle = {
    width = 20,
    height = 100,
    acceleration = 1000,
    speed = 0,
    maxSpeed = 700
}

function Paddle.new(world, x, y)
    local instance = {}
    instance.x = x
    instance.y = y
    instance.tag = "paddle"
    instance.body = love.physics.newBody(world, x, y, "kinematic")
    instance.shape = love.physics.newRectangleShape(Paddle.width / 2, Paddle.height / 2, Paddle.width, Paddle.height)
    instance.fixture = love.physics.newFixture(instance.body, instance.shape)
    instance.fixture:setUserData(instance)
    setmetatable(instance, { __index = Paddle })
    return instance
end

function Paddle:updateSpeed(dt)
    self.speed = math.min(self.maxSpeed, self.speed + self.acceleration * dt)
end

function Paddle:update(moveUp, moveDown, dt)
    self.y = self.body:getY()

    local minY = self.height / 6
    local maxY = love.graphics.getHeight() - (7 / 6 * self.height)

    if love.keyboard.isDown(moveUp) then
        if self.y > minY then
            self:updateSpeed(dt)
            self.body:setLinearVelocity(0, -self.speed)
        else
            self.body:setLinearVelocity(0, 0)
        end
    elseif love.keyboard.isDown(moveDown) then
        if self.y < maxY then
            self:updateSpeed(dt)
            self.body:setLinearVelocity(0, self.speed)
        else
            self.body:setLinearVelocity(0, 0)
        end
    end
    self.x, self.y = self.body:getPosition()
end

function Paddle:draw()
    love.graphics.rectangle("line", self.x, self.y, self.width, self.height)
end

return Paddle
