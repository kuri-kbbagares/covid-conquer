PlayMenu = Class{}

function PlayMenu:init(clickScript)
    self.clickScript = clickScript
end

function PlayMenu:render()
    Player.xdelt = 0
    Player.ydelt = 0
    love.graphics.rectangle('fill', VIRTUAL_WIDTH * 0.20, VIRTUAL_HEIGHT * 0.10, 300, 300)

    if virusDamage < 1000 then
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

    end
end