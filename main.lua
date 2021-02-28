require 'src/Dependencies' --All libraries that are require will be placed here


function love.load(arg)
  --Some Object Declaration
  math.randomseed(os.time())

  love.window.setTitle('Covid Conquer')
  love.graphics.setDefaultFilter('nearest', 'nearest')

  push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
    fullscreen = false,
    vsync = false
  })

  -- [Pandan] For Editing the Key Movements
  playerUpOpen, playerDownOpen, playerLeftOpen, playerRightOpen = false, false, false, false
  playerUp = 'W'
  playerDown = 'S'
  playerLeft = 'A'
  playerRight = 'D'

  gFonts = {
    ['titleFont'] = love.graphics.newFont('fonts/titleFont.ttf', 80),
    ['medium_titleFont'] = love.graphics.newFont('fonts/titleFont.ttf', 50),
    ['smallFont'] = love.graphics.newFont('fonts/menuFont.ttf', 10),
    ['mediumFont'] = love.graphics.newFont('fonts/menuFont.ttf', 15),
    ['largeFont'] = love.graphics.newFont('fonts/menuFont.ttf',30),
    ['large1Font'] = love.graphics.newFont('fonts/menuFont.ttf',50)
  }


  gTextures = {
    ['virus'] = love.graphics.newImage('graphics/veerus.png'),
    ['player_atlas'] = love.graphics.newImage('graphics/player_atlas.png'),
    ['particles'] = love.graphics.newImage('graphics/particle.png'),
  }
  
  gQuads = {
    ['player'] = GenerateQuads(gTextures['player_atlas'], 64, 64)
  }
  
  gSounds = {
    --Constantly Playing
    ['bgm'] = love.audio.newSource('sounds/bgm.wav', 'stream'),
    --Played On-trigger
    ['click'] = love.audio.newSource('sounds/click.wav', 'static'),
    ['on-death'] = love.audio.newSource('sounds/gameover.wav', 'static'),
  }
  
  gSounds['bgm']:setLooping(true) 
  gSounds['on-death']:setLooping(false)
  
  gSounds['bgm']:play()

  gStateMachine = StateMachine{
    ['title'] = function () return TitleState() end,
    ['options'] = function () return OptionState() end,
    ['play'] = function () return PlayState() end
  }
  
  background = backDrop()
  gStateMachine:change('title')
  Player.load()

  love.keyboard.keysPressed = {}

end

--[[(Bagares)Function1: This are the function/s to initiate a key in keyboard was pressed
]]--
function love.keypressed(key)
  love.keyboard.keysPressed[key] = true
  KeyBindings(key)
end

function love.keyboard.wasPressed(key)
  return love.keyboard.keysPressed[key]
end

function love.update(dt)
  gStateMachine:update(dt)
  background:update(dt)
  Player.update(dt)

  love.keyboard.keysPressed = {}
end

function love.draw()
  push:apply("start")
  background:render()
  gStateMachine:render()

  push:apply("end")

end

function love.mousepressed(x, y, button)
  x, y = push:toGame(x, y)

  gStateMachine:mouse(x, y, button)
end

function displayClickCount(click_count)
  --love.graphics.setColor(0, 0, 0, 1)
  --love.graphics.printf('Click Count: ' .. tostring(click_count), 10, VIRTUAL_HEIGHT-20, VIRTUAL_WIDTH)
end

function KeyBindings(key)
  if key ~= nil then
      if playerUpOpen == true then
          playerUp = string.upper(key)
          playerUpOpen = false

      elseif playerDownOpen == true then
          playerDown = string.upper(key)
          playerDownOpen = false

      elseif playerLeftOpen == true then
          playerLeft = string.upper(key)
          playerLeftOpen = false

      elseif playerRightOpen == true then
          playerRight = string.upper(key)
          playerRightOpen = false
      end
  end
end
