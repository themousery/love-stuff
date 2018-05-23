function reset()
  pause = false
  score = 0
  asteroids = {}
  lasers = {}
  aliens = {}
  alasers = {}
  powerups = {}
  explosions = {}
  bleed = false
  goback = false
  dead = false
  slomo = false
  bleedalpha = 0
  player.hp = 3
end
pause_options = {"trevor","trevor"}
pause_colors = {{100,75,255},{255,100,75}}
laser_colors = {{100,75,255},{255,100,75}}
dead_title = {
  {100,75,255},"T",
  {126,79,225},"R",
  {152,83,195},"E",
  black," ",
  {178,88,165},"V",
  {203,92,135},"O",
  {229,96,105},"R",
  {255,100,75},"",}
dead_options = {"trevor","trevor"}
dead_colors = {{100,75,255},{255,100,75}}
reset()

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

function colliderect(x,y,w,h,x2,y2,w2,h2)
  return x + w >= x2 and x <= x2 + w2 and y + h >= y2 and y <= y2 + h2
end

function collisions()
  for i,laser in ipairs(lasers) do
    if laser.type == 1 then
      for j,asteroid in ipairs(asteroids) do
        if colliderect(laser.x,laser.y,3,10,asteroid.x,asteroid.y,asteroid.img:getWidth(),asteroid.img:getHeight()) then
          score = score + 1
          table.remove(asteroids,j)
          table.remove(lasers,i)
          sound.explode:rewind()
          sound.explode:play()
          newExplosion(asteroid.x+(asteroid.img:getWidth()/2),asteroid.y+(asteroid.img:getHeight()/2))
        end
      end
      for j,alien in ipairs(aliens) do
        if colliderect(laser.x,laser.y,3,10,alien.x,alien.y,81,42) then
          alien.hp = alien.hp - 1
          table.remove(lasers,i)
          sound.explode:rewind()
          sound.explode:play()
        end
      end
    else
      if colliderect(laser.x,laser.y,3,10,player.x,player.y,44,70) and not slomo then
        table.remove(lasers,i)
        player.hp = player.hp - 1
        bleed = true
        sound.hit:rewind()
        sound.hit:play()
      end
    end
  end
  for i,asteroid in ipairs(asteroids) do
    if colliderect(asteroid.x,asteroid.y,asteroid.img:getWidth(),asteroid.img:getHeight(),player.x,player.y,44,70) and not slomo then
      table.remove(asteroids,i)
      player.hp = player.hp - 1
      bleed = true
      sound.hit:rewind()
      sound.hit:play()
    end
  end
  for i,heart in ipairs(powerups) do
    if colliderect(heart.x,heart.y,32,30,player.x,player.y,44,70) and not slomo then
      table.remove(powerups,i)
      player.hp = player.hp + 1
      sound.powerup:rewind()
      sound.powerup:play()
    end
  end
end
