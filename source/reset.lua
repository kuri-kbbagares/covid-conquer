reset = Class{}

function reset()
    Player.x = VIRTUAL_WIDTH / 2
    Player.y = VIRTUAL_HEIGHT / 2

    Scoring.score = 0
    Scoring.combo = 0
    Scoring.time = 0
    Scoring.virus = 0

    virusDamage = 0
    MENU = false


    for i, v in ipairs(virus) do
        virus[i] = nil
    end
end


