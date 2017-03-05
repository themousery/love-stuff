player = {hp = 3}
function player:update()
  self.x = love.mouse.getX()-22
  self.y = love.mouse.getY()-35

end

function player:draw()
  love.graphics.draw(ship, self.x, self.y)
end
