reset = Class{}

function reset()
    Player.x = VIRTUAL_WIDTH / 2
    Player.y = VIRTUAL_HEIGHT / 2

    Scoring.score = 0
    Scoring.combo = 0
    Scoring.time = 0
    Scoring.virus = 0

    virusDamage = 0
    virus.wave = 0
    virus.speed = 1000

    -- (BAGARES) constants for min value and max value of spawning veerus
    minValueToSpawn = 3
    maxValueToSpawn = 5

    MENU = false

    for i, v in ipairs(virus) do
        virus[i] = nil
    end
end


