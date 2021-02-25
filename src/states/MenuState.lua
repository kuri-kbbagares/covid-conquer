MenuState = Class {__includes = BaseState}

function MenuState:init()
    self.clickScript = {
    {   x = VIRTUAL_WIDTH * 0.45,
        y = VIRTUAL_HEIGHT * 0.45,
        width = 80,
        height = 40,
        textcolor = {1,1,1,1},

        script = function() gStateMachine:change('play') end},
        
    {   x = VIRTUAL_WIDTH * 0.45,
        y = VIRTUAL_HEIGHT * 0.55,
        width = 80,
        height = 40,
        textcolor = {1,1,1,1},

        script = function() gStateMachine:change('options') end},
    
    {   x = VIRTUAL_WIDTH * 0.45,
        y = VIRTUAL_HEIGHT * 0.65,
        width = 80,
        height = 40,
        textcolor = {1,1,1,1},

        script = function() love.event.quit() end
    }}

end

function MenuState:update(dt)
    -- Menu Button's HighLighter
    local x, y = love.mouse.getPosition()
    x, y = push:toGame(x, y)

    if x and y ~= nil then
        for i, v in ipairs(self.clickScript) do
            if x and y ~= nil then
                if x > v.x and x < v.x + v.width and y > v.y and y < v.y + v.height then
                    self.clickScript[i].textcolor = {1,0,0,1}
                else
                    self.clickScript[i].textcolor = {1,1,1,1}
                end
            end
        end
    end
end

function MenuState:render()
    love.graphics.clear(0/255, 0/255, 0/255, 0/255)

    -- Title
    love.graphics.setFont(gFonts['titleFont'])
    love.graphics.setColor(1,0,0,1)
    love.graphics.printf('COVID CONQUER', 0, VIRTUAL_HEIGHT * 0.20, VIRTUAL_WIDTH, 'center')


    love.graphics.setFont(gFonts['largeFont'])
    love.graphics.setColor(self.clickScript[1].textcolor)
    love.graphics.printf('Play', 0, self.clickScript[1].y, VIRTUAL_WIDTH, 'center')

    love.graphics.setColor(self.clickScript[2].textcolor)
    love.graphics.printf('Options', 0, self.clickScript[2].y, VIRTUAL_WIDTH, 'center')

    love.graphics.setColor(self.clickScript[3].textcolor)
    love.graphics.printf('Exit', 0, self.clickScript[3].y, VIRTUAL_WIDTH, 'center')

end

-- This function follows the AABB Collision
function MenuState:mouse(x, y, button)
    if x and y ~= nil then

        if button == 1 then
            for i, v in ipairs(self.clickScript) do
                if x > v.x and x < v.x + v.width and y > v.y and y < v.y + v.height then
                    v.script()
                end
            end
        end
    end
end