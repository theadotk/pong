local paddle = {
    width = 20,
    height = 100,
    acceleration = 1000,
    speed = 0,
    maxSpeed = 350 -- properties
}

function paddle.new(x, y)
    local instance = {}
    instance.x = x
    instance.y = y
    setmetatable(instance, { __index = paddle })
    return instance
end

function paddle:updateSpeed(dt)
    self.speed = math.min(self.maxSpeed, self.speed + self.acceleration * dt)
end

function paddle:update(moveUp, moveDown, dt)
    if love.keyboard.isDown(moveUp) then
        self:updateSpeed(dt)
        self.y = math.max(self.height / 6, self.y - self.speed * dt)
    elseif love.keyboard.isDown(moveDown) then
        self:updateSpeed(dt)
        self.y = math.min(SCREEN_HEIGHT - (7 / 6 * self.height), self.y + self.speed * dt)
    end
end

function paddle:draw()
    love.graphics.rectangle("line", self.x, self.y, self.width, self.height)
end

return paddle
