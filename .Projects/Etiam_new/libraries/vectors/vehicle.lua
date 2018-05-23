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

function Vehicle:seperate()
  local desired_sep = 75
  local sum = Vector:new(0,0)
  local count = 0
  for i,v in ipairs(aliens) do
    if v.type == self.type then
      local d = Vector.dist(self.pos, v.pos)
      if d>0 and d<desired_sep then
        local diff = Vector.sub(self.pos, v.pos)
        diff:setMag(d)
        sum = Vector.add(sum, diff)
        count = count + 1
      end
    end
  end
  
  if count>0 then
    sum:div(count)
    sum:setMag(self.maxspeed)
    local steer = Vector.sub(sum, self.vel)
    steer:limit(self.maxforce)
    return steer
  else
    return Vector:new(0,0)
  end
end

function Vehicle:align()
  local dist = 500
  local sum = Vector:new(0,0)
  local boids = 0
  for i,v in ipairs(aliens) do
    if v.type == self.type then
      local d = Vector.dist(self.pos, v.pos)
      if d>0 and d<dist then
        sum = Vector.add(sum, v.vel)
        boids = boids + 1
      end
    end
  end
  if boids>0 then 
    sum:div(boids)
    sum:setMag(self.maxspeed)
    local steer = Vector.sub(sum, self.vel)
    steer:limit(self.maxforce)
    return steer
  else
    return Vector:new(0,0)
  end
end

function Vehicle:cohesion(type)
  local dist = 500
  local sum = Vector:new(0,0)
  local count = 0
  for i,v in ipairs(aliens) do
    if v.type == self.type then
      local d = Vector.dist(self.pos, v.pos)
      if d>0 and d<dist then
        sum = Vector.add(sum, v.pos)
        count = count + 1
      end
    end
  end
  
  if count>0 then
    sum:div(count)
    local desired = Vector.sub(sum, self.pos)
    desired:setMag(self.maxspeed)
    local steer = Vector.sub(desired,self.vel)
    steer:limit(self.maxforce)
    return steer
  else
    return Vector:new(0,0)
  end
end

function Vehicle:flock()
  local sep = self:seperate()
  local ali = self:align()
  local coh = self:cohesion()
  
  sep:mult(1.5)
  
  self.acc = Vector.add(self.acc, sep)
  self.acc = Vector.add(self.acc, ali)
  self.acc = Vector.add(self.acc, coh)
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
    desired:setMag(matt.math.map(ddist,0,s,0,self.maxspeed))
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
