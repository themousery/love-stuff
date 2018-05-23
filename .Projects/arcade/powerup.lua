powerup_imgs = {img.heart,img.laserup,img.tripleup,img.nolimits,img.big_battery}

-- powerups will only spawn under certain conditions:
powerup_cond = {
  function() return player.hp < 10 end, --heart
  function() return not player.triple and not player.nolimits and not level.alminus end, --big laser
  function() return false end, --triple shot
  function() return not player.laser end, --nolimits
  function() return false end -- big battery, can only spawn under certain specified circumstances
}
Powerup = {}
function Powerup:new(x,y,type,speed)
  --let's make a list of possible powerups we can spawn:
  local available = {}
  for i,v in ipairs(powerup_cond) do
    if v() then table.insert(available, i) end
  end
  o = {
    speed = speed or random(6,7),
    x = x or random(10,width-20),
    y = y or -30,
    type = type or choice(available)}
  o.img = powerup_imgs[o.type]
  o.width,o.height = o.img:getDimensions()
  setmetatable(o,self)
  self.__index = self
  table.insert(powerups, o)
end
function Powerup:update(i)
  if not powerup_cond[self.type] then table.remove(powerups,i) end
  self.i = i
  self.y = self.y+self.speed
  if self.y >= width then
    table.remove(powerups,i)
  end
end
function Powerup:draw()
  love.graphics.setColor(white)
  love.graphics.draw(self.img,self.x,self.y)
end

function Powerup:activate()
  if self.type==1 then
    player.hp = player.hp + 1
  elseif self.type==2 then
    player.laser = true
    powerupStarted = frameCount
  elseif self.type==3 then
    player.triple = true
    powerupStarted = frameCount
  elseif self.type==4 then
    player.nolimits = true
    nolimitStarted = frameCount
  elseif self.type==5 then
    player.hp = 10
  end
  sound.powerup:play()
  table.remove(powerups,self.i)
end