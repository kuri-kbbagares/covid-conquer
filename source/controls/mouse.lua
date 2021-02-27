mouse = Class{}

function love.mousepressed(x, y, button)
  if button == 1 then
    click_count = click_count + 1
  end
end