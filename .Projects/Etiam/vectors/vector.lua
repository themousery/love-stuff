Vector = {}

function Vector:new(x,y)
  o = {}
  o.x = x
  o.y = y
  setmetatable(o,self)
  self.__index = self
  return o
end

function Vector:set(x,y)
  self.x=x
  self.y=y
end

function Vector.add(v1, v2)
  return Vector:new(v1.x+v2.x,v1.y+v2.y)
end

function Vector.sub(v1,v2)
  return Vector:new(v1.x-v2.x,v1.y-v2.y)
end

function Vector:mult(scalar)
  self.x=self.x*scalar
  self.y=self.y*scalar
end

function Vector:div(scalar)
  self.x=self.x/scalar
  self.y=self.y/scalar
end

function Vector:getMag()
  return math.sqrt(self.x^2 + self.y^2)
end

function Vector:normalize()
  local m = self:getMag()
  if m~=0 then
    self:div(m)
  end
end

function Vector:setMag(mag)
  self:normalize()
  self:mult(mag)
end

function Vector.random()
  return Vector:new(math.random(),math.random())
end

function Vector:equals(v)
  return v.x==self.x and v.y==self.y
end

function Vector:copy()
  return Vector:new(self.x,self.y)
end

function Vector:dist(v)
  return math.sqrt((v.x-self.x)^2 + (v.y-self.y)^2)
end

function Vector:magSq()
  return self.x^2 + self.y^2
end

function Vector:limit(max)
  local mSq = self:magSq()
  if mSq > max^2 then
    self:normalize()
    self:mult(max)
  end
end

function Vector:dot(v)
  return self.x * v.x + self.y * v.y
end