UFO = Vehicle:new()
UFO.actions = {
  function(self) --1
    self.maxspeed=11
    self.maxforce=2
    self:circle(Vector:new(player.x, player.y),150)
  end,
  function(self) --2
    self:follow(alienpath)
  end,
  function(self) --3
    self:arrive(Vector:new(player.x, player.y-300))
  end,
  function(self) --4
    ticker=ticker+1
    self.i = ticker
    self.maxspeed=11
    self.maxforce=2
    self:circle(Alminus.center,150)
    self.dontFire = true
  end
}
function UFO:new(fleet,x,y)
  local o = {
    maxspeed = random(6,8),
    maxforce = 0.2,
    pos = Vector:new(x or choice({-81,width}),y or random(0,100)),
    hp = 1,
    born = frameCount,
    swooptarget = Vector:new(width/2,300),
    swooping = false,
    type="ufo",
    fleet=fleet}
  if o.pos.x == -81 then
    o.currentNode = 2
  end
  o.tmaxspeed = o.maxspeed
  o.width,o.height = img.ufo:getDimensions()
  setmetatable(o,self)
  self.__index = self
  table.insert(aliens, o)
end

function UFO:update(i)
  if self.hp<=0 then
    table.remove(aliens,i)
    score=score+10
    level.aliensKilled=level.aliensKilled+1
    sound.explosion:rewind()
    sound.explosion:play()
    Particle:new("fire",self.x+self.width/2, self.y+self.height/2)
    if self.fleet == 4 then Alminus.followers = Alminus.followers-1 end
  end
  self.actions[self.fleet](self)
  self:updatePhysics()
  if not self.dontFire and (frameCount-self.born) % 30 == 0 and not slomo then
    table.insert(blasers,Laser:new(self.pos.x+self.width/2,self.pos.y+self.height,2))
  end
end

function UFO:draw()
  love.graphics.setColor(white)
  love.graphics.draw(img.ufo,self.pos.x,self.pos.y)
  love.graphics.setColor(white)
end

species_colors = {{237,67,55},{237,160,67}}
species_speed = {10,7}
Bug = Vehicle:new()
function Bug:new(x,y)
  local o = {}
  o.offset = true
  o.species = random(1,2)
  o.width,o.height = img.bug[1]:getDimensions()
  o.pos = Vector:new(x or choice({-o.width,width}), y or random(height/2))
  o.maxspeed = species_speed[o.species]
  o.maxforce = 0.1
  o.target = Vector:new(player.x, player.y)
  o.hp = 1
  o.type = "bug"
  setmetatable(o,self)
  self.__index = self
  table.insert(aliens, o)
end

function Bug:update(i)
  if slomo then
    self.target = Vector:new(width/2, height+50)
    self.maxspeed = species_speed[self.species]/10
    self.maxforce=0.1/10
  else
    self.target = Vector:new(player.x,player.y)
    self.maxspeed = species_speed[self.species]
    self.maxforce=0.1
  end
  self:seek(self.target)
  self:updatePhysics()
  if self.hp<= 0 then
    Particle:new("fire",self.x, self.y)
    level.aliensKilled=level.aliensKilled+1
    table.remove(aliens,i)
    score = score+10
  end
end

function Bug:draw()
  love.graphics.setColor(species_colors[self.species])
  theta = math.atan2(self.vel.y, self.vel.x)+math.pi/2
  love.graphics.draw(img.bug[math.floor((frameCount%30)/10)+1],self.pos.x,self.pos.y,theta,1,1,self.width/2,self.height/2)
end