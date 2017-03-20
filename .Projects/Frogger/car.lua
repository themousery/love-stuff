Car = {}

function Car:new()
  o = {y = love.math.random(5), x = 0}
  setmetatable(o,self)
  self.__index = self
  return o
end

function Car:update()
  self.x = self.x + 1
end
