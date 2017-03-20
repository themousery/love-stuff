require "player"
require "laser"
require "asteroid"
require "collision"
require "ufo"
require "powerup"

function love.load()
  ship = love.graphics.newImage("images/ship.png")
  heart = love.graphics.newImage("images/heart.png")
  asteroid_imgs = {love.graphics.newImage("images/asteroid1.png"), love.graphics.newImage("images/asteroid2.png"), love.graphics.newImage("images/asteroid3.png"), love.graphics.newImage("images/asteroid4.png")}
  ufo_img = love.graphics.newImage("images/ufo.png")

  laser_sound = love.audio.newSource("sounds/laser.wav")
  powerup_sound = love.audio.newSource("sounds/powerup.wav")
  hit = love.audio.newSource("sounds/hit.wav")
  explode = love.audio.newSource("sounds/explosion.wav")
  background = love.audio.newSource("sounds/Latin Industries.mp3")
  scoreFont = love.graphics.newFont("SF Pixelate.ttf", 50)
  overFont = love.graphics.newFont("SF Pixelate.ttf", 120)

  laser_sound:setVolume(0.3)
  background:play()
  background:setLooping(true)
  background:setVolume(0.2)
  love.mouse.setVisible(false)
  stars = love.graphics.newCanvas()
  love.graphics.setCanvas(stars)
  love.graphics.setColor(255,255,255)
  for i=1,300 do
    love.graphics.points(love.math.random(love.graphics.getWidth()), love.math.random(love.graphics.getHeight()))
  end
  love.graphics.setCanvas()
  lasers = {}
  asteroids = {}
  aliens = {}
  alasers = {}
  powerups = {}
  frameCount = 0
  table.insert(aliens, Alien:new())
  score = 0
  over = false
  alpha = 0
  bleed = false
  goback = false
  mode = "menu"
  for i=1,5 do
    love.math.random(10)
  end
end

function love.update()
  frameCount = frameCount + 1
  if #aliens <= 0 then
    table.insert(aliens, Alien:new())
  end
  if love.math.random(1000) <= 5 then
    table.insert(aliens, Alien:new())
  end
  if love.math.random(1000) <= 2 then
    table.insert(powerups, Power:new())
  end
  for i,laser in ipairs(lasers) do
    laser:update(i)
  end
  for i,asteroid in ipairs(asteroids) do
    asteroid:update(i)
  end
  for i,alaser in ipairs(alasers) do
    alaser:update(i)
  end
  for i,alien in ipairs(aliens) do
    alien:update(i)
  end
  for i,powerup in ipairs(powerups) do
    powerup:update(i)
  end
  player:update()
  if frameCount % 10 == 0 then
    table.insert(asteroids, Asteroid:new())
  end
  if player.hp <= 0 then
    over = true
    asteroids = {}
    lasers = {}
    alasers = {}
    aliens = {}
    powerups = {}
    score = 0
  end
end

function love.draw()
  if over then
    love.graphics.setFont(overFont)
    love.graphics.printf("You died!\n\npress any key", 0, love.graphics.getHeight()/4, love.graphics.getWidth(), "center")
  else
    love.graphics.draw(stars,0,0)
    for i,laser in ipairs(lasers) do
      laser:draw()
    end
    for i,asteroid in ipairs(asteroids) do
      asteroid:draw()
    end
    for i,alaser in ipairs(alasers) do
      alaser:draw(i)
    end
    for i,alien in ipairs(aliens) do
      alien:draw(i)
    end
    for i,powerup in ipairs(powerups) do
      powerup:draw(i)
    end
    player:draw()
    love.graphics.setFont(scoreFont)
    love.graphics.print(score, 40, 40)
    for i=1,player.hp do
      love.graphics.draw(heart, (i-1)*(32+10)+(love.graphics.getWidth()-((32+10)*player.hp)), 30)
    end
  end
  if bleed then
    if goback and alpha <= 0 then
      bleed = false
      alpha = 0
      goback = false
    end

    if goback then
      alpha = alpha - 4
    else
      alpha = alpha + 4
    end

    if alpha >= 50 then
      goback = true
    end
    love.graphics.setColor(255,0,0,alpha)
    love.graphics.rectangle("fill",0,0,love.graphics.getWidth(),love.graphics.getHeight())
    love.graphics.setColor(255,255,255,255)
  end
end

function love.mousepressed()
  laser_sound:rewind()
  laser_sound:play()
  table.insert(lasers, Laser:new())
end

function love.keypressed(key)
  if key == "escape" then
    love.event.quit()
  end
  if over then
    over = false
    player.hp = 3
  end
end
