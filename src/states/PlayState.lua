PlayState = Class{__includes = BaseState}


function PlayState:init()
  menuPlay = true
  menu = false

end

function PlayState:update(dt)

  if menu == false or option == false then

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

end

-- [Pandan] Every allocations I used was percentages of WINDOW_WIDTH and a WINDOW_HEIGHT. Feel free to change this if this is not efficient
-- If possible, change the color schemes in here
function PlayState:render()
    love.graphics.clear(245/255, 255/255, 255/255, 255/255)
    love.graphics.setColor(0, 0, 0, 1)
    displayClickCount(click_count)
    love.graphics.printf('Covid Conquer ', 0, WINDOW_HEIGHT/2, VIRTUAL_WIDTH)
    Player:render()

    if love.keyboard.wasPressed('return') then
      Covid:render()
    end

    -- Each button consists of an invisible box and a text, also feel free to convince me for some better alternatives
    pauseButton_x = WINDOW_WIDTH * 0.95
    pauseButton_y = WINDOW_HEIGHT * 0.02
    pauseButton_width = 20
    pauseButton_height = 20

    love.graphics.setColor(0,0,0,1)

    -- Pause Button located at top right
    love.graphics.setFont(gFonts['mediumFont'])
    love.graphics.rectangle('fill', pauseButton_x, pauseButton_y, pauseButton_width, pauseButton_height)

    -- Menu Panel
    if menu == true then
      pauseText_x = WINDOW_WIDTH * 0.45
      pauseText_y = WINDOW_HEIGHT * 0.4
      pauseText_width = 85
      pauseText_height = 30

      love.graphics.rectangle('fill', WINDOW_WIDTH * 0.20, WINDOW_HEIGHT * 0.20, 500, 500)

      -- Invisible Boxes - 3
      love.graphics.setColor(0,0,0,1)
      for i= 0, 2 do
        love.graphics.rectangle('fill', pauseText_x, pauseText_y + (WINDOW_HEIGHT * (i * 1/10)), pauseText_width, pauseText_height)
      end

      -- and its text
      love.graphics.setColor(1,1,1,1)
      love.graphics.printf('Resume', 0, pauseText_y, WINDOW_WIDTH, 'center')
      love.graphics.printf('Options', 0, pauseText_y + (WINDOW_HEIGHT * 0.1), WINDOW_WIDTH, 'center')
      love.graphics.printf('Exit', 0, pauseText_y + (WINDOW_HEIGHT * 0.2), WINDOW_WIDTH, 'center')
    end
end

-- This mouse function follows the AABB Collision
function PlayState:mouse(x, y, button)

  if button == 1 then
    if x > pauseButton_x and x < pauseButton_x + pauseButton_width and y > pauseButton_y and y < pauseButton_y + pauseButton_height then
      menu = not menu
    
    -- Click function for every buttons in Menu
    elseif menu == true then
      if x > pauseText_x and x < pauseText_x + pauseText_width and y > pauseText_y and y < pauseText_y + pauseButton_height then
        menu = false
      elseif x > pauseText_x and x < pauseText_x + pauseText_width and y > pauseText_y + (WINDOW_HEIGHT * 0.1) and y < pauseText_y + (WINDOW_HEIGHT * 0.1) + pauseButton_height then
        gStateMachine:change('options')
      elseif x > pauseText_x and x < pauseText_x + pauseText_width and y > pauseText_y + (WINDOW_HEIGHT * 0.2) and y < pauseText_y + (WINDOW_HEIGHT * 0.2) + pauseButton_height then
        gStateMachine:change('menu')
      end

    -- In my speculation, you can also add the click function of every viruses in here, just add another elseif

    else
      click_count = click_count + 1
    end
  end

end