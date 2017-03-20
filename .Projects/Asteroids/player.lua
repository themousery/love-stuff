player = {hp = 3, x = 0, y = 0}
function player:update()
  self.x = love.mouse.getX()-22
  self.y = love.mouse.getY()-35
  for i,laser in ipairs(alasers) do
    if colliderect(self.x,self.y,44,70,laser.x,laser.y,3,10) then
      table.remove(alasers,i)
      hit:rewind()
      hit:play()
      self.hp = self.hp - 1
      bleed = true
    end
  end
end

function player:draw()
  love.graphics.draw(ship, self.x, self.y)
end
