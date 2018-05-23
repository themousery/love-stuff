s = {-81,width}
Alien = {}
function Alien:new()
  o = {
    x = s[random(#s)],
    y = random(10,150),
    speed = random(7,10),
    hp = 3,
    born = frameCount}
  o.width = img.ufo:getWidth()
  setmetatable(o,self)
  self.__index = self
  return o
end
function Alien:update(i)
  if self.hp <= 0 then
    table.remove(aliens,i)
    newExplosion(self.x+40,self.y+21)
    score = score + 10
  end
  if self.x >= width-81 and not slomo then
    self.speed = -math.abs(self.speed)
  elseif self.x <= 0 and not slomo then
    self.speed = math.abs(self.speed)
  end
  if slomo then
    if self.x >= width/2 then
      self.speed = math.abs(self.speed)
    else
      self.speed = -math.abs(self.speed)
    end
  end
  if slomo then
    self.x = self.x + self.speed/10
  else
    self.x = self.x + self.speed
  end
  if (frameCount-self.born) % 30 == 0 and not slomo then
    table.insert(lasers,Laser:new(self.x+40,self.y,2))
  end
end
function Alien:draw()
  love.graphics.draw(img.ufo,self.x,self.y)
  love.graphics.setColor(255,255,255,100)
  love.graphics.rectangle("fill",self.x,self.y-5,self.width,3)
  love.graphics.setColor(white)
  if self.hp == 3 then
    love.graphics.setColor(0,255,0)
    love.graphics.rectangle("fill",self.x,self.y-5,self.width,3)
  elseif self.hp == 2 then
    love.graphics.setColor(255,165,0)
    love.graphics.rectangle("fill",self.x,self.y-5,self.width*(2/3),3)
  elseif self.hp == 1 then
    love.graphics.setColor(255,0,0)
    love.graphics.rectangle("fill",self.x,self.y-5,self.width*(1/3),3)
  end
  love.graphics.setColor(white)
end
