Asteroid = {}
function Asteroid:new()
  o = {}
  o.img = img.asteroid[random(3)]
  o.x = random(width)
  o.y = -o.img:getHeight()
  o.speed = random(7,10)
  setmetatable(o,self)
  self.__index = self
  return o
end
function Asteroid:update(i)
  if slomo then
    self.y = self.y + self.speed/10
  else
    self.y = self.y + self.speed
  end
  if self.y >= width then
    table.remove(asteroids,i)
  end
end
function Asteroid:draw()
  love.graphics.draw(self.img,self.x,self.y)
end
