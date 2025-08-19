local Boundary = {
    width = SCREEN_WIDTH,
    height = 5
}

function Boundary.new(world, x, y)
    local instance = {}
    instance.x = x
    instance.y = y
    instance.tag = "boundary"
    instance.body = love.physics.newBody(world, x, y, "static")
    instance.body:setFixedRotation(true)
    instance.shape = love.physics.newRectangleShape(Boundary.width, Boundary.height)
    instance.fixture = love.physics.newFixture(instance.body, instance.shape)
    instance.fixture:setFriction(0)
    instance.fixture:setRestitution(1)
    instance.fixture:setUserData(instance)
    setmetatable(instance, { __index = Boundary })
    return instance
end

function Boundary:draw()
    love.graphics.line(0, self.y, SCREEN_WIDTH, self.y)
end

return Boundary
