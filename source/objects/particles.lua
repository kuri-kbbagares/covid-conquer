Particles = Class{}

function Particles:init()
    self.psystem = love.graphics.newParticleSystem(gTextures['particles'], 64)

    self.psystem:setParticleLifetime(0.5, 1)

    self.psystem:setLinearAcceleration(-15, 15, 15, -15)

    self.psystem:setEmissionArea('normal', 10, 10)
end

function Particles:update(dt)
    self.psystem:update(dt)
end

function Particles:render()
    love.graphics.setColor(106/255, 190/255, 47/255, 255/255)
    love.graphics.draw(self.psystem, self.x, self.y)
end

function Particles:spray(x, y)
    self.psystem:emit(64)

    self.x = x
    self.y = y
end