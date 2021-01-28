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
  Player = player(V_PUSH_WIDTH/2, V_PUSH_HEIGHT/2, 25, 25)
  
  math.randomseed(os.time())
  
  love.window.setTitle('Ikuu Zo')
  love.graphics.setDefaultFilter('nearest', 'nearest')
  
  push:setupScreen(V_PUSH_WIDTH, V_PUSH_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
      fullscreen = false,
      resizable = false,
      vsync = true
    }
    )
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
  love.graphics.printf('Nandemonai ', 0, V_PUSH_HEIGHT/2, V_PUSH_WIDTH)
  
  Player:render()
  
  push:apply('end')
end

function displayClickCount(click_count)
  --love.graphics.setColor(0, 0, 0, 1)
  love.graphics.printf('Click Count: ' .. tostring(click_count), 10, V_PUSH_HEIGHT-20, V_PUSH_WIDTH)
end

function love.mousepressed(x, y, button)
  if button == 1 then
    click_count = click_count + 1
  end
end