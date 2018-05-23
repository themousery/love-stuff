player = {
  img=img.ship,
  speed=8,
  max_hp = 10
}

function player:setup()
  self.width, self.height = self.img[1]:getDimensions()
  self.hp = self.max_hp
  self.x, self.y = width/2, height/2
  self.laser, self.triple = false, false
end

function player:update()
  --auto fire
  if not self.laser and love.keyboard.isDown(controls.fire) and (frameCount-fireStarted)%10==0 then
    self:fire()
  end
  
  --death
  if self.hp<=0 then
    matt.graphics.transition(menu.dead)
  end
  
  --movement
  if love.keyboard.isDown(controls.right) then self.x=self.x+self.speed end
  if love.keyboard.isDown(controls.left) then self.x=self.x-self.speed end
  if love.keyboard.isDown(controls.up) then self.y=self.y-self.speed end
  if love.keyboard.isDown(controls.down) then self.y=self.y+self.speed end
  
  --constraints
  if self.x>width-self.width then self.x=width-self.width end
  if self.x<0 then self.x=0 end
  if self.y>height-self.height then self.y=height-self.height end
  if self.y<0 then self.y=0 end
  
  self.pos = Vector:new(self.x, self.y)
end

function player:draw()
  love.graphics.setColor(white)
  
  -- draw big laser boi if you have it and all that
  if self.laser and love.keyboard.isDown(controls.fire) then
    laserx,laserw = player.x+player.width/2-img.laser:getWidth()/2,img.laser:getWidth()
    for i=1,30 do
      love.graphics.draw(img.laser, laserx, player.y+player.height/2-i*img.laser:getHeight())
    end
    laser_vec = Vector:new(laserx,0)
    laser_vec.width = laserw
    laser_vec.height = player.y
  end
  
  --draw the actual ship
  love.graphics.draw(matt.graphics.frame(img.ship,4),self.x,self.y)
  
  --draw the triple shot ship if you have it
  if self.triple then love.graphics.draw(frame(img.triple_ship,4),self.x,self.y) end
end

function player:hurt()
  --pretty self explanatory
  if not bleed then
    self.hp=self.hp-1
    matt.sfx.play("hit")
    bleed=true
  end
end

function player:fire()
  -- don't fire if we're doing dialogue or whatever
  if not doingDialogue  then
    -- put a gosh darn laser in there
    Laser:new(player.x+player.width/2-1, player.y, 1)
    
    --play that laser sound
    matt.sfx.play("laser")
    
    --if triple, do two more at those other places
    if player.triple then
      table.insert(glasers, Laser:new(player.x+6,player.y+18,1))
      table.insert(glasers, Laser:new(player.x+48,player.y+18,1))
    end
  end
end