local paddle = {
    width = 20,
    height = 100,
    acceleration = 5,
    maxSpeed = 300
}

function paddle.new(x, y)
    local instance = {}
    instance.x = x
    instance.y = y
    setmetatable(instance, { __index = paddle })
    return instance
end

function paddle:update(moveUp, moveDown, dt)
    if love.keyboard.isDown(moveUp) then
        self.y = math.max(self.height / 6, self.y - self.maxSpeed * dt)
    elseif love.keyboard.isDown(moveDown) then
        self.y = math.min(SCREEN_HEIGHT - (7 / 6 * self.height), self.y + self.maxSpeed * dt)
    end
end

function paddle:draw()
    love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
end

return paddle
