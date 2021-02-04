PlayState = Class{__includes = BaseState}

function PlayState:init()

end

function PlayState:update(dt)

end

function PlayState:render()
    love.graphics.clear(245/255, 255/255, 255/255, 255/255)
    love.graphics.setColor(0, 0, 0, 1)
    displayClickCount(click_count)
    love.graphics.printf('Covid Conquer ', 0, V_PUSH_HEIGHT/2, V_PUSH_WIDTH)
    
    Player:render()
    if love.keyboard.wasPressed('return') then
      Covid:render()
    end
end