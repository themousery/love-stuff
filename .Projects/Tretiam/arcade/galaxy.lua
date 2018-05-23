galaxies = {}
Galaxy = {}
function Galaxy:new()
  o = {}
  o.img = img.galaxy[random(2)]
  o.color = {random(255),random(255),random(255),75}
  o.x = random(width)
  o.y = -o.img:getHeight()
  o.speed = random(1,3)
  setmetatable(o,self)
  self.__index = self
  table.insert(galaxies, o)
end
function Galaxy:update(i)
  if slomo then
    self.y=self.y+self.speed/10
  else
    self.y=self.y+self.speed
  end
  if self.y>height then
    table.remove(galaxies,i)
    Galaxy:new()
  end
end
function Galaxy:draw()
  love.graphics.setColor(self.color)
  love.graphics.draw(self.img,self.x,self.y)
  love.graphics.setColor(white)
end
for i=1,2 do
  Galaxy:new()
end