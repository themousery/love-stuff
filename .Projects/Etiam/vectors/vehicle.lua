Vehicle = {}
function Vehicle:new(o)
  local o = o or {}
  o.acc = Vector:new(0,0)
  o.vel = Vector:new(0,0)
  o.x = 0
  o.y = 0
  o.currentNode=1
  o.pathDir = 1
  setmetatable(o,self)
  self.__index = self
  return o
end

function Vehicle:seek(target)
  local desired = Vector.sub(target, self.pos)
  desired:setMag(self.maxspeed)
  
  local steer = Vector.sub(desired,self.vel)
  steer:limit(self.maxforce)
  
  self.acc = Vector.add(self.acc, steer)
end

function Vehicle:avoid(target)
  local desired = Vector.sub(self.pos, target)
  desired:setMag(self.maxspeed)
  
  local steer = Vector.sub(desired,self.vel)
  steer:limit(self.maxforce)
  
  self.acc = Vector.add(self.acc, steer)
end

function Vehicle:follow(path)
  local target = path.nodes[self.currentNode]
  if self.pos:dist(target) <= path.radius then
    self.currentNode = self.currentNode+self.pathDir
    if self.currentNode > #path.nodes or self.currentNode <= 0 then
      self.pathDir=-self.pathDir
      self.currentNode=self.currentNode+self.pathDir*2
    end
  end
  self:arrive(target)
end

function Vehicle:arrive(target, s)
  s = s or 150
  local desired = Vector.sub(target, self.pos)
  local ddist = desired:getMag()
  if ddist < s then
    desired:setMag(map(ddist,0,s,0,self.maxspeed))
  else
    desired:setMag(self.maxspeed)
  end
  
  local steer = Vector.sub(desired,self.vel)
  steer:limit(self.maxforce)
  
  self.acc = Vector.add(self.acc, steer)
end

function Vehicle:circle(target, radius)
  local theta = (2*math.pi)/Alminus.followers*self.i + frameCount/25
  local go = Vector:new(target.x + math.cos(theta)*radius, target.y + math.sin(theta)*radius)
  self:arrive(go,Alminus.maxspeed)
end

function Vehicle:updatePhysics()
  self.vel = Vector.add(self.vel, self.acc)
  self.vel:limit(self.maxspeed)
  self.pos = Vector.add(self.pos, self.vel)
  self.x, self.y = self.pos.x, self.pos.y
  self.acc:mult(0)
end
