local Sounds = {}

Sounds.paddleCollision = love.audio.newSource("assets/hit_paddle.wav", "static")
Sounds.boundaryCollision = love.audio.newSource("assets/hit_boundary.wav", "static")
Sounds.scoreUp = love.audio.newSource("assets/score.wav", "static")

return Sounds
