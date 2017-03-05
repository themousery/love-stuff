Laser = {}

function Laser:new()
  o = {}
  setmetatable(o,self)
  self.__index = self
  o.x = player.x+21
  o.y = player.y+30
  return o
end

function Laser:update(i)
  self.y = self.y - 10
  if self.y < 0 then
    table.remove(lasers,i)
  end
  for j,asteroid in ipairs(asteroids) do
    if colliderect(self.x,self.y,3,10,asteroid.x,asteroid.y,asteroid.img:getWidth(),asteroid.img:getHeight()) then
      table.remove(lasers, i)
      table.remove(asteroids, j)
      explode:rewind()
      explode:play()
      score = score + 1
    end
  end
end

function Laser:draw()
  love.graphics.setColor(75, 10, 200)
  love.graphics.rectangle("fill", self.x, self.y, 3, 10)
  love.graphics.setColor(255,255,255)
end
