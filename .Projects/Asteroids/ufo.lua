Alien = {}

function Alien:new()
  s = {-81,love.graphics.getWidth()}
  o = {
    x = s[love.math.random(#s)],
    y = love.math.random(10,300),
    speed = love.math.random(7,11),
    born = frameCount,
    hp = 3,}
  setmetatable(o,self)
  self.__index = self
  return o
end

function Alien:update(i)
  if self.x <= 0 then
    self.speed = math.abs(self.speed)
  elseif self.x >= love.graphics.getWidth()-81 then
    self.speed = -math.abs(self.speed)
  end
  self.x = self.x + self.speed
  if (frameCount-self.born) % 30 == 0 then
    table.insert(alasers,ALaser:new(self.x+39,self.y))
  end
  for j,laser in ipairs(lasers) do
    if colliderect(self.x,self.y,81,42,laser.x,laser.y,3,10) then
      explode:rewind()
      explode:play()
      self.hp = self.hp - 1
      table.remove(lasers,j)
    end
  end
  if self.hp <= 0 then
    table.remove(aliens,i)
    score = score + 10
  end
end

function Alien:draw()
  love.graphics.draw(ufo_img,self.x,self.y)
  love.graphics.setColor(255,255,255,100)
  love.graphics.rectangle("fill",self.x,self.y-5,81,3)
  love.graphics.setColor(255,255,255,255)
  if self.hp == 3 then
    love.graphics.setColor(0,255,0)
    love.graphics.rectangle("fill",self.x,self.y-5,81,3)
  elseif self.hp == 2 then
    love.graphics.setColor(255,165,0)
    love.graphics.rectangle("fill",self.x,self.y-5,54,3)
  elseif self.hp == 1 then
    love.graphics.setColor(255,0,0)
    love.graphics.rectangle("fill",self.x,self.y-5,27,3)
  end
  love.graphics.setColor(255,255,255)
end
