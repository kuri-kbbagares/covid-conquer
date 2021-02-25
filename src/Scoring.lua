--[[
    Scoring Cheat Sheet:

    3 Viruses Killed
        Level:  "Combo 1"
        Score:  x2
        Duration:   line - (dt * 20) -- less than 2x line
        Next: 5 viruses

    3 + 5 Viruses Killed
        Level:  "Combo 2"
        Score:  x4
        Duration: line - (dt * 40) -- less than 4x line
        Next:   8 viruses

    3 + 5 + 7 Viruses Killed
        Level: "Combo 3"
        Score: x8
        Duration: line - (dt * 80) -- less than 8x line
        Next:   Null

    ** Take Note: Time length is based on a line meaning that it may vary on how long VIRTUAL_WIDTH is

    So its better that we must have a decided resolution for our game

]]
Scoring = Class{}

function Scoring:init()
    self.score = 0

    self.combo = 0

    self.kill = 50

    self.time = 0

    -- Color Fading Script
    self.color = 255
    self.limit = VIRTUAL_WIDTH * 0.70 + self.time

end

function Scoring:update(dt)
    if self.combo >= 3 and self.combo <= 7 then
        self.time = self.time + dt * 20

        self.kill = 100

    elseif self.combo >= 8 and self.combo <= 14 then
        self.time = self.time + dt * 40

        self.kill = 400

    elseif self.combo >= 15 then
        self.time = self.time + dt * 80

        self.kill = 3200
    end

    -- Fade in color effect of self.score
    if self.color > 0 then
        self.color = math.floor(self.color - dt * 200)
    end

end

function Scoring:render()
    love.graphics.setColor(math.floor(self.color)/255, 0, 0, 255)
    love.graphics.printf(self.score, 0, VIRTUAL_HEIGHT * 0.01, VIRTUAL_WIDTH, 'right')


    if self.combo >= 3 and self.combo <= 7 then
        love.graphics.setColor(0,0,0,1)
        love.graphics.printf("Combo x2", 0, VIRTUAL_HEIGHT * 0.06, VIRTUAL_WIDTH, 'right')

        self.limit = VIRTUAL_WIDTH * 0.70 + self.time

        love.graphics.setColor(math.floor(self.color)/255, 0, 0, 255)
        love.graphics.line(self.limit, 2, VIRTUAL_WIDTH, 2)

    elseif self.combo >= 8 and self.combo <= 14 then
        love.graphics.setColor(0,0,0,1)
        love.graphics.printf("Combo x4", 0, VIRTUAL_HEIGHT * 0.06, VIRTUAL_WIDTH, 'right')

        self.limit = VIRTUAL_WIDTH * 0.70 + self.time

        love.graphics.setColor(math.floor(self.color)/255, 0, 0, 255)
        love.graphics.line(self.limit, 2, VIRTUAL_WIDTH, 2)


    elseif self.combo >= 15 then
        love.graphics.setColor(0,0,0,1)
        love.graphics.printf("Combo x8", 0, VIRTUAL_HEIGHT * 0.06, VIRTUAL_WIDTH, 'right')

        self.limit = VIRTUAL_WIDTH * 0.70 + self.time
        
        love.graphics.setColor(math.floor(self.color)/255, 0, 0, 255)
        love.graphics.line(self.limit, 2, VIRTUAL_WIDTH, 2)
    end

    if self.limit > VIRTUAL_WIDTH then
        self.kill = 50
        self.combo = 0
        self.time = 0

        self.limit = VIRTUAL_WIDTH * 0.70 + self.time
    end

end

function Scoring:mousepressed(x, y, button)

    -- For virus and player range
    if ((Player.x + (Player.width / 2) - x) ^2 + (Player.y + (Player.height / 2) - y) ^2) ^0.5 < Player.radius then
        for i, v in ipairs (virus) do
            if ((v.x - x) ^2 + (v.y - y) ^2) ^0.5 < v.radius then
                table.remove(virus, i)

                -- Fade in color effect of self.score
                self.color = 255

                self.score = self.score + self.kill
                self.combo = self.combo + 1
                
                if self.combo >= 3 then
                    self.time = 0
                end

                break
            end
        end
    end

end