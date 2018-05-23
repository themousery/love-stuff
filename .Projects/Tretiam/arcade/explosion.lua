Explosion = {}
function Explosion:new()
  o = {}
  o.born = frameCount
  setmetatable(o,self)
  self.__index = self
end