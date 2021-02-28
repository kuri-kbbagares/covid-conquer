Virus = Class{}

-- (BAGARES) constants for min value and max value of spawning veerus
minValueToSpawn = 3
maxValueToSpawn = 5

--(BAGARES) Variables needed for virus to spawn
virus = {} --(Bagares)Table1: for storing the number of virus
virus.timeSpawn = 0
virus.timerSpawnLimit = math.random(3,5)
virus.amount = math.random(minValueToSpawn, maxValueToSpawn)

---(BAGARES) Virus Class Parameters
virus.radius = 20
virus.damage = 0

virus.speed = 500
virus.friction = 7.5

virus.width = 15
virus.height = 15

virus.increase = 30

function virus.spawn(x, y)
    table.insert(virus, {x = x, y = y, xdelt = 0, ydelt = 0, radius = virus.radius})
end

function generateVirus(dt)
    virus.timeSpawn = virus.timeSpawn + dt

    -- Virus will increase and its speed every 30 seconds
    -- It takes me time to figure this out because lua's modulus(%) was so bad
    virus.increase = virus.increase - dt
    if math.floor(virus.increase) == 0 then
        minValueToSpawn = minValueToSpawn + 3
        maxValueToSpawn = maxValueToSpawn + 3
        virus.speed = virus.speed + 200

        -- Reset the timer again
        virus.increase = 30
    end


    if virus.timeSpawn > virus.timerSpawnLimit then
        for i = 1, virus.amount do

            -- [Pandan] Is this should be the spawn behavior for our virus?
            local spawnLocation = math.random(1, 4)

            -- Spawn on Top
            if spawnLocation == 1 then virus.spawn(math.random(0, VIRTUAL_WIDTH), math.random(-10, -20))
            
            -- Spawn on Bottom
            elseif spawnLocation == 4 then virus.spawn(math.random(0, VIRTUAL_WIDTH), math.random(VIRTUAL_HEIGHT + 10, VIRTUAL_HEIGHT + 40))
            
            -- Spawn on Left
            elseif spawnLocation == 2 then virus.spawn(math.random(-10, 20), math.random(0, VIRTUAL_HEIGHT))
            
            -- Spawn on Right
            elseif spawnLocation == 3 then virus.spawn(math.random(VIRTUAL_WIDTH + 10, VIRTUAL_WIDTH + 40), math.random(0, VIRTUAL_HEIGHT))

            end

            virus.timerSpawnLimit = math.random(3, 5)
            virus.amount = math.random(minValueToSpawn, maxValueToSpawn)
            virus.timeSpawn = 0
        end
    end
end

function virus.AI(dt)
    for i, v in ipairs(virus) do
        -- x-axis
        if Player.x + Player.width/2 < v.x + v.radius/2 then
            if v.xdelt > -virus.speed then
                v.xdelt = v.xdelt - virus.speed * dt
            end
        end

        if Player.x + Player.width/2 > v.x + v.radius / 2 then
            if v.xdelt < virus.speed then
                v.xdelt = v.xdelt + virus.speed * dt
            end
        end

        -- y-axis
        if Player.y + Player.height/2 < v.y + v.radius / 2 then
            if v.ydelt > -virus.speed then
                v.ydelt = v.ydelt - virus.speed * dt
            end
        end

        if Player.y + Player.height/2 > v.y + v.radius / 2 then
            if v.ydelt < virus.speed then
                v.ydelt = v.ydelt + virus.speed * dt
            end
        end

        if math.floor(v.x)  == math.floor(Player.x) and math.floor(v.y) == math.floor(Player.y)  then
            -- (BAGARES) Damages Player
            virusDamage = virusDamage + 1
        end
    end

end

function virus.movement(dt)
    for i, v in ipairs(virus) do
        v.x = v.x + v.xdelt * dt
        v.y = v.y + v.ydelt * dt
        v.xdelt = v.xdelt * (1 - math.min(dt*virus.friction, 1))
        v.ydelt = v.ydelt * (1 - math.min(dt*virus.friction, 1))
    end
end

function virus.draw()
    love.graphics.setColor(255, 255, 255, 255)

    for i, v in ipairs(virus) do
        love.graphics.draw(gTextures['virus'], v.x - 20, v.y - 20)

        love.graphics.circle('line', v.x, v.y, v.radius)
    end
end

function virusUpdate(dt)
    generateVirus(dt)

    virus.movement(dt)
    virus.AI(dt)
end

function virusRender()
    virus.draw()
end