MenuState = Class {__includes = BaseState}

function MenuState:init()
    self.button = {
        ['menu'] = {x = WINDOW_WIDTH * 0.45,
                    y = WINDOW_HEIGHT * 0.35,
                    width = 80,
                    height = 40
                   }
    }

end

function MenuState:update()

end

function MenuState:render()
    love.graphics.clear(245/255, 255/255, 255/255, 255/255)
    love.graphics.setFont(gFonts['largeFont'])

    -- Title
    love.graphics.setColor(0,0,0,1)
    love.graphics.printf('Covid Conquer', 0, WINDOW_HEIGHT * 0.25, WINDOW_WIDTH, 'center')

    -- Each button consists of an invisible box and a text
    love.graphics.setColor(0,0,0,0)
    love.graphics.rectangle('fill', self.button['menu'].x, self.button['menu'].y, self.button['menu'].width, self.button['menu'].height)
    love.graphics.setColor(0,0,0,1)
    love.graphics.printf('Play', 0, self.button['menu'].y, WINDOW_WIDTH, 'center')


    love.graphics.printf('Options', 0, WINDOW_HEIGHT * 0.45, WINDOW_WIDTH, 'center')

end

-- This function follows the AABB Collision
function MenuState:mouse(x, y, button)
    if button == 1 then
        if x > self.button['menu'].x and x < self.button['menu'].x + self.button['menu'].width and y > self.button['menu'].y and y < self.button['menu'].y + self.button['menu'].height then
            gStateMachine:change('play')
        end
    end

end