UFO = Vehicle:new()
UFO.actions = {
  function(self) --1
    self:follow(alien_path)
  end,
}
function UFO:new(ai, x, y)
  --x and y are optional; ai is what they do
  local o = {
    maxspeed = random(6,8),
    maxforce = 0.2,
    pos = Vector:new(x or matt.math.choice({-81,width}), y or random(0,100)),
    hp = 3,
    born = frameCount,
    type = "ufo",
    ai = ai
  }
  
  if o.pos.x == -81 then
    o.currentNode = 2
  end
  
  o.width, o.height = img.ufo:getDimensions()
  
  setmetatable(o,self)
  self.__index = self
  table.insert(aliens, o)
end

function UFO:update(i)
  --death
  if self.hp <= 0 then
    table.remove(aliens, i)
    score = score+10
    level.aliensKilled = level.aliensKilled+1
    matt.sfx.play("explosion")
  end
  
  --action based on ai
  self.actions[self.ai](self)
  self:updatePhysics()
  
  --shoot every 30 frames
  if not self.dontFire and (frameCount-self.born) % 30 == 0 then
    Laser:new(self.pos.x+self.width/2, self.pos.y+self.height, 2)
  end
end

function UFO:draw()
  love.graphics.setColor(white)
  love.graphics.draw(img.ufo,self.pos.x,self.pos.y)
end