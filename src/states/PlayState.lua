PlayState = Class{__includes = BaseState}

--(BAGARES) variables needed to change animation
frame = 1
num_of_frames = 8
frame_angle = 0

function PlayState:init()
  MENU_PLAY = true
  MENU = false
  SPAWN = false

  self.cursor = love.mouse.getSystemCursor("crosshair")
  self.clickScript = {
    ['option'] = {x = VIRTUAL_WIDTH * 0.02,
                  y = VIRTUAL_HEIGHT * 0.02,
                  width = 20,
                  height = 20,

                  script = function() MENU = true end},

                -- Option Buttons 1 (Resume), 2 (Options), 3 (Exit), 4 (Retry), 5 (Exit)
                {x = VIRTUAL_WIDTH * 0.45,
                 y = VIRTUAL_HEIGHT * 0.4,
                 width = 85,
                 height = 30,
                 textcolor = {1,1,1,1},

                 script = function() MENU = false end},

                {x = VIRTUAL_WIDTH * 0.45,
                y = VIRTUAL_HEIGHT * 0.5,
                width = 85,
                height = 30,
                textcolor = {1,1,1,1},

                script = function() gStateMachine:change('options') end},
         
                {x = VIRTUAL_WIDTH * 0.45,
                 y = VIRTUAL_HEIGHT * 0.6,
                 width = 85,
                 height = 30,
                 textcolor = {1,1,1,1},

                 script = function() 
                    MENU_PLAY = false
                    gStateMachine:change('menu') 
                  end
                },

                {x = VIRTUAL_WIDTH * 0.26,
                 y = VIRTUAL_HEIGHT * 0.7,
                 width = 70,
                 height = 30,
                 textcolor = {1,1,1,1},

                 script = function()
                    SPAWN = false
                    reset()
                 end},

                {x = VIRTUAL_WIDTH * 0.65,
                y = VIRTUAL_HEIGHT * 0.7,
                width = 70,
                height = 30,
                textcolor = {1,1,1,1},

                script = function()
                  SPAWN = false
                  reset()
                  gStateMachine:change('menu')
                end},
              }

  PlayMenu:init(self.clickScript)
  -- From src/Scoring.lua, initializes the scores variable
  Scoring:init()
end

function PlayState:update(dt)
  if MENU == false then
    Scoring:update(dt)

    if love.keyboard.isDown(string.lower(playerLeft)) then
      Player.xdelt = -PLAYER_SPEED
      --(Bagares) Animation Parameters
      frame_angle = 270
      frame = frame + 1
      if frame > num_of_frames then frame = 1 end
      
    elseif love.keyboard.isDown(string.lower(playerRight)) then
      Player.xdelt = PLAYER_SPEED
      --(Bagares) Animation Parameters
      frame_angle = 90
      frame = frame - 1
      if frame <= 0 then frame = 8 end
      
    else
      Player.xdelt = 0
    end

    if love.keyboard.isDown(string.lower(playerUp)) then
      Player.ydelt = -PLAYER_SPEED
       --(Bagares) Animation Parameters (UP ANIMATION)
      frame_angle = 0
      frame = frame + 1
      if frame > num_of_frames then frame = 1 end
      
    elseif love.keyboard.isDown(string.lower(playerDown)) then
      Player.ydelt = PLAYER_SPEED
       --(Bagares) Animation Parameters (DOWN ANIMATION)
      frame_angle = 180
      frame = frame - 1
      if frame <= 0 then frame = 8 end
      
    else
      Player.ydelt = 0
    end

    if love.keyboard.wasPressed('escape') then
      MENU = not MENU
    end

    if love.keyboard.wasPressed('return') then
      SPAWN = true
    end

    if SPAWN == true then
      virusUpdate(dt)
    end

  else
    PlayMenu:update(dt)

  end
end

-- [Pandan] - Every allocations I used was percentages of WINDOW_WIDTH and a WINDOW_HEIGHT. Feel free to change this if this is not efficient
-- [Pandan] - If possible, change the color schemes in here
function PlayState:render()
    love.graphics.clear(245/255, 255/255, 255/255, 255/255)
    love.mouse.setCursor(self.cursor)

    Player.render()

    if SPAWN == true then
      virusRender()
    else
      love.graphics.setFont(gFonts['largeFont'])
      love.graphics.setColor(0, 0, 0, 1)
      love.graphics.printf('Press Enter to fight', 0, VIRTUAL_HEIGHT * 0.70, VIRTUAL_WIDTH, 'center')
      love.graphics.setColor(1, 0, 0, 1)
      love.graphics.printf('Enter', VIRTUAL_WIDTH * 0.39, VIRTUAL_HEIGHT * 0.70, VIRTUAL_WIDTH, 'left')
      love.graphics.setColor(0,0,0,0)
    end

    Scoring:render()
    displayClickCount(click_count)

    love.graphics.setFont(gFonts['mediumFont'])
    love.graphics.setColor(0, 0, 0, 1)
    love.graphics.printf('Click Count: ' .. click_count, 0, 0, VIRTUAL_WIDTH)
    love.graphics.printf('Virus: ' .. #virus, 0, 20, VIRTUAL_WIDTH)
    love.graphics.printf('Damage: ' .. virusDamage, 0, 40, VIRTUAL_WIDTH)

    love.graphics.printf('Player X: ' .. tostring(math.floor(Player.x)), 0, 100, VIRTUAL_WIDTH)
    love.graphics.printf('Player Y: ' .. tostring(math.floor(Player.y)), 0, 120, VIRTUAL_WIDTH)

    local mx, my = love.mouse.getPosition()
    love.graphics.printf('Mouse X: ' .. mx, 0, 160, VIRTUAL_WIDTH)
    love.graphics.printf('Mouse Y: ' .. my, 0, 180, VIRTUAL_WIDTH)

    love.graphics.printf('Covid Conquer - BETA', 0, VIRTUAL_HEIGHT - 20, VIRTUAL_WIDTH, 'right')

    love.graphics.setColor(0,0,0,1)

    love.graphics.rectangle('fill', self.clickScript['option'].x, self.clickScript['option'].y, self.clickScript['option'].width, self.clickScript['option'].height)

    if virusDamage < DEATH then
      if MENU == true then
        PlayMenu:render()
      end
    else
      MENU = true
      PlayMenu:render()
    end
end

function PlayState:mouse(x, y, button)
  -- To avoid any errors when clicking outside the window
  if x and y ~= nil then

    -- If LMB was clicked
    if button == 1 then
        -- Pause Button
      if virusDamage < DEATH then
          local clickscript = self.clickScript['option']
          local cX = clickscript.x
          local cY = clickscript.y
          local width = clickscript.width
          local height = clickscript.height
          
          if x > cX and x < cX + width and y > cY and y < cY + height then
            clickscript.script()
          end
      end

      if MENU == true then
        PlayMenu:mousepressed(x, y)

      else
        -- To get a score and kill virus
        gSounds['click']:play()
        Scoring:mousepressed(x, y)
      end
        click_count = click_count + 1
        
    end
  end
end
