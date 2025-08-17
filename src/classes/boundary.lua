local Boundary = {
    width = SCREEN_WIDTH,
    height = 10
}

function Boundary.new(world, x, y)
    local instance = {}
    instance.x = x
    instance.y = y
    instance.body = love.physics.newBody(world, x, y, "static")
    instance.shape = love.physics.newRectangleShape(Boundary.width / 2, Boundary.height / 2, SCREEN_WIDTH, 10)
    instance.fixture = love.physics.newFixture(instance.body, instance.shape)
    instance.fixture:setFriction(0)
    instance.fixture:setRestitution(1)
    setmetatable(instance, { __index = Boundary })
    return instance
end

function Boundary:draw()
    love.graphics.line(self.x, self.y, self.width, self.y)
end

return Boundary
