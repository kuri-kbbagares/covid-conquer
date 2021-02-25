PlayState = Class{__includes = BaseState}


function PlayState:init()
  MENU_PLAY = true
  MENU = false

  self.cursor = love.mouse.getSystemCursor("crosshair")
  self.clickScript = {
    ['option'] = {x = WINDOW_WIDTH * 0.95,
                  y = WINDOW_HEIGHT * 0.02,
                  width = 20,
                  height = 20,

                  script = function() MENU = true end},

                -- Option Buttons 1 (Resume), 2 (Options), 3 (Exit)
                {x = WINDOW_WIDTH * 0.45,
                 y = WINDOW_HEIGHT * 0.4,
                 width = 85,
                 height = 30,
                 textcolor = {},

                 script = function() MENU = false end},

                {x = WINDOW_WIDTH * 0.45,
                y = WINDOW_HEIGHT * 0.5,
                width = 85,
                height = 30,
                textcolor = {},

                script = function() gStateMachine:change('options') end},
              
                {x = WINDOW_WIDTH * 0.45,
                 y = WINDOW_HEIGHT * 0.6,
                 width = 85,
                 height = 30,
                 textcolor = {},

                 script = function() gStateMachine:change('menu') end
                }}
end

function PlayState:update(dt)
  if MENU == false then
    if love.keyboard.isDown(string.lower(playerLeft)) then
      Player.xdelt = -PLAYER_SPEED
    elseif love.keyboard.isDown(string.lower(playerRight)) then
      Player.xdelt = PLAYER_SPEED
    else
      Player.xdelt = 0
    end

    if love.keyboard.isDown(string.lower(playerUp)) then
      Player.ydelt = -PLAYER_SPEED
    elseif love.keyboard.isDown(string.lower(playerDown)) then
      Player.ydelt = PLAYER_SPEED
    else
      Player.ydelt = 0
    end

    if love.keyboard.wasPressed('escape') then
      love.event.quit()
    end

    -- [Pandan] - ATTENTION: Temporary Fix, please make an alternative
    if love.keyboard.wasPressed('return') then
      virusUpdate(dt)
    end
  end
end

-- [Pandan] - Every allocations I used was percentages of WINDOW_WIDTH and a WINDOW_HEIGHT. Feel free to change this if this is not efficient
-- [Pandan] - If possible, change the color schemes in here
function PlayState:render()
    love.graphics.clear(245/255, 255/255, 255/255, 255/255)
    love.mouse.setCursor(self.cursor)

    love.graphics.setColor(0, 0, 0, 1)
    displayClickCount(click_count)

    love.graphics.setFont(gFonts['mediumFont'])
    love.graphics.printf('Click Count: ' .. click_count, 0, 0, WINDOW_WIDTH)
    love.graphics.printf('Virus: ' .. #virus, 0, 20, WINDOW_WIDTH)
    love.graphics.printf('Damage: ' .. tostring(virusDamage), 0, 40, WINDOW_WIDTH)

    love.graphics.printf('Player X: '.. tostring(math.floor(Player.x)), 0, 100, WINDOW_WIDTH)
    love.graphics.printf('Player Y: '.. tostring(math.floor(Player.y)), 0, 120, WINDOW_WIDTH)

    love.graphics.printf('Virus X: ', 0, 160, WINDOW_WIDTH)
    love.graphics.printf('Virus Y: ', 0, 180, WINDOW_WIDTH)

    love.graphics.printf('Covid Conquer - BETA', 0, WINDOW_HEIGHT - 20, WINDOW_WIDTH, 'right')

    Player.render()

    if love.keyboard.wasPressed('return') then
      virusRender()
    end

    love.graphics.setColor(0,0,0,1)

    love.graphics.rectangle('fill', self.clickScript['option'].x, self.clickScript['option'].y, self.clickScript['option'].width, self.clickScript['option'].height)

    -- [Pandan] - Menu Panel
    if MENU == true then
      Player.xdelt = 0
      Player.ydelt = 0

      for i, v in ipairs(self.clickScript) do
        if love.mouse.getX() > v.x and love.mouse.getX() < v.x + v.width and love.mouse.getY() > v.y and love.mouse.getY() < v.y + v.height then
            self.clickScript[i].textcolor = {1,0,0,1}
        else
            self.clickScript[i].textcolor = {1,1,1,1}
        end
      end

      love.graphics.rectangle('fill', WINDOW_WIDTH * 0.20, WINDOW_HEIGHT * 0.20, 500, 500)

      -- [Pandan] and its text
      love.graphics.setColor(self.clickScript[1].textcolor)
      love.graphics.printf('Resume', 0, self.clickScript[1].y, WINDOW_WIDTH, 'center')

      love.graphics.setColor(self.clickScript[2].textcolor)
      love.graphics.printf('Options', 0, self.clickScript[2].y, WINDOW_WIDTH, 'center')

      love.graphics.setColor(self.clickScript[3].textcolor)
      love.graphics.printf('Exit', 0, self.clickScript[3].y, WINDOW_WIDTH, 'center')
    end
end

-- [Pandan] This mouse function follows the AABB Collision
function PlayState:mouse(x, y, button)

  if button == 1 then
    -- For virus and player range
    if ((Player.x + (Player.width / 2) - x) ^2 + (Player.y + (Player.height / 2) - y) ^2) ^0.5 < Player.radius then
      for i, v in ipairs (virus) do
        if ((v.x - x) ^2 + (v.y - y) ^2) ^0.5 < v.radius then
          table.remove(virus, i)
          break
        end
      end
    end

    if x > self.clickScript['option'].x and x < self.clickScript['option'].x + self.clickScript['option'].width and y > self.clickScript['option'].y and y < self.clickScript['option'].y + self.clickScript['option'].height then
      MENU = not MENU
    end

    for i, v in ipairs(self.clickScript) do
      if x > v.x and x < v.x + v.width and y > v.y and y < v.y + v.height then
          v.script()
      end
    end

  else
    click_count = click_count + 1
  end
end