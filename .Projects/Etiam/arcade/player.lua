player = {x=width/2,y=height/2,img=img.ship,speed=8,laser=false,triple=false,nolimits=false,cooldown=100}
function player:update()
  if not self.laser and love.keyboard.isDown(controls.fire) and (frameCount-fireStarted)%20==0 then
    self:fire()
  end
  self.width, self.height = self.img[1]:getDimensions()
  if not slomo then
    if self.cooldown<100 then self.cooldown = self.cooldown+0.5 end
    if self.hp<=0 then
      slomo=true
      died = frameCount
    end
    if love.keyboard.isDown(controls.right) then
      self.x=self.x+self.speed
    end
    if love.keyboard.isDown(controls.left) then
      self.x=self.x-self.speed
    end
    if love.keyboard.isDown(controls.up) then
      self.y=self.y-self.speed
    end
    if love.keyboard.isDown(controls.down) then
      self.y=self.y+self.speed
    end
    if gamepad ~= nil and not keyboardInput then
      sticky = gamepad:getGamepadAxis("lefty")
      stickx = gamepad:getGamepadAxis("leftx")
      if sticky > 0.2 or sticky < 0.2 then
        self.y=self.y+sticky*self.speed
      end
      if stickx > 0.2 or stickx < 0.2 then
        self.x=self.x+stickx*self.speed
      end
    end
    if self.x>width-self.width then
      self.x=width-self.width
    end
    if self.x<0 then
      self.x=0
    end
    if self.y>height-self.height then
      self.y=height-self.height
    end
    if self.y<0 then
      self.y=0
    end
  end
end
function player:draw()
  love.graphics.setColor(white)
  if self.laser and love.keyboard.isDown(controls.fire) then
    laserx,laserw = player.x+player.width/2-img.laser:getWidth()/2,img.laser:getWidth()
    for i=1,30 do
      love.graphics.draw(img.laser, laserx, player.y+player.height/2-i*img.laser:getHeight())
    end
    laser_vec = Vector:new(laserx,0)
    laser_vec.width = laserw
    laser_vec.height = player.y
  end
  love.graphics.draw(frame(img.ship,4),self.x,self.y)
  if self.triple then 
    love.graphics.draw(frame(img.triple_ship,4),self.x,self.y)
  end
  if self.cooldown<100 then
    love.graphics.setColor(100,75,255)
    love.graphics.rectangle("fill",self.x+self.width+3,self.y+map(self.cooldown,0,100,self.height,0),3,map(self.cooldown,0,100,0,self.height))
  end
end

function player:hurt()
  if not bleed then
    self.hp=self.hp-1
    sound.hit:rewind()
    sound.hit:play()
    bleed=true
  end
end

function player:fire()
  if not doingDialogue and (player.nolimits or player.cooldown>=10) then
    if not player.nolimits then player.cooldown=player.cooldown-10 end
    table.insert(glasers, Laser:new(player.x+player.width/2-1,player.y,1))
    sound.laser:rewind()
    sound.laser:play()
    if player.triple then
      table.insert(glasers, Laser:new(player.x+6,player.y+18,1))
      table.insert(glasers, Laser:new(player.x+48,player.y+18,1))
    end
  end
end