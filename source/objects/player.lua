Player = {}

function Player.load()
  Player.x = VIRTUAL_WIDTH / 2
  Player.y = VIRTUAL_HEIGHT / 2
  Player.width = 20
  Player.height = 20
  Player.ydelt = 0
  Player.xdelt = 0

  -- [Pandan] - I've come up an idea that we should make a range
  Player.radius = 75
end

function Player.update(dt)
  --(Bagares)Condition1: X-coord Movement and Border Detect
  if Player.xdelt < 0 then
    Player.x = math.max(0, Player.x + Player.xdelt * dt)
  else
    Player.x = math.min(VIRTUAL_WIDTH - Player.width, Player.x + Player.xdelt * dt)
  end
  
  --(Bagares)Condition2:  Y-Coord Movement and Border Detect
  if Player.ydelt < 0 then
    Player.y = math.max(0, Player.y + Player.ydelt * dt)
  else
    Player.y = math.min(VIRTUAL_HEIGHT - Player.height, Player.y + Player.ydelt * dt)
  end

  -- [Pandan] This was supposed to be a code for player leaning on various directions
  

  -- South East
  if Player.xdelt > 0 and Player.ydelt > 0 then
    --(Bagares) Animation Parameters
      frame_angle = 135
      frame = frame + 1
      if frame > num_of_frames then frame = 1 end

  -- North west
  elseif Player.xdelt < 0 and Player.ydelt < 0 then
    --(Bagares) Animation Parameters
      frame_angle = 315
      frame = frame + 1
      if frame > num_of_frames then frame = 1 end
  
  -- South West
  elseif Player.xdelt < 0 and Player.ydelt > 0 then
      --(Bagares) Animation Parameters
      frame_angle = 225
      frame = frame + 1
      if frame > num_of_frames then frame = 1 end

  -- North East
  elseif Player.xdelt > 0 and Player.ydelt < 0 then
      frame_angle = 45
      frame = frame + 1
      if frame > num_of_frames then frame = 1 end
  end
  
end

function Player.render()
  --love.graphics.setColor(0,0,0,1)
  --love.graphics.rectangle('fill', Player.x, Player.y, Player.width, Player.height)
  love.graphics.draw(gTextures['player_atlas'], gQuads['player'][frame], Player.x + 10, Player.y + 5, math.rad(frame_angle), 1, 1, 31, 31)

  love.graphics.setColor(0,0,1,1)
  love.graphics.circle('line', Player.x + (Player.width / 2), Player.y + (Player.height / 2), Player.radius)
end