require 'source/Dependencies' --All libraries that are require will be placed here


--Constant Values here vVv

WINDOW_HEIGHT = 720
WINDOW_WIDTH = 840

V_PUSH_HEIGHT = 360
V_PUSH_WIDTH = 480

PLAYER_SPEED = 200

--non constants
click_count = 0

function love.load()
  --Some Object Declaration
  Player = player(V_PUSH_WIDTH/2, V_PUSH_HEIGHT/2, 25, 25)
  Covid = virus(V_PUSH_WIDTH/2, V_PUSH_HEIGHT/2, 10)
  math.randomseed(os.time())
  
  love.window.setTitle('Covid Conquer')
  love.graphics.setDefaultFilter('nearest', 'nearest')
  
  push:setupScreen(V_PUSH_WIDTH, V_PUSH_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
      fullscreen = false,
      resizable = false,
      vsync = true
    }
  )
  
  love.keyboard.keysPressed = {}
end

function love.keypressed(key)
  love.keyboard.keysPressed[key] = true
end

function love.keyboard.wasPressed(key)
  if love.keyboard.keysPressed[key] then
    return true
  else
    return false
  end
end

function love.update(dt)
  if love.keyboard.isDown('a') then
    Player.dx = -PLAYER_SPEED
  elseif love.keyboard.isDown('d') then
    Player.dx = PLAYER_SPEED
  else
    Player.dx = 0
  end
  
  if love.keyboard.isDown('w') then
    Player.dy = -PLAYER_SPEED
  elseif love.keyboard.isDown('s') then
    Player.dy = PLAYER_SPEED
  else
    Player.dy = 0
  end
  
  
  Player:update(dt)


end

function love.draw()
  push:apply('start')

  love.graphics.clear(245/255, 255/255, 255/255, 255/255)
  love.graphics.setColor(0, 0, 0, 1)
  displayClickCount(click_count)
  love.graphics.printf('Covid Conquer ', 0, V_PUSH_HEIGHT/2, V_PUSH_WIDTH)
  
  Player:render()
  if love.keyboard.wasPressed('return') then
    Covid:render()
  end
  push:apply('end')
end



function displayClickCount(click_count)
  --love.graphics.setColor(0, 0, 0, 1)
  love.graphics.printf('Click Count: ' .. tostring(click_count), 10, V_PUSH_HEIGHT-20, V_PUSH_WIDTH)
end


