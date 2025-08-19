local Sounds = {}

Sounds.paddleCollision = love.audio.newSource("assets/Paddle.wav", "static")
Sounds.boundaryCollision = love.audio.newSource("assets/Boundary.wav", "static")

return Sounds
