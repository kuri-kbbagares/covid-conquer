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

    menu_button = mouse(button_x, button_y, button_width, button_height)

    love.graphics.printf(tostring(menu_button.switch), 0, WINDOW_HEIGHT * 0.5, WINDOW_WIDTH, 'center')

    if menu == true then
      love.graphics.rectangle('fill', WINDOW_WIDTH * 0.20, WINDOW_HEIGHT * 0.20, 500, 500)
    end
    -- *******************************************************************
end