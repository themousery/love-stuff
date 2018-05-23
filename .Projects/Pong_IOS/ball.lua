s = {-9,9,-10,10}
ball = {
  speed = {s[love.math.random(#s)],s[love.math.random(#s)]},
  x = 507,
  y = 379
}

function ball:update()
  self.x = self.x + self.speed[1]
  self.y = self.y + self.speed[2]
  if self.x >= 1014 then
    self.speed[1] = -math.abs(self.speed[1]) + love.math.random(-2,2)
  elseif self.x <= 0 then
    self.speed[1] = math.abs(self.speed[1]) + love.math.random(-2,2)
  end

  if self.y > 778 then
    score[1] = score[1] + 1
    buffer = true
    self.x = 507
    self.y = 379
    self.speed = {s[love.math.random(#s)],s[love.math.random(#s)]}
    love.system.vibrate()
  elseif self.y < 0 then
    score[2] = score[2] + 1
    buffer = true
    self.x = 507
    self.y = 379
    self.speed = {s[love.math.random(#s)],s[love.math.random(#s)]}
    love.system.vibrate()
  end

  for i,player in ipairs(players) do
    if colliderect(self.x,self.y,10,10,player.x,player.y,300,35) then
      self.speed[2] = -self.speed[2] + love.math.random(-2,2)
      beep:rewind()
      beep:play()
    end
  end
end

function ball:draw()
  love.graphics.setColor(210,83,128)
  love.graphics.rectangle("fill", self.x, self.y, 10, 10)
end
