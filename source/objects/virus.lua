Virus = Class{}

virus = {} --(Bagares)Table1: for storing the number of virus
virus.timeSpawn = 0
virus.timerSpawnLimit = math.random(3,5)
--(Bagares) This can change dependently to player's score, or any other parameters. These values determine how many virus will spawn 
local maxValueSpawn = 3
local minValueSpawn = 7

virus.amount = math.random(minValueSpawn, maxValueSpawn)

virus.radius = 20
virusDamage = 0

virus.speed = 500
virus.friction = 7.5

virus.width = 20
virus.height = 20


function virus.spawn(x, y)
  table.insert(virus, {x = x, y = y, xdelt = 0, ydelt = 0, radius = virus.radius})
end

function generateVirus(dt)
  virus.timeSpawn = virus.timeSpawn + dt
  if virus.timeSpawn > virus.timerSpawnLimit then
    for i=1, virus.amount do
      virus.spawn(VIRTUAL_WIDTH/2 - 25, math.random(-25, -100))
    end
    virus.timerSpawnLimit= math.random(3,5)
    virus.timeSpawn = 0
    virus.amount = math.random(minValueSpawn, maxValueSpawn)
  end
end

function virus.AI(dt)
  for i, v in ipairs(virus) do
    --x-axis
    if Player.x + Player.width/2 < v.x + v.radius / 2 then
      if v.xdelt > -virus.speed then
        v.xdelt = v.xdelt - virus.speed * dt
      end
    end
    
    if Player.x + Player.width/2 > v.x + v.radius / 2 then
      if v.xdelt < virus.speed then
        v.xdelt = v.xdelt + virus.speed * dt
      end
    end
    
    --y-axis
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
  
  
    if math.floor(v.x) == math.floor(Player.x) and math.floor(v.y)  == math.floor(Player.y)  then
    --(BAGARES) damages player
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
  for i, v in ipairs(virus) do
    love.graphics.setColor(0, 0, 0, 1)
    love.graphics.circle('line', v.x, v.y, v.radius)
  end
end


--Main Function (in main)

function virusUpdate(dt)
  generateVirus(dt)
  virus.movement(dt)
  virus.AI(dt)
  
end

function virusRender()
  virus.draw()

end