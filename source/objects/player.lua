Player = {}

function Player.load()
    Player.x = VIRTUAL_WIDTH / 2
    Player.y = VIRTUAL_HEIGHT / 2
    Player.width = 20
    Player.height = 20
    Player.ydelt = 0
    Player.xdelt = 0

    Player.speed = 100
    -- [Pandan] - I've come up an idea that we should make a range
    Player.radius = 75

end

function Player.update(dt)
    -- North
    if love.keyboard.isDown(string.lower(playerUp)) then
        Player.ydelt = -Player.speed
         --(Bagares) Animation Parameters (UP ANIMATION)
        frame_angle = 0
        frame = frame + 1
        if frame > num_of_frames then frame = 1 end
    
    -- South
    elseif love.keyboard.isDown(string.lower(playerDown)) then
        Player.ydelt = Player.speed
         --(Bagares) Animation Parameters (DOWN ANIMATION)
        frame_angle = 180
        frame = frame - 1
        if frame <= 0 then frame = 8 end

    else
        -- Player Idle State
        Player.ydelt = 0
    end

    -- West
    if love.keyboard.isDown(string.lower(playerLeft)) then
        Player.xdelt = -Player.speed
        --(Bagares) Animation Parameters
        frame_angle = 270
        frame = frame + 1
        if frame > num_of_frames then frame = 1 end
    -- East
    elseif love.keyboard.isDown(string.lower(playerRight)) then
        Player.xdelt = Player.speed
        --(Bagares) Animation Parameters
        frame_angle = 90
        frame = frame - 1
        if frame <= 0 then frame = 8 end
    else
        -- Player Idle State
        Player.xdelt = 0
    end

    -- South East
    if Player.xdelt > 0 and Player.ydelt > 0 then
        --(Bagares) Animation Parameters
        frame_angle = 135
        frame = frame + 1
        if frame > num_of_frames then frame = 1 end

    -- North west
    elseif Player.xdelt < 0 and Player.ydelt < 0 then
        --(Bagares) Animation Parameters
        frame_angle = 315
        frame = frame + 1
        if frame > num_of_frames then frame = 1 end
  
    -- South West
    elseif Player.xdelt < 0 and Player.ydelt > 0 then
        --(Bagares) Animation Parameters
        frame_angle = 225
        frame = frame + 1
        if frame > num_of_frames then frame = 1 end

    -- North East
    elseif Player.xdelt > 0 and Player.ydelt < 0 then
        --(Bagares) Animation Parameters
        frame_angle = 45
        frame = frame + 1
        if frame > num_of_frames then frame = 1 end
    end

    -- [[ Change in delta and computing it to Player.x and Player.y ]]
    --(Bagares)Condition1: X-coord Movement and Border Detect
    if Player.xdelt < 0 then
        Player.x = math.max(0, Player.x + Player.xdelt * dt)
    else
        Player.x = math.min(VIRTUAL_WIDTH - Player.width, Player.x + Player.xdelt * dt)
    end

    --(Bagares)Condition2:  Y-Coord Movement and Border Detect
    if Player.ydelt < 0 then
        Player.y = math.max(0, Player.y + Player.ydelt * dt)
    else
        Player.y = math.min(VIRTUAL_HEIGHT - Player.height, Player.y + Player.ydelt * dt)
    end

    -- Border Check
    if Player.x >= VIRTUAL_WIDTH or Player.x <= 0 then
        Player.xdelt = 0
    end
    
    if Player.y >= VIRTUAL_HEIGHT or Player.x <= 0 then
        Player.ydelt = 0
    end
end

function Player.render()
    --love.graphics.setColor(0,0,0,1)
    --love.graphics.rectangle('fill', Player.x, Player.y, Player.width, Player.height)
    love.graphics.draw(gTextures['player_atlas'], gQuads['player'][frame], Player.x + 10, Player.y + 5, math.rad(frame_angle), 1, 1, 31, 31)

    love.graphics.setColor(0,0,1,1)
    love.graphics.circle('line', Player.x + (Player.width / 2), Player.y + (Player.height / 2), Player.radius)
end
