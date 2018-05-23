playerhue = 0

Player = {x=362}

function Player:new(y)
  o = {}
  setmetatable(o, self)
  self.__index = self
  o.y = y
  return o
end

function Player:update(i)
end

function Player:draw(i)
  if i == 1 then
    love.graphics.setColor(165,0,255)
  else
    love.graphics.setColor(255,165,0)
  end
  love.graphics.rectangle("fill", self.x, self.y, 300, 35)
  love.graphics.setFont(scoreFont)
  if i == 1 then
    love.graphics.print(score[i], 930, 720)
  else
    love.graphics.scale(-1,-1)
    love.graphics.print(score[i], -200, -200)
  end
end

players = {Player:new(love.graphics.getHeight()-35), Player:new(0)}
