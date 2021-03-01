--[[
    Scoring Cheat Sheet:

    3 Viruses Killed
        Level:  "Combo 1"
        Score:  x2
        Duration:   line - (dt * 20) -- less than 2x line (5 secs)
        Next: 5 viruses

    3 + 5 Viruses Killed
        Level:  "Combo 2"
        Score:  x4
        Duration: line - (dt * 40) -- less than 4x line (2.5 secs)
        Next:   8 viruses

    3 + 5 + 7 Viruses Killed
        Level: "Combo 3"
        Score: x8
        Duration: line - (dt * 80) -- less than 8x line (1.25 secs)
        Next:   Null

    ** Time Length is 100px

    So its better that we must have a decided resolution for our game

]]
Scoring = Class{}

Scoring.score = 0
Scoring.combo = 0
Scoring.time = 0
Scoring.virus = 0

function Scoring:init()
    self.kill = 50

    -- Color Fading Script
    self.color = 0
    self.limit = VIRTUAL_WIDTH - 100 + Scoring.time

    Particles:init()
end

function Scoring:update(dt)
    if Scoring.combo >= 3 and Scoring.combo <= 7 then
        Scoring.time = Scoring.time + dt * 20

        self.kill = 100

    elseif Scoring.combo >= 8 and Scoring.combo <= 14 then
        Scoring.time = Scoring.time + dt * 40

        self.kill = 400

    elseif Scoring.combo >= 15 then
        Scoring.time = Scoring.time + dt * 80

        self.kill = 3200
    end

    -- Fade in color effect of self.score
    if self.color < 255 then
        self.color = math.floor(self.color + dt * 200)
    end

    Particles:update(dt)

end

function Scoring:render()
    Particles:render()
    love.graphics.setColor(1, 1, 1, 1)

    love.graphics.setColor(255, math.floor(self.color)/255, math.floor(self.color)/255, 255)
    love.graphics.setFont(gFonts['mediumFont'])
    love.graphics.printf(self.score, 0, VIRTUAL_HEIGHT * 0.01, VIRTUAL_WIDTH, 'right')


    if Scoring.combo >= 3 and Scoring.combo <= 7 then
        love.graphics.setColor(1,1,1,1)
        love.graphics.printf("Combo x2", 0, VIRTUAL_HEIGHT * 0.06, VIRTUAL_WIDTH, 'right')

        self.limit = VIRTUAL_WIDTH - 100 + Scoring.time

        love.graphics.setColor(255, math.floor(self.color)/255, math.floor(self.color)/255, 255)
        love.graphics.line(self.limit, 2, VIRTUAL_WIDTH, 2)

    elseif Scoring.combo >= 8 and Scoring.combo <= 14 then
        love.graphics.setColor(1,1,1,1)
        love.graphics.printf("Combo x4", 0, VIRTUAL_HEIGHT * 0.06, VIRTUAL_WIDTH, 'right')

        self.limit = VIRTUAL_WIDTH - 100 + Scoring.time

        love.graphics.setColor(255, math.floor(self.color)/255, math.floor(self.color)/255, 255)
        love.graphics.line(self.limit, 2, VIRTUAL_WIDTH, 2)


    elseif Scoring.combo >= 15 then
        love.graphics.setColor(1,1,1,1)
        love.graphics.printf("Combo x8", 0, VIRTUAL_HEIGHT * 0.06, VIRTUAL_WIDTH, 'right')

        self.limit = VIRTUAL_WIDTH - 100 + Scoring.time
        
        love.graphics.setColor(255, math.floor(self.color)/255, math.floor(self.color)/255, 255)
        love.graphics.line(self.limit, 2, VIRTUAL_WIDTH, 2)
    end

    if self.limit > VIRTUAL_WIDTH then
        self.kill = 50
        Scoring.combo = 0
        Scoring.time = 0

        self.limit = VIRTUAL_WIDTH - 100 + Scoring.time
    end

end

function Scoring:mousepressed(x, y)

    -- For virus and player range
    if ((Player.x + (Player.width / 2) - x) ^2 + (Player.y + (Player.height / 2) - y) ^2) ^0.5 < Player.radius then
        for i, v in ipairs (virus) do
            if ((v.x - x) ^2 + (v.y - y) ^2) ^0.5 < v.radius then
                table.remove(virus, i)

                -- Fade in color effect of self.score
                self.color = 0

                Particles:spray(x, y)

                Scoring.score = Scoring.score + self.kill
                Scoring.combo = Scoring.combo + 1
                Scoring.virus = Scoring.virus + 1
                
                if Scoring.combo >= 3 then
                    Scoring.time = 0
                end
                
                break
            end
        end
    end

end
