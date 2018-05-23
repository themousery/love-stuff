Thing = {}
function Thing:new()
  o = {}
  o.x = love.math.random(width/2-100-10,width/2-100+200)
  o.y = love.math.random(100,300)
  o.alpha = 255
  setmetatable(o,self)
  self.__index = self
  return o
end
function Thing:update(i)
  self.y = self.y - 2
  self.alpha = self.alpha - 10
  if self.alpha <= 0 then
    table.remove(things, i)
  end
end
function Thing:draw()
  love.graphics.setColor(255,255,255,self.alpha)
  love.graphics.print("+"..save[currentSave][4], self.x, self.y)
end
