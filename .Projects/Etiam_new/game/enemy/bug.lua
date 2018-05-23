Bug = Vehicle:new()
function Bug:new(x,y)
  --x and y are optional
  local o = {
    offset = true,
    hue = random(255),
    maxspeed = 10,
    maxforce = 0.2,
    hp = 1,
    type = "bug"
  }
  o.width,o.height = img.bug[1]:getDimensions()
  o.pos = Vector:new(x or matt.math.choice({-o.width,1366}), y or random(768/2)),
  
  setmetatable(o,self)
  self.__index = self
  table.insert(aliens, o)
end

function Bug:update(i)
  --move toward player
  self.target = Vector:new(player.x,player.y)
  self:seek(self.target)
  self:updatePhysics()
  
  --death
  if self.hp <= 0 then
    -- Particle:new("fire",self.x, self.y)
    level.aliensKilled=level.aliensKilled+1
    table.remove(aliens,i)
    score = score+10
  end
  
  self.hue = self.hue+1
  if self.hue>255 then self.hue = 0 end
end

function Bug:draw()
  --this is pretty juicy but basically it draws it at the angle of it's velocity
  -- love.graphics.setColor(HSL(self.hue, 255, 255))
  love.graphics.setColor(HSL(self.hue,100,100))
  theta = math.atan2(self.vel.y, self.vel.x)+math.pi/2
  love.graphics.draw(img.bug[math.floor((frameCount%30)/10)+1],self.pos.x,self.pos.y,theta,1,1,self.width/2,self.height/2)
end