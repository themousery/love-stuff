Alminus = {
  hp=100,
  maxspeed=5,
  maxforce=0.05,
  width=img.alminus:getWidth(),
  height=img.alminus:getHeight(),
  light_colors={{161,0,2},{219,0,3}},
  animations={
    shield = {{1,0,0},{1,1,0},{1,1,1}},
    normal_shot = {{1,0,0},{0,1,0},{0,0,1},{0,1,0}},
    big_laser = {{1,1,0},{0,1,1}},
    side_lasers = {{1,0,1},{0,1,0}},
    standby = {{0,0,0}}
  }
}
Alminus = Vehicle:new(Alminus)
function Alminus:setup()
  self.animation=self.animations["standby"]
  self.pos = Vector:new((width-self.width)/2, -200)
  self.hp = 100
  self.center = Vector:new(self.pos.x+self.width/2, self.pos.y+self.height/2)
  self.path=Path:new({Vector:new(100,150),Vector:new(width-100-self.width,150)},25)
  self.followers = 0
end
function Alminus:update()
  self.x, self.y = self.pos.x, self.pos.y
  -- self.maxspeed = 5
  -- self.maxforce=0.05
  if level.dialogueTodo[6] and doingDialogue then
    self:arrive(Vector:new((width-self.width)/2,75))
  elseif not doingDialogue and not slomo and self.hp>0 then
    if self.animation == self.animations["standby"] then
      self.animation = self.animations["shield"]
    end
    
    if self.animation == self.animations["shield"] then
      self:follow(self.path)
      for i=1,15-self.followers do
        UFO:new(4,self.center.x+50,self.center.y+50)
        self.followers = self.followers+1
      end
      level.spawnWave()
      self.animation = self.animations["normal_shot"]
      self.animationStarted = frameCount
    end
    
    if self.animation == self.animations["normal_shot"] then
      self:follow(self.path)
      if frameCount%25==0 then
        table.insert(blasers, Laser:new(self.pos.x+self.width/2, self.pos.y+self.height-50, 2, true))
      end
      if frameCount-self.animationStarted>=600 and self.pos:dist(self.path.nodes[1])<self.path.radius then
        self.animation = self.animations["big_laser"]
      end
    end
    
    if self.animation == self.animations["big_laser"] then
      if colliderect(player.x,player.y,player.width,player.height,self.x+(self.width-img.alminus_laser[1]:getWidth())/2,self.y+self.height,img.alminus_laser[1]:getWidth(), height) then
        player:hurt()
      end
      if self.pos:dist(self.path.nodes[2])<self.path.radius then
        self.animation = self.animations["side_lasers"]
      end
    end
    
    if self.animation == self.animations["side_lasers"] then
      self.animation = self.animations["shield"]
    else
      self:follow(self.path)
    end
  end
  if self.hp < 0 then
    self.hp=0
  end
  if self.hp == 0 then
    table.foreach(aliens, function(k,v) v.hp=0 end)
    self.explosionStarted = frameCount
    self.hp=-1
  end
  self.center:set(self.pos.x+self.width/2-img.ufo:getWidth()/2, self.pos.y+self.height/2-img.ufo:getHeight()/2)
  self:updatePhysics()
end

function Alminus:draw()
  love.graphics.setColor(white)
  love.graphics.draw(img.alminus,self.pos.x,self.pos.y)
  love.graphics.draw(img.alminus_dots[math.floor((frameCount%40)/20)+1],self.pos.x,self.pos.y)
  local frame = math.floor((frameCount%(#self.animation*20))/20)+1
  for i,v in ipairs(img.alminus_lights) do
    love.graphics.setColor(self.light_colors[self.animation[frame][i]+1])
    love.graphics.draw(v, self.pos.x, self.pos.y)
  end
  if level.dialogueTodo[6] and not doingDialogue then
    love.graphics.setColor(0,255,0)
    love.graphics.setLineWidth(1)
    love.graphics.rectangle("fill", (width-img.boss_health:getWidth())/2+3, 35, map(self.hp, 0,100, 0,300), 12)
    love.graphics.setColor(white)
    if self.hp > 0 and self.animation == self.animations["big_laser"] then
      for i=0,30 do 
        love.graphics.draw(img.alminus_laser[math.floor((frameCount%30)/5)+1], self.x+(self.width-img.alminus_laser[1]:getWidth())/2, self.y+self.height+i*img.alminus_laser[1]:getHeight())
      end
    end
    love.graphics.draw(img.boss_health, (width-img.boss_health:getWidth())/2, 20)
    love.graphics.setFontSize(25)
    love.graphics.setColor(49,255,0)
    love.graphics.print("Alminus", (width-img.boss_health:getWidth())/2, 10)
    love.graphics.setColor(white)
  end
end

function Alminus:explode()
  local a = frameCount-self.explosionStarted
  if a==30 then
    Particle:new("fire", self.x,self.y)
    sound.explosion:play()
  elseif a==60 then
    Particle:new("fire", self.x+self.width,self.y)
    sound.explosion:play()
  elseif a==90 then
    Particle:new("fire", self.x+self.width,self.y+self.height)
    sound.explosion:play()
  elseif a==120 then
    Particle:new("fire", self.x,self.y+self.height)
    sound.explosion:play()
  elseif a==180 then
    Particle:new("bigboi", self.x+self.width/2,self.y+self.height/2)
    sound.big_explosion:play()
  elseif a==210 then
    self.hp=-2
  end
end