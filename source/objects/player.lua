Player = {}

function Player.load()
  Player.x = 50
  Player.y = 50
  Player.width = 20
  Player.height = 20
  Player.ydelt = 0
  Player.xdelt = 0
end

function Player.update(dt)
  --(Bagares)Condition1: X-coord Movement and Border Detect
  if Player.xdelt < 0 then
    Player.x = math.max(0, Player.x + Player.xdelt * dt)    
  else
    Player.x = math.min(WINDOW_WIDTH - Player.width, Player.x + Player.xdelt * dt)
  end
  
  --(Bagares)Condition2:  Y-Coord Movement and Border Detect
  if Player.ydelt < 0 then
    Player.y = math.max(0, Player.y + Player.ydelt * dt)
  else
    Player.y = math.min(WINDOW_HEIGHT - Player.height, Player.y + Player.ydelt * dt)
  end
  
end

function Player.render()
  love.graphics.rectangle('fill', Player.x, Player.y, Player.width, Player.height)
end