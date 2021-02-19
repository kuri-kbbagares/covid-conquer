PlayState = Class{__includes = BaseState}


function PlayState:init()
  menuPlay = true
  menu = false

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

  if menu == false then

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
    virusUpdate(dt)
  end

end

-- [Pandan] - Every allocations I used was percentages of WINDOW_WIDTH and a WINDOW_HEIGHT. Feel free to change this if this is not efficient
-- [Pandan] - If possible, change the color schemes in here
function PlayState:render()
    love.graphics.clear(245/255, 255/255, 255/255, 255/255)
    love.graphics.setColor(0, 0, 0, 1)
    displayClickCount(click_count)
    love.graphics.printf('Covid Conquer ', 0, WINDOW_HEIGHT/2, WINDOW_WIDTH)
    love.graphics.printf('Damage: ' .. virusDamage, 0, WINDOW_HEIGHT/2.5, WINDOW_WIDTH)
    love.graphics.printf('Virus: ' .. #virus, 0, WINDOW_HEIGHT/3, WINDOW_WIDTH)
    love.graphics.printf('Click Count: ' .. click_count, 0, WINDOW_HEIGHT/3.5, WINDOW_WIDTH)

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
    if menu == true then
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
    -- For virus
    for i, v in ipairs (virus) do
      if x > v.x and x < v.x + v.width  and y > v.y and y < v.y + v.height then
        table.remove(virus, i)
      end
    end
    
    if x > self.button['pause'].x and x < self.button['pause'].x + self.button['pause'].width and y > self.button['pause'].y and y < self.button['pause'].y + self.button['pause'].height then
      menu = not menu

    -- [Pandan] Click function for every buttons in Menu
    elseif menu == true then
      if x > self.button['option'].x and x < self.button['option'].x + self.button['option'].width and y > self.button['option'].y and y < self.button['option'].y + self.button['option'].height then
        menu = false
      elseif x > self.button['option'].x and x < self.button['option'].x + self.button['option'].width and y > self.button['option'].y + (WINDOW_HEIGHT * 0.1) and y < self.button['option'].y + (WINDOW_HEIGHT * 0.1) + self.button['option'].height then
        gStateMachine:change('options')
      elseif x > self.button['option'].x and x < self.button['option'].x + self.button['option'].width and y > self.button['option'].y + (WINDOW_HEIGHT * 0.2) and y < self.button['option'].y + (WINDOW_HEIGHT * 0.2) + self.button['option'].height then
        gStateMachine:change('menu')
      end
    
      

    else
      click_count = click_count + 1

      -- [Pandan] Nuke feature where all of the virus will be destroyed
    end
  end
end