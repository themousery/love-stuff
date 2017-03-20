player = {x=0,y=0,hp=3}
function player:update()
  if not slomo then
    self.x,self.y = mouseX-22,mouseY-35
  end
  if self.hp <= 0 and not slomo then
    slomo = true
    died = frameCount
    love.mouse.setVisible(true)
    newExplosion(self.x+22,self.y+35)
    game_background:stop()
    death_sound:play()
    mmm_sound:play()
  end
end
function player:draw()
  love.graphics.draw(ship_img,self.x,self.y)
end

function collisions()
  for i,laser in ipairs(lasers) do
    if laser.type == 1 then
      for j,asteroid in ipairs(asteroids) do
        if colliderect(laser.x,laser.y,3,10,asteroid.x,asteroid.y,asteroid.img:getWidth(),asteroid.img:getHeight()) then
          score = score + 1
          table.remove(asteroids,j)
          table.remove(lasers,i)
          explode_sound:rewind()
          explode_sound:play()
          newExplosion(asteroid.x+(asteroid.img:getWidth()/2),asteroid.y+(asteroid.img:getHeight()/2))
        end
      end
      for j,alien in ipairs(aliens) do
        if colliderect(laser.x,laser.y,3,10,alien.x,alien.y,81,42) then
          alien.hp = alien.hp - 1
          table.remove(lasers,i)
          explode_sound:rewind()
          explode_sound:play()
        end
      end
    else
      if colliderect(laser.x,laser.y,3,10,player.x,player.y,44,70) and not dead then
        table.remove(lasers,i)
        player.hp = player.hp - 1
        bleed = true
        hit_sound:rewind()
        hit_sound:play()
      end
    end
  end
  for i,asteroid in ipairs(asteroids) do
    if colliderect(asteroid.x,asteroid.y,asteroid.img:getWidth(),asteroid.img:getHeight(),player.x,player.y,44,70) and not dead then
      table.remove(asteroids,i)
      player.hp = player.hp - 1
      bleed = true
      hit_sound:rewind()
      hit_sound:play()
    end
  end
  for i,heart in ipairs(powerups) do
    if colliderect(heart.x,heart.y,32,30,player.x,player.y,44,70) and not dead then
      table.remove(powerups,i)
      player.hp = player.hp + 1
      powerup_sound:rewind()
      powerup_sound:play()
    end
  end
end

Laser = {}
function Laser:new(x_, y_, type_)
  o = {type = type_, x = x_, y = y_}
  setmetatable(o,self)
  self.__index = self
  return o
end
function Laser:update(i)
  if self.type == 1 then
    if slomo then
      self.y = self.y - 1
    else
      self.y = self.y - 10
    end
    if self.y <= -10 then
      table.remove(lasers,i)
    end
  elseif self.type == 2 then
    if slomo then
      self.y = self.y + 1
    else
      self.y = self.y + 10
    end
    if self.y >= width then
      table.remove(lasers,i)
    end
  end
end
function Laser:draw()
  love.graphics.setColor(laser_colors[self.type])
  love.graphics.rectangle("fill",self.x,self.y,3,10)
  love.graphics.setColor(white)
end

Asteroid = {}
function Asteroid:new()
  o = {}
  o.img = asteroid_imgs[random(4)]
  o.x = random(width)
  o.y = -o.img:getHeight()
  o.speed = random(7,10)
  setmetatable(o,self)
  self.__index = self
  return o
end
function Asteroid:update(i)
  if slomo then
    self.y = self.y + self.speed/10
  else
    self.y = self.y + self.speed
  end
  if self.y >= width then
    table.remove(asteroids,i)
  end
end
function Asteroid:draw()
  love.graphics.draw(self.img,self.x,self.y)
end

