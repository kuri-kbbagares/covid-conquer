player = Class{}

function player:init(x, y, width, height)
  self.x = x
  self.y = y
  self.width = width
  self.height = height
  self.dy = 0
  self.dx = 0
end

function player:update(dt)
  --X-coord Movement and Border Detect
  if self.dx < 0 then
    self.x = math.max(0, self.x + self.dx * dt)    
  else
    self.x = math.min(V_PUSH_WIDTH - self.width, self.x + self.dx * dt)
  end
  
  -- Y-Coord Movement and Border Detect
  if self.dy < 0 then
    self.y = math.max(0, self.y + self.dy * dt)
  else
    self.y = math.min(V_PUSH_HEIGHT - self.height, self.y + self.dy * dt)
  end
  
end

function player:render()
  love.graphics.rectangle('fill', self.x, self.y, self.width, self.height)
end