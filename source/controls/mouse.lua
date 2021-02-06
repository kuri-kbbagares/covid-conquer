mouse = Class{}

function mouse:init(button_x, button_y, button_width, button_height)
  self.button_x = button_x
  self.button_y = button_y
  self.button_width = button_width
  self.button_height = button_height
  self.switch = false
end

function mouse:click(x, y, button)
  self.x = x
  self.y = y

  if button == 1 then
    if self.x > self.button_x and self.x < self.button_x + self.button_width and self.y > self.button_y and self.y < self.button_y + self.button_height then
      self.switch = not self.switch
    else
      click_count = click_count + 1
    end
    
  end
end


