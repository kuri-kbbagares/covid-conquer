backDrop = Class{}

backgroundXPos = 0
backgroundYPos = 0
backgroundMovement_SPEED = 100
backgroundXLOOP_POS = 2874


function backDrop:init()
  self.background = love.graphics.newImage('graphics/background.png')

  self.x = backgroundXPos
  self.y = backgroundYPos
  self.dx = backgroundMovement_SPEED
  self.dy = backgroundMovement_SPEED

end

function backDrop:update(dt)
  self.x = (self.x + self.dx * dt) % backgroundXLOOP_POS
  
  
end

function backDrop:render()
  love.graphics.draw(self.background, -self.x, 0)
end
