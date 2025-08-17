local Ball = {
    width = 14,
    height = 14
}

function Ball.new(world, x, y)
    local instance = {}
    instance.x = x
    instance.y = y
    instance.body = love.physics.newBody(world, x, y, "dynamic")
    instance.body:setFixedRotation(true)
    instance.shape = love.physics.newRectangleShape(Ball.width / 2, Ball.height / 2, Ball.width, Ball.height)
    instance.fixture = love.physics.newFixture(instance.body, instance.shape, 1)
    instance.fixture:setRestitution(1)
    instance.fixture:setFriction(0)
    setmetatable(instance, { __index = Ball })
    return instance
end

function Ball:update(dt)
    self.x, self.y = self.body:getPosition()
end

function Ball:draw()
    love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
end

return Ball
