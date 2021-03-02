OptionState = Class{__includes = BaseState}

function OptionState:init()
    self.clickScript = {
        ['exit'] = {x = VIRTUAL_WIDTH * 0.76,
                    y = VIRTUAL_HEIGHT * 0.80,
                    width = 90,
                    height = 40,
                    textcolor = {1,0,0,1},

                    script = function()
                        if MENU_PLAY == true then
                            gStateMachine:change('play')
                            MENU = true
                        else
                            gStateMachine:change('title')
                        end
                    end},

                    -- Buttons for (1) Up, (2) Down, (3) Left, (4) Right
                    {x = VIRTUAL_WIDTH * 0.20,
                    y =  VIRTUAL_HEIGHT * 0.30,
                    width = 90,
                    height = 40,
                    textcolor = {0,0,0,1},

                    script = function()
                            playerUp = 'INSERT KEY'
                            if playerUp == 'INSERT KEY' then
                                playerUpOpen = true
                                KeyBindings()
                            end
                    end},

                    {x = VIRTUAL_WIDTH * 0.20,
                    y =  VIRTUAL_HEIGHT * 0.40,
                    width = 90,
                    height = 40,
                    textcolor = {0,0,0,1},
                    
                    script = function()
                        playerDown = 'INSERT KEY'
                        if playerDown == 'INSERT KEY' then
                            playerDownOpen = true
                            KeyBindings()
                        end
                    end},
                    
                    {x = VIRTUAL_WIDTH * 0.50,
                    y =  VIRTUAL_HEIGHT * 0.30,
                    width = 90,
                    height = 40,
                    textcolor = {0,0,0,1},

                    script = function()
                        playerLeft = 'INSERT KEY'
                        if playerLeft == 'INSERT KEY' then
                            playerLeftOpen = true
                            KeyBindings()
                        end
                    end},

                    {x = VIRTUAL_WIDTH * 0.50,
                    y =  VIRTUAL_HEIGHT * 0.40,
                    width = 90,
                    height = 40,
                    textcolor = {0,0,0,1},

                    script = function()
                        playerRight = 'INSERT KEY'
                        if playerRight == 'INSERT KEY' then
                            playerRightOpen = true
                            KeyBindings()
                        end
                    end},
        }

end

function OptionState:update(dt)
    local x, y = love.mouse.getPosition()
    x, y = push:toGame(x, y)

    if x and y ~= nil then
        if x > self.clickScript['exit'].x and x < self.clickScript['exit'].x + self.clickScript['exit'].width and y > self.clickScript['exit'].y and y < self.clickScript['exit'].y + self.clickScript['exit'].height then
            self.clickScript['exit'].textcolor = {1,0,0,1}
        else
            self.clickScript['exit'].textcolor = {0,0,0,1}
        end

        
        for i, v in ipairs(self.clickScript) do
            if x > v.x and x < v.x + v.width and y > v.y and y < v.y + v.height then
                self.clickScript[i].textcolor = {1,0,0,1}
            else
                self.clickScript[i].textcolor = {1,1,1,1}
            end
        end
    end
end

function OptionState:render()
    love.graphics.clear(245/255, 255/255, 255/255, 255/255)

    love.graphics.setFont(gFonts['largeFont'])

    love.graphics.setColor(1,0,0,1)
    love.graphics.printf('Options', VIRTUAL_WIDTH * 0.1, VIRTUAL_HEIGHT * 0.1, VIRTUAL_WIDTH, 'left')
    love.graphics.printf('Movements', 0, VIRTUAL_HEIGHT * 0.20, VIRTUAL_WIDTH, 'center')

    -- Buttons
    -- (Place anything possible for options)
    -- love.graphics.setColor(1,1,0,1)
    -- love.graphics.rectangle('fill', self.clickScript[1].x, self.clickScript[1].y, 90, 40)

    love.graphics.setColor(self.clickScript[1].textcolor)
    love.graphics.printf('Up: ' .. string.upper(playerUp), self.clickScript[1].x, self.clickScript[1].y, VIRTUAL_WIDTH, 'left')

    love.graphics.setColor(self.clickScript[2].textcolor)
    love.graphics.printf('Down: ' .. string.upper(playerDown), self.clickScript[2].x, self.clickScript[2].y, VIRTUAL_WIDTH, 'left')

    love.graphics.setColor(self.clickScript[3].textcolor)
    love.graphics.printf('Left: ' .. string.upper(playerLeft), self.clickScript[3].x, self.clickScript[3].y, VIRTUAL_WIDTH, 'left')

    love.graphics.setColor(self.clickScript[4].textcolor)
    love.graphics.printf('Right: ' .. string.upper(playerRight), self.clickScript[4].x, self.clickScript[4].y, VIRTUAL_WIDTH, 'left')

    -- Exit button
    -- love.graphics.setColor(1,1,0,0)
    -- love.graphics.rectangle('fill', WINDOW_WIDTH * 0.76, WINDOW_HEIGHT * 0.80, 90, 40)

    love.graphics.setColor(self.clickScript['exit'].textcolor)
    love.graphics.printf('Exit', 0, VIRTUAL_HEIGHT * 0.80, VIRTUAL_WIDTH * 0.85, 'right')
end

function OptionState:mouse(x, y, button)
    if x and y ~= nil then
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
end
