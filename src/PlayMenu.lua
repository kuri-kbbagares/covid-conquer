PlayMenu = Class{}

function PlayMenu:init(clickScript)
    self.clickScript = clickScript
end

function PlayMenu:update(dt)
    local x, y = love.mouse.getPosition()
    x, y = push:toGame(x, y)

    if x and y ~= nil then
      for i, v in ipairs(self.clickScript) do
        if x > v.x and x < v.x + v.width and y > v.y and y < v.y + v.height then
            self.clickScript[i].textcolor = {1,0,0,1}
        else
            self.clickScript[i].textcolor = {1,1,1,1}
        end
      end
    end
end

function PlayMenu:render()
    Player.xdelt = 0
    Player.ydelt = 0
    love.graphics.rectangle('fill', VIRTUAL_WIDTH * 0.20, VIRTUAL_HEIGHT * 0.10, 300, 300)

    if virusDamage < DEATH then
        love.graphics.setFont(gFonts['largeFont'])
        love.graphics.setColor(self.clickScript[3].textcolor)
        love.graphics.printf('Game Paused', 0, VIRTUAL_HEIGHT * 0.2, VIRTUAL_WIDTH, 'center')

        love.graphics.setFont(gFonts['mediumFont'])
        love.graphics.setColor(self.clickScript[1].textcolor)
        love.graphics.printf('Resume', 0, self.clickScript[1].y, VIRTUAL_WIDTH, 'center')

        love.graphics.setColor(self.clickScript[2].textcolor)
        love.graphics.printf('Options', 0, self.clickScript[2].y, VIRTUAL_WIDTH, 'center')

        love.graphics.setColor(self.clickScript[3].textcolor)
        love.graphics.printf('Exit', 0, self.clickScript[3].y, VIRTUAL_WIDTH, 'center')

    else
        love.graphics.setFont(gFonts['medium_titleFont'])
        love.graphics.setColor(1,0,0,1)
        love.graphics.printf('GAME OVER', 0, VIRTUAL_HEIGHT * 0.2, VIRTUAL_WIDTH, 'center')

        love.graphics.setFont(gFonts['mediumFont'])
        love.graphics.setColor(1,1,1,1)
        love.graphics.printf('Score: ' .. Scoring.score, 0, VIRTUAL_HEIGHT * 0.4, VIRTUAL_WIDTH, 'center')
        love.graphics.printf('Viruses Killed: ' .. Scoring.virus, 0, VIRTUAL_HEIGHT * 0.5, VIRTUAL_WIDTH, 'center')

        love.graphics.setFont(gFonts['largeFont'])
        love.graphics.setColor(self.clickScript[4].textcolor)
        love.graphics.printf('Retry', self.clickScript[4].x, self.clickScript[4].y, VIRTUAL_WIDTH, 'left')

        love.graphics.setColor(self.clickScript[5].textcolor)
        love.graphics.printf('Exit', 0, VIRTUAL_HEIGHT * 0.7, VIRTUAL_WIDTH * 0.75, 'right')

    end
end

function PlayMenu:mousepressed(x, y)
    if virusDamage < DEATH then
        for i = 1, 3 do
            if x > self.clickScript[i].x and x < self.clickScript[i].x  + self.clickScript[i].width and y > self.clickScript[i].y and y < self.clickScript[i].y + self.clickScript[i].height then
                self.clickScript[i].script()
            end
        end
    else
        for i = 4, 5 do
            if x > self.clickScript[i].x and x < self.clickScript[i].x  + self.clickScript[i].width and y > self.clickScript[i].y and y < self.clickScript[i].y + self.clickScript[i].height then
                self.clickScript[i].script()
            end
        end
    end
end