Power = {}

function Power:new()
  o = {
    x = love.math.random(love.graphics.getWidth()),
    y = -30,
    speed = love.math.random(7,10),
  }
  setmetatable(o,self)
  self.__index = self
  return o
end

function Power:update(i)
  self.y = self.y + self.speed
  if colliderect(self.x,self.y,32,30,player.x,player.y,44,70) then
    table.remove(powerups,i)
    powerup_sound:rewind()
    powerup_sound:play()
    player.hp = player.hp + 1
  end
end

function Power:draw()
  love.graphics.draw(heart,self.x,self.y)
end
