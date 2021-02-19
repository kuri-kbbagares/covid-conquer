OptionState = Class{__includes = BaseState}

function OptionState:init()
    self.button = {
        ['exit'] = {x = WINDOW_WIDTH * 0.76,
                    y = WINDOW_HEIGHT * 0.80,
                    width = 90,
                    height = 40

        }
    }

end

function OptionState:render()
    love.graphics.clear(245/255, 255/255, 255/255, 255/255)

    love.graphics.setFont(gFonts['largeFont'])

    love.graphics.setColor(0,0,0,1)
    love.graphics.printf('Options', WINDOW_WIDTH * 0.1, WINDOW_HEIGHT * 0.1, WINDOW_WIDTH, 'left')

    -- Buttons
    -- (Place anything possible for options)

    -- Exit button
    love.graphics.setColor(1,1,0,0)
    love.graphics.rectangle('fill', WINDOW_WIDTH * 0.76, WINDOW_HEIGHT * 0.80, 90, 40)

    love.graphics.setColor(0,0,0,1)
    love.graphics.printf('Exit', 0, WINDOW_HEIGHT * 0.80, WINDOW_WIDTH * 0.85, 'right')
end

function OptionState:mouse(x, y, button)

    if button == 1 then
        if x > WINDOW_WIDTH * 0.76 and x < WINDOW_WIDTH * 0.76 + 90 and y > WINDOW_HEIGHT * 0.80 and y < WINDOW_HEIGHT * 0.80 + 40 then
            if menuPlay == true then
                gStateMachine:change('play')
            else
                gStateMachine:change('menu')
            end
        end
    end

end
