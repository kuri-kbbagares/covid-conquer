require 'src/Dependencies' --All libraries that are require will be placed here

--Constant Values here vVv

WINDOW_HEIGHT = 720
WINDOW_WIDTH = 840

VIRTUAL_HEIGHT = 360
VIRTUAL_WIDTH = 480

PLAYER_SPEED = 200

--non constants
click_count = 0

function love.load()
  --Some Object Declaration
  Player = player(VIRTUAL_WIDTH/2, VIRTUAL_HEIGHT/2, 25, 25)
  Covid = virus(VIRTUAL_WIDTH/2, VIRTUAL_HEIGHT/2, 10)
  math.randomseed(os.time())
  
  love.window.setTitle('Covid Conquer')
  love.graphics.setDefaultFilter('nearest', 'nearest')
  
  love.window.setMode(WINDOW_WIDTH, WINDOW_HEIGHT, {
    fullscreen = false,
    vsync = true
  })

  gStateMachine = StateMachine{
    ['pause'] = function () return PauseState() end,
    ['play'] = function () return PlayState() end
  }

  gStateMachine:change('play')

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

  gStateMachine:update(dt)

  Player:update(dt)


end

function love.draw()

  gStateMachine:render()

end

function love.mousepressed(x, y, button)
  menu_button:click(x, y, button)
  
end



function displayClickCount(click_count)
  --love.graphics.setColor(0, 0, 0, 1)
  love.graphics.printf('Click Count: ' .. tostring(click_count), 10, VIRTUAL_HEIGHT-20, VIRTUAL_WIDTH)
end


