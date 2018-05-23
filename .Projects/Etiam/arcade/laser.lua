laser_colors = {{100,75,255},{255,100,75}}
Laser = {}
function Laser:new(x_, y_, type_, bigboi)
  o = {type = type_, x = x_, y = y_, width=3,height=12}
  if bigboi then
    o.width=6
    o.height=24
  end
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
      table.remove(glasers,i)
    end
  elseif self.type == 2 then
    if slomo then
      self.y = self.y + 1
    else
      self.y = self.y + 10
    end
    if self.y >= width then
      table.remove(blasers,i)
    end
  end
end
function Laser:draw()
  love.graphics.setColor(laser_colors[self.type])
  love.graphics.rectangle("fill",self.x,self.y,self.width,self.height)
  love.graphics.setColor(white)
end
