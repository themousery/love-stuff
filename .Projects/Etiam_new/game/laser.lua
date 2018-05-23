-- Lasers
Laser = {colors = {{100,75,255},{255,100,75}}}


function Laser:new(x, y, type, bigboi)
  o = {type = type, x = x, y = y, width=3, height=12}
  
  -- for Alminus
  if bigboi then
    o.width=6
    o.height=24
  end
  
  setmetatable(o,self)
  self.__index = self
  
  --plop those lasers in the right table
  if o.type == 1 then table.insert(glasers, o)
  else table.insert(blasers, o) end
end


function Laser:update(i)
  -- good lasers, they go up.
  if self.type == 1 then
    self.y = self.y - 10
    if self.y <= -10 then table.remove(glasers,i) end
  end
  
  -- bad lasers, they go down.  
  if self.type == 2 then
    self.y = self.y + 10
    if self.y >= width then table.remove(blasers,i) end
  end
end


function Laser:draw()
  love.graphics.setColor(self.colors[self.type])
  love.graphics.rectangle("fill",self.x,self.y,self.width,self.height)
  love.graphics.setColor(white)
end
