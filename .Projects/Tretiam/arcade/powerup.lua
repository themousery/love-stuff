Powerup = {}
function Powerup:new()
  o = {
    speed = random(7,10),
    x = random(width),
    y = -30}
  setmetatable(o,self)
  self.__index = self
  return o
end
function Powerup:update(i)
  if self.y >= width then
    table.remove(powerups,i)
  end
  if slomo then
    self.y = self.y + self.speed/10
  else
    self.y = self.y + self.speed
  end
end
function Powerup:draw()
  love.graphics.draw(img.heart,self.x,self.y)
end
