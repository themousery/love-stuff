Asteroid = {}

function Asteroid:new()
  o = {}
  setmetatable(o,self)
  self.__index = self

  o.img = asteroid_imgs[love.math.random(#asteroid_imgs)]
  o.speed = love.math.random(7,10)
  o.x = love.math.random(love.graphics.getWidth())
  o.y = -46

  return o
end

function Asteroid:update(i)
  self.y = self.y + self.speed

  if colliderect(self.x,self.y,self.img:getWidth(),self.img:getHeight(),player.x,player.y,44,70) then
    player.hp = player.hp - 1
    hit:play()
    table.remove(asteroids, i)
  end
  if self.y > love.graphics.getWidth() then
    table.remove(asteroids, i)
  end
end

function Asteroid:draw()
  love.graphics.draw(self.img, self.x, self.y)
end
