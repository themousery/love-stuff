Laser = {}
function Laser:new(x_, y_, type_)
  o = {type = type_, x = x_, y = y_}
  setmetatable(o,self)
  self.__index = self
  return o
end
function Laser:update(i)
  if self.type == 1 then
    if slomo then
      self.y = self.y - 1
    else
      self.y = self.y - 10
    end
    if self.y <= -10 then
      table.remove(lasers,i)
    end
  elseif self.type == 2 then
    if slomo then
      self.y = self.y + 1
    else
      self.y = self.y + 10
    end
    if self.y >= width then
      table.remove(lasers,i)
    end
  end
end
function Laser:draw()
  love.graphics.setColor(laser_colors[self.type])
  love.graphics.rectangle("fill",self.x,self.y,3,10)
  love.graphics.setColor(white)
end
