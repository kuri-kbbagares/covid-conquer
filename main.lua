require 'src/Dependencies' --All libraries that are require will be placed here

--Constant Values here vVv

WINDOW_HEIGHT = 720
WINDOW_WIDTH = 840

PLAYER_SPEED = 200

--non constants
click_count = 0

function love.load()
  --Some Object Declaration
  Player.load()
  math.randomseed(os.time())
  
  love.window.setTitle('Covid Conquer')
  love.graphics.setDefaultFilter('nearest', 'nearest')
  
  love.window.setMode(WINDOW_WIDTH, WINDOW_HEIGHT, {
    fullscreen = false,
    vsync = true
  })

  -- Place the source font in here
  playerUp = 'W'
  playerDown = 'S'
  playerLeft = 'A'
  playerRight = 'D'

  gFonts = {
    ['titleFont'] = love.graphics.newFont('fonts/titleFont.ttf', 80),
    ['smallFont'] = love.graphics.newFont('fonts/menuFont.ttf', 10),
    ['mediumFont'] = love.graphics.newFont('fonts/menuFont.ttf', 20),
    ['largeFont'] = love.graphics.newFont('fonts/menuFont.ttf',30)
  }

  gStateMachine = StateMachine{
    ['menu'] = function () return MenuState() end,
    ['options'] = function () return OptionState() end,
    ['play'] = function () return PlayState() end
  }

  gStateMachine:change('menu')

  love.keyboard.keysPressed = {}
  love.mouse.mousepressed = {}
  
  

end

--[[(Bagares)Function1: This are the function/s to initiate a key in keyboard was pressed
]]--
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
  Player.update(dt)
  
end

function love.draw()

  gStateMachine:render()

end

function love.mousepressed(x, y, button)

  gStateMachine:mouse(x, y, button)

end



function displayClickCount(click_count)
  --love.graphics.setColor(0, 0, 0, 1)
  --love.graphics.printf('Click Count: ' .. tostring(click_count), 10, VIRTUAL_HEIGHT-20, VIRTUAL_WIDTH)
end
