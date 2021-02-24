MenuState = Class {__includes = BaseState}

function MenuState:init()
    self.clickScript = {
    {   x = WINDOW_WIDTH * 0.45,
        y = WINDOW_HEIGHT * 0.35,
        width = 80,
        height = 40,
        textcolor = {},

        script = function() gStateMachine:change('play') end},
        
    {   x = WINDOW_WIDTH * 0.45,
        y = WINDOW_HEIGHT * 0.45,
        width = 80,
        height = 40,
        textcolor = {},

        script = function() gStateMachine:change('options') end},
    
    {   x = WINDOW_WIDTH * 0.45,
        y = WINDOW_HEIGHT * 0.55,
        width = 80,
        height = 40,
        textcolor = {},

        script = function() love.event.quit() end
    }}

end

function MenuState:update()   
    x = love.mouse.getX()
    y = love.mouse.getY()

    for i, v in ipairs(self.clickScript) do
        if x > v.x and x < v.x + v.width and y > v.y and y < v.y + v.height then
            self.clickScript[i].textcolor = {1,0,0,1}
        else
            self.clickScript[i].textcolor = {1,1,1,1}
        end
    end
end

function MenuState:render()
    love.graphics.clear(0/255, 0/255, 0/255, 0/255)

    -- Title
    love.graphics.setFont(gFonts['titleFont'])
    love.graphics.setColor(1,0,0,1)
    love.graphics.printf('COVID CONQUER', 0, WINDOW_HEIGHT * 0.20, WINDOW_WIDTH, 'center')

    -- Menu Buttons
    love.graphics.setFont(gFonts['largeFont'])
    love.graphics.setColor(self.clickScript[1].textcolor)
    love.graphics.printf('Play', 0, self.clickScript[1].y, WINDOW_WIDTH, 'center')

    love.graphics.setColor(self.clickScript[2].textcolor)
    love.graphics.printf('Options', 0, self.clickScript[2].y, WINDOW_WIDTH, 'center')

    love.graphics.setColor(self.clickScript[3].textcolor)
    love.graphics.printf('Exit', 0, self.clickScript[3].y, WINDOW_WIDTH, 'center')

end

-- This function follows the AABB Collision
function MenuState:mouse(x, y, button)
    if button == 1 then
        for i, v in ipairs(self.clickScript) do
            if x > v.x and x < v.x + v.width and y > v.y and y < v.y + v.height then
                v.script()
            end
        end
    end
end