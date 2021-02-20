Player = {}

function Player.load()
  Player.x = 50
  Player.y = 50
  Player.width = 20
  Player.height = 20
  Player.ydelt = 0
  Player.xdelt = 0

  -- [Pandan] - I've come up an idea that we should make a range
  Player.radius = 150
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

  love.graphics.setColor(0,0,1,1)
  love.graphics.circle('line', Player.x + (Player.width / 2), Player.y + (Player.height / 2), Player.radius)
end