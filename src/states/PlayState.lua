PlayState = Class{__includes = BaseState}


function PlayState:init()
  MENU_PLAY = true
  MENU = false

  self.cursor = love.mouse.getSystemCursor("crosshair")
  self.button = {
    ['pause'] = {x = WINDOW_WIDTH * 0.95,
                 y = WINDOW_HEIGHT * 0.02,
                 width = 20,
                 height = 20
                },
    ['option'] = {x = WINDOW_WIDTH * 0.45,
                  y = WINDOW_HEIGHT * 0.4,
                  width = 85,
                  height = 30
                 }
  }
end

function PlayState:update(dt)

  if MENU == false then

    if love.keyboard.isDown('a') then
      Player.xdelt = -PLAYER_SPEED
    elseif love.keyboard.isDown('d') then
      Player.xdelt = PLAYER_SPEED
    else
      Player.xdelt = 0
    end

    if love.keyboard.isDown('w') then
      Player.ydelt = -PLAYER_SPEED
    elseif love.keyboard.isDown('s') then
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

    love.graphics.printf('Click Count: ' .. click_count, 0, 0, WINDOW_WIDTH)
    love.graphics.printf('Virus: ' .. #virus, 0, 20, WINDOW_WIDTH)
    love.graphics.printf('Damage: ' .. virusDamage, 0, 40, WINDOW_WIDTH)

    love.graphics.printf('Player X: ' .. Player.x, 0, 100, WINDOW_WIDTH)
    love.graphics.printf('Player Y: ' .. Player.y, 0, 120, WINDOW_WIDTH)

    local mx, my = love.mouse.getPosition()
    love.graphics.printf('Mouse X: ' .. mx, 0, 160, WINDOW_WIDTH)
    love.graphics.printf('Mouse Y: ' .. my, 0, 180, WINDOW_WIDTH)


    Player.render()

    if love.keyboard.wasPressed('return') then
      virusRender()
    end

    -- [Pandan] - Each button consists of an invisible box and a text, also feel free to convince me for some better alternatives
    -- [Pandan] - You can now delete the rectangular boxes here since this was just used to test if the clickboxes were placed properly
    love.graphics.setColor(0,0,0,1)

    -- Pause Button located at top right
    love.graphics.setFont(gFonts['mediumFont'])
    love.graphics.rectangle('fill', self.button['pause'].x, self.button['pause'].y, self.button['pause'].width, self.button['pause'].height)

    -- [Pandan] - Menu Panel
    if MENU == true then
      -- This code will also stops the player from its position
      Player.xdelt = 0
      Player.ydelt = 0

      love.graphics.rectangle('fill', WINDOW_WIDTH * 0.20, WINDOW_HEIGHT * 0.20, 500, 500)

      -- [Pandan] - Invisible Boxes - 3
      love.graphics.setColor(0,0,0,1)
      for i= 1, 3 do
        love.graphics.rectangle('fill', self.button['option'].x, self.button['option'].y + (WINDOW_HEIGHT * (i * 1/10)), self.button['option'].width, self.button['option'].height)
      end

      -- [Pandan] and its text
      love.graphics.setColor(1,1,1,1)
      love.graphics.printf('Resume', 0, self.button['option'].y, WINDOW_WIDTH, 'center')
      love.graphics.printf('Options', 0, self.button['option'].y + (WINDOW_HEIGHT * 0.1), WINDOW_WIDTH, 'center')
      love.graphics.printf('Exit', 0, self.button['option'].y + (WINDOW_HEIGHT * 0.2), WINDOW_WIDTH, 'center')
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

    -- For pausebutton
    if x > self.button['pause'].x and x < self.button['pause'].x + self.button['pause'].width and y > self.button['pause'].y and y < self.button['pause'].y + self.button['pause'].height then
      MENU = not MENU
    -- [Pandan] Click function for every buttons in Menu
    elseif MENU == true then
      if x > self.button['option'].x and x < self.button['option'].x + self.button['option'].width and y > self.button['option'].y and y < self.button['option'].y + self.button['option'].height then
        MENU = false

      elseif x > self.button['option'].x and x < self.button['option'].x + self.button['option'].width and y > self.button['option'].y + (WINDOW_HEIGHT * 0.1) and y < self.button['option'].y + (WINDOW_HEIGHT * 0.1) + self.button['option'].height then
        gStateMachine:change('options')

      elseif x > self.button['option'].x and x < self.button['option'].x + self.button['option'].width and y > self.button['option'].y + (WINDOW_HEIGHT * 0.2) and y < self.button['option'].y + (WINDOW_HEIGHT * 0.2) + self.button['option'].height then
        gStateMachine:change('menu')
      end

    else
      click_count = click_count + 1

    end
  end
end