s = {-81,width}
Alien = {}
function Alien:new()
  o = {
    x = s[random(#s)],
    y = random(10,150),
    speed = random(7,10),
    hp = 3,
    born = frameCount}
  setmetatable(o,self)
  self.__index = self
  return o
end
function Alien:update(i)
  if self.hp <= 0 then
    table.remove(aliens,i)
    newExplosion(self.x+40,self.y+21)
    score = score + 10
  end
  if self.x >= width-81 and not slomo then
    self.speed = -math.abs(self.speed)
  elseif self.x <= 0 and not slomo then
    self.speed = math.abs(self.speed)
  end
  if slomo then
    if self.x >= width/2 then
      self.speed = math.abs(self.speed)
    else
      self.speed = -math.abs(self.speed)
    end
  end
  if slomo then
    self.x = self.x + self.speed/10
  else
    self.x = self.x + self.speed
  end
  if (frameCount-self.born) % 30 == 0 and not slomo then
    table.insert(lasers,Laser:new(self.x+40,self.y,2))
  end
end
function Alien:draw()
  love.graphics.draw(ufo_img,self.x,self.y)
  love.graphics.setColor(255,255,255,100)
  love.graphics.rectangle("fill",self.x,self.y-5,81,3)
  love.graphics.setColor(white)
  if self.hp == 3 then
    love.graphics.setColor(0,255,0)
    love.graphics.rectangle("fill",self.x,self.y-5,81,3)
  elseif self.hp == 2 then
    love.graphics.setColor(255,165,0)
    love.graphics.rectangle("fill",self.x,self.y-5,54,3)
  elseif self.hp == 1 then
    love.graphics.setColor(255,0,0)
    love.graphics.rectangle("fill",self.x,self.y-5,27,3)
  end
  love.graphics.setColor(white)
end

Powerup = {}
function Powerup:new()
  o = {
    speed = random(7,10),
    x = random(width),
    y = -30}
  setmetatable(o,self)
  self.__index = self
  return o
end
function Powerup:update(i)
  if self.y >= width then
    table.remove(powerups,i)
  end
  if slomo then
    self.y = self.y + self.speed/10
  else
    self.y = self.y + self.speed
  end
end
function Powerup:draw()
  love.graphics.draw(heart_img,self.x,self.y)
end

function newExplosion(x,y)
  c = love.graphics.newCanvas(width, height)
  love.graphics.setCanvas(c)
  love.graphics.setColor(255, 255, 255, 255)
  love.graphics.circle("fill", width / 2, height / 2, 10)
  love.graphics.setCanvas()
  ps = love.graphics.newParticleSystem(c, 1500)
  ps:setParticleLifetime(0.5, 0.9) -- (min, max)
  ps:setSizeVariation(1)
  ps:setLinearAcceleration(-600, -600, 600, 600) -- (minX, minY, maxX, maxY)
  ps:setColors(234, 217, 30, 128, 224, 21, 21, 0) -- (r1, g1, b1, a1, r2, g2, b2, a2 ...)
  ps:setPosition(x,y)
  ps:setEmissionRate(1000)
  ps:update(badger)
  ps:setEmissionRate(0)
  table.insert(explosions,ps)
end

lasers = {}
asteroids = {}
aliens = {}
powerups = {}
explosions = {}
laser_colors = {{100,75,255},{255,100,75}}
pause = false
pause_options = {"resume","quit"}
pause_colors = {{100,75,255},{255,100,75}}
score = 0
bleed = false
goback = false
dead = false
slomo = false
alpha = 0
function resetArcadeGame()
  pause = false
  score = 0
  asteroids = {}
  lasers = {}
  aliens = {}
  alasers = {}
  powerups = {}
  explosions = {}
  dead = false
  bleed = false
  goback = false
  slomo = false
  alpha = 0
  player.hp = 3
end
function updateArcadeGame()
  if slomo and frameCount-died >= 120 then
    dead = true
  end
  if not pause then
    collisions()
    if #aliens == 0 then
      table.insert(aliens,Alien:new())
    end
    if random(1000) <= 5 and not slomo then
      table.insert(aliens,Alien:new())
    end
    if random(1000) <= 2 and not slomo then
      table.insert(powerups,Powerup:new())
    end
    if frameCount % 10 == 0 then
      table.insert(asteroids,Asteroid:new())
    end
    for i,laser in ipairs(lasers) do
      laser:update(i)
    end
    for i,asteroid in ipairs(asteroids) do
      asteroid:update(i)
    end
    for i,alien in ipairs(aliens) do
      alien:update(i)
    end
    for i,powerup in ipairs(powerups) do
      powerup:update(i)
    end
    for i,explosion in ipairs(explosions) do
      explosion:update(badger)
      if explosion:getCount() == 0 then
        table.remove(explosions,i)
      end
    end
    player:update()
    if bleed then
      if goback then
        alpha = alpha - 5
        if alpha <= 0 then
          alpha = 0
          bleed = false
          goback = false
        end
      else
        alpha = alpha + 5
        if alpha >= 50 then
          goback = true
        end
      end
    end
  end
end

dead_title = {
  {100,75,255},"Y",
  {126,79,225},"O",
  {152,83,195},"U",
  black," ",
  {178,88,165},"D",
  {203,92,135},"I",
  {229,96,105},"E",
  {255,100,75},"D",}
dead_options = {"restart","quit"}
dead_colors = {{100,75,255},{255,100,75}}

function drawArcadeGame()
  love.graphics.draw(stars,0,0)
  for i,laser in ipairs(lasers) do
    laser:draw()
  end
  for i,asteroid in ipairs(asteroids) do
    asteroid:draw()
  end
  for i,alien in ipairs(aliens) do
    alien:draw()
  end
  for i,powerup in ipairs(powerups) do
    powerup:draw()
  end
  for i,explosion in ipairs(explosions) do
    love.graphics.draw(explosion)
  end
  if not slomo then
    player:draw()
  end
  for i=1,player.hp do
    love.graphics.draw(heart_img, (i-1)*(32+10)+(love.graphics.getWidth()-((32+10)*player.hp)), 30)
  end
  love.graphics.setFont(credits_name_font)
  love.graphics.print(score,40,40)
  if bleed then
    love.graphics.setColor(255,0,0,alpha)
    love.graphics.rectangle("fill",0,0,width,height)
    love.graphics.setColor(white)
  end
  if pause then
    love.graphics.setFont(options_font)
    love.graphics.setColor(100,100,100,150)
    love.graphics.rectangle("fill",0,0,width,height)
    love.graphics.setColor(0,0,0,200)
    local w,h = 400,#pause_options*200
    love.graphics.rectangle("fill",(width-w)/2,(height-h)/2,w,h)
    love.graphics.setFont(options_font)
    for i,v in ipairs(pause_options) do
      if mouseY >= (i-1)*200+(height-h)/2+75 and mouseY <= (i-1)*200+(height-h)/2+75+60 and mouseX >= (width-w)/2 and mouseX <= (width-w)/2+400 then
        love.graphics.setColor(150,150,150,100)
        love.graphics.rectangle("fill",(width-w)/2,(i-1)*200+(height-h)/2+75,400,60)
      end
      love.graphics.setColor(pause_colors[i])
      love.graphics.printf(v, (width-w)/2, (i-1)*200+(height-h)/2+75, w, "center")
    end
    love.graphics.setColor(white)
  end
  if dead then
    love.graphics.setFont(title_font)
    love.graphics.printf(dead_title,0,50,width,"center")
    love.graphics.setColor(100,100,100,150)
    love.graphics.rectangle("fill",0,0,width,height)
    love.graphics.setColor(0,0,0,200)
    local w,h = 400,400
    love.graphics.rectangle("fill",(width-w)/2,(height-h)/2+100,w,h)
    love.graphics.setFont(options_font)
    for i,v in ipairs(dead_options) do
      if mouseY >= (i-1)*200+(height-h)/2+175 and mouseY <= (i-1)*200+(height-h)/2+175+60 and mouseX >= (width-w)/2 and mouseX <= (width-w)/2+400 then
        love.graphics.setColor(150,150,150,100)
        love.graphics.rectangle("fill",(width-w)/2,(i-1)*200+(height-h)/2+175,400,60)
      end
      love.graphics.setColor(dead_colors[i])
      love.graphics.printf(v, (width-w)/2, (i-1)*200+(height-h)/2+175, w, "center")
    end
  end
  love.graphics.setColor(white)
end
