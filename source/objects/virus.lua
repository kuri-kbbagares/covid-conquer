virus = Class{}

function virus:init(x, y, radius)
  self.x = x
  self.y = y
  
  self.radius = radius
  self.dx = 0
  self.dy = 0
end
  


function virus:render()
  love.graphics.circle('fill', self.x, self.y, self.radius)
end