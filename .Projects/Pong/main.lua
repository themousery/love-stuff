player = {x = 0}
function player:update()
  player.x = love.mouse.getX()-150
end

function player:draw()
  love.graphics.setColor(255,255,255)
  love.graphics.rectangle("fill", player.x, love.graphics.getHeight()-70, 300, 35)
end

Ball = {
  y = 100,
  x = love.graphics.getWidth()/2-5
}
function Ball:new (o)
    o = o or {}   -- create object if user does not provide one
    setmetatable(o, self)
    self.__index = self
    o.xspeed = love.math.random(-6,6)
    o.yspeed = love.math.random(10,15)
    o.color = {love.math.random(255), love.math.random(255), love.math.random(255)}
    o.cdir = {}
    src = {-1,1}
    for i=1,3 do
      table.insert(o.cdir, src[love.math.random(2)])
    end
    return o
  end

function Ball:update()
  self.x = self.x + self.xspeed
  self.y = self.y + self.yspeed
  if self.x >= love.graphics.getWidth() then
    self.xspeed = -math.abs(self.xspeed) + love.math.random(-1,1)
  end
  if self.x <= 0 then
    self.xspeed = math.abs(self.xspeed) + love.math.random(-1,1)
  end
  if self.y <= 0 then
    self.yspeed = math.abs(self.yspeed) + love.math.random(-1,1)
    score = score + 1
  end
  if self.x > player.x and self.x < player.x+300 and self.y-10 > love.graphics.getHeight()-70 and self.y < love.graphics.getHeight()-70 + 35 then
    self.yspeed = -math.abs(self.yspeed) + love.math.random(-1,1)
    beep:play()
  end
  if self.xspeed == 0 then
    s = {-1,1}
    self.xspeed = s[math.random(#s)]
  end
  i = love.math.random(3)
  if self.color[i] == 255 or self.color[i] == 0 then
    self.cdir[i] = -self.cdir[i]
  end
  self.color[i] = self.color[i] + self.cdir[i]
end

function Ball:draw()
  love.graphics.setColor(self.color)
  love.graphics.rectangle("fill", self.x, self.y, 10, 10)
end

function love.load()
  balls = {}
  score = 0
  ballsFont = love.graphics.newFont("SF Pixelate.ttf", 120)
  scoreFont = love.graphics.newFont("SF Pixelate.ttf", 50)
  beep = love.audio.newSource("beep.wav", "static")
  background = love.audio.newSource("Voice Over Under.mp3")
  background:play()
  background:setLooping(true)
end

function love.update()
  player.update()
  for i,v in ipairs(balls) do
    v:update()
    if balls[i].y > love.graphics.getHeight() then
      table.remove(balls, i)
    end
  end
end

function love.draw()
  player.draw()
  for i,v in ipairs(balls) do
    v:draw()
  end
  if #balls == 0 then
    love.graphics.setColor(255,255,255)
    love.graphics.setFont(ballsFont)
    love.graphics.print("no balls", 50, love.graphics.getHeight()/2)
  end
  love.graphics.setColor(255, 255, 255)
  love.graphics.setFont(scoreFont)
  love.graphics.print(score, 40, 40)
end

function love.mousepressed()
  table.insert(balls, Ball:new())
end

function love.keypressed(key)
  if key == "escape" then
    love.event.quit()
  end
end
