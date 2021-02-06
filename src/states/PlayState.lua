PlayState = Class{__includes = BaseState}


function PlayState:init()

end

function PlayState:update(dt)

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

  if love.keyboard.wasPressed('escape') then
    love.event.quit()
  end

end

function PlayState:render()
    love.graphics.clear(245/255, 255/255, 255/255, 255/255)
    love.graphics.setColor(0, 0, 0, 1)
    displayClickCount(click_count)
    love.graphics.printf('Covid Conquer ', 0, WINDOW_HEIGHT/2, VIRTUAL_WIDTH)
    Player:render()

    if love.keyboard.wasPressed('return') then
      Covid:render()
    end

    -- *************************************************************
    local button_x = WINDOW_WIDTH * 0.95
    local button_y = WINDOW_HEIGHT * 0.02
    local button_width = 20
    local button_height = 20
    love.graphics.setColor(0,0,0,1)
    love.graphics.rectangle('fill', button_x, button_y, button_width, button_height)

    if menu == true then
      love.graphics.rectangle('fill', WINDOW_WIDTH * 0.20, WINDOW_HEIGHT * 0.20, 500, 500)

      love.graphics.setColor(1,1,1,1)
      love.graphics.printf('Resume', 0, WINDOW_HEIGHT * 0.5, WINDOW_WIDTH, 'center')
    end
    -- *******************************************************************
end

function PlayState:mouse(x, y, button)
  self.x = x
  self.y = y

  if button == 1 then
    if self.x > WINDOW_WIDTH * 0.95 and self.x < WINDOW_WIDTH * 0.95 + 20 and self.y > WINDOW_HEIGHT * 0.02 and self.y < WINDOW_HEIGHT * 0.02 + 20 then
      menu = not menu
    else
      click_count = click_count + 1
    end
  end

end