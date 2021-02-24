OptionState = Class{__includes = BaseState}

function OptionState:init()
    self.clickScript = {
        ['exit'] = {x = WINDOW_WIDTH * 0.76,
                    y = WINDOW_HEIGHT * 0.80,
                    width = 90,
                    height = 40,
                    textcolor = {1,0,0,1},

                    script = function()
                        if MENU_PLAY == true then
                            gStateMachine:change('play')
                            MENU = true
                        else
                            gStateMachine:change('menu')
                        end
                    end},

                    -- Buttons for (1) Up, (2) Down, (3) Left, (4) Right
                    {x = WINDOW_WIDTH * 0.25,
                     y =  WINDOW_HEIGHT * 0.28,
                     width = 90,
                     height = 40,
                     textcolor = {}},

                    {x = WINDOW_WIDTH * 0.25,
                    y =  WINDOW_HEIGHT * 0.34,
                    width = 90,
                    height = 40,
                    textcolor = {}},
                    
                    {x = WINDOW_WIDTH * 0.65,
                    y =  WINDOW_HEIGHT * 0.28,
                    width = 90,
                    height = 40,
                    textcolor = {}},

                    {x = WINDOW_WIDTH * 0.65,
                    y =  WINDOW_HEIGHT * 0.34,
                    width = 90,
                    height = 40,
                    textcolor = {}}
        }

end

function OptionState:render()
    love.graphics.clear(245/255, 255/255, 255/255, 255/255)

    love.graphics.setFont(gFonts['largeFont'])

    love.graphics.setColor(0,0,0,1)
    love.graphics.printf('Options', WINDOW_WIDTH * 0.1, WINDOW_HEIGHT * 0.1, WINDOW_WIDTH, 'left')
    love.graphics.printf('Movements', 0, WINDOW_HEIGHT * 0.20, WINDOW_WIDTH, 'center')

    -- Buttons
    -- (Place anything possible for options)
    -- love.graphics.setColor(1,1,0,1)
    -- love.graphics.rectangle('fill', self.clickScript[1].x, self.clickScript[1].y, 90, 40)

    local x = love.mouse.getX()
    local y = love.mouse.getY()

    if x > self.clickScript['exit'].x and x < self.clickScript['exit'].x + self.clickScript['exit'].width and y > self.clickScript['exit'].y and y < self.clickScript['exit'].y + self.clickScript['exit'].height then
        self.clickScript['exit'].textcolor = {1,0,0,1}
    else
        self.clickScript['exit'].textcolor = {0,0,0,1}
    end

    for i, v in ipairs(self.clickScript) do
        if x > v.x and x < v.x + v.width and y > v.y and y < v.y + v.height then
            self.clickScript[i].textcolor = {1,0,0,1}
        else
            self.clickScript[i].textcolor = {0,0,0,1}
        end
    end

    love.graphics.setColor(self.clickScript[1].textcolor)
    love.graphics.printf('Up: ' .. string.upper(playerUp), WINDOW_WIDTH * 0.25, WINDOW_HEIGHT * 0.28, WINDOW_WIDTH, 'left')

    love.graphics.setColor(self.clickScript[2].textcolor)
    love.graphics.printf('Down: ' .. string.upper(playerDown), WINDOW_WIDTH * 0.25, WINDOW_HEIGHT * 0.34, WINDOW_WIDTH, 'left')

    love.graphics.setColor(self.clickScript[3].textcolor)
    love.graphics.printf('Left: ' .. string.upper(playerLeft), WINDOW_WIDTH * 0.65, WINDOW_HEIGHT * 0.28, WINDOW_WIDTH, 'left')

    love.graphics.setColor(self.clickScript[4].textcolor)
    love.graphics.printf('Right: ' .. string.upper(playerRight), WINDOW_WIDTH * 0.65, WINDOW_HEIGHT * 0.34, WINDOW_WIDTH, 'left')

    -- Exit button
    -- love.graphics.setColor(1,1,0,0)
    -- love.graphics.rectangle('fill', WINDOW_WIDTH * 0.76, WINDOW_HEIGHT * 0.80, 90, 40)

    love.graphics.setColor(self.clickScript['exit'].textcolor)
    love.graphics.printf('Exit', 0, WINDOW_HEIGHT * 0.80, WINDOW_WIDTH * 0.85, 'right')
end

function OptionState:mouse(x, y, button)
    if button == 1 then
        if x > self.clickScript['exit'].x and x < self.clickScript['exit'].x + self.clickScript['exit'].width and y > self.clickScript['exit'].y and y < self.clickScript['exit'].y + self.clickScript['exit'].height then
            self.clickScript['exit'].script()
        end

        for i, v in ipairs(self.clickScript) do
            if x > v.x and x < v.x + v.width and y > v.y and y < v.y + v.height then
                v.script()
            end
        end
    end
end

function KeyBindings(key)
    if edit == true then
        InputKey = tostring (key)
        if love.keyboard.isDown(key) then
            edit = false
        end
    end

    if edit == false then
        playerUp, playerDown, playerLeft, playerRight = false, false, false, false
    end
end
