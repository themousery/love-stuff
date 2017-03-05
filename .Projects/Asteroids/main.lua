require "player"
require "laser"
require "asteroid"
require "collision"

function love.load()
  ship = love.graphics.newImage("images/ship.png")
  heart = love.graphics.newImage("images/heart.png")
  asteroid_imgs = {love.graphics.newImage("images/asteroid1.png"), love.graphics.newImage("images/asteroid2.png"), love.graphics.newImage("images/asteroid3.png"), love.graphics.newImage("images/asteroid4.png")}
  laser_sound = love.audio.newSource("sounds/laser.wav")
  hit = love.audio.newSource("sounds/hit.wav")
  explode = love.audio.newSource("sounds/explosion.wav")
  scoreFont = love.graphics.newFont("SF Pixelate.ttf", 50)
  overFont = love.graphics.newFont("SF Pixelate.ttf", 120)

  laser_sound:setVolume(0.1)
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
  frameCount = 0
  score = 0
  over = false
end

function love.update()
  frameCount = frameCount + 1
  for i,laser in ipairs(lasers) do
    laser:update(i)
  end
  for i,asteroid in ipairs(asteroids) do
    asteroid:update(i)
  end
  player:update()
  if frameCount % 15 == 0 then
    table.insert(asteroids, Asteroid:new())
  end
  if player.hp <= 0 then
    over = true
    asteroids = {}
    lasers = {}
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
    player:draw()
    love.graphics.setFont(scoreFont)
    love.graphics.print(score, 40, 40)
    for i=1,player.hp do
      love.graphics.draw(heart, (i-1)*(32+10)+(love.graphics.getWidth()-((32+10)*player.hp)), 30)
    end
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
