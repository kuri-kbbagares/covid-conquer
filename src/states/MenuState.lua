MenuState = Class {__includes = BaseState}

function MenuState:init()

end

function MenuState:update()

end

function MenuState:render()
    love.graphics.clear(245/255, 255/255, 255/255, 255/255)

    love.graphics.setColor(0,0,0,1)
    love.graphics.printf('Covid Conquer', 0, WINDOW_HEIGHT * 0.25, WINDOW_WIDTH, 'center')
    love.graphics.printf('Play', 0, WINDOW_HEIGHT * 0.30, WINDOW_WIDTH, 'center')
end