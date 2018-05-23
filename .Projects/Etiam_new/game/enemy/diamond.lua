Diamond = Vehicle:new()

function Diamond:new()
  local o = {
    maxspeed = 6,
    maxforce = 0.1,
    type = "diamond",
    pos = Vector:new(random(width),random(height)),
    offset = true
  }
  o.width, o.height = img.diamond:getDimensions()
  setmetatable(o,self)
  self.__index = self
  table.insert(aliens, o)
end

function Diamond:update(i)
  if self.pos.x>width+30 then self.pos.x=-30 end
  if self.pos.x<-30 then self.pos.x=width+30 end
  if self.pos.y>height+30 then self.pos.y=-30 end
  if self.pos.y<-30 then self.pos.y=height+30 end
  self:flock()
  self:updatePhysics()
end

function Diamond:draw()
  local theta = math.atan2(self.vel.y, self.vel.x)+math.pi/2
  love.graphics.draw(img.diamond, self.x, self.y, theta,1,1,self.width/2,self.height/2)
  if matt.debug then 
    local x,y = self.x+self.width/2, self.y+self.height/2
    love.graphics.line(x, y, self.vel.x+x, self.vel.y+y)
  end
end