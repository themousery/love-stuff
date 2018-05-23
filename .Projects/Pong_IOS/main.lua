require "player"
require "ball"
require "misc"

function love.load()
  background = love.audio.newSource("Voice Over Under.mp3")
  beep = love.audio.newSource("beep.wav")
  menuFont = love.graphics.newFont("SF Pixelate.ttf",150)
  scoreFont = love.graphics.newFont("SF Pixelate.ttf", 50)

  background:play()
  background:setLooping(true)
  score = {10,10}
  menu = false
  mendown = false
end

function love.update()
  if not menu then
    ball:update()
    for i,player in ipairs(players) do
      player:update(i)
    end

    for i,touch in ipairs(love.touch.getTouches()) do
      local x, y = love.touch.getPosition(touch)
      if y > 384 then
        players[1].x = x-150
      else
        players[2].x = x-150
      end
    end
    x, y = love.mouse.getPosition()
    if y > 384 then
      players[1].x = x-150
    else
      players[2].x = x-150
    end
  end
end

function love.draw()
  if menu then
    love.graphics.setFont(menuFont)
    love.graphics.setColor(237,28,36)
    love.graphics.printf("Pong", 0,100,1024,"center")
    if mendown then
      love.graphics.setColor(100,100,255)
    else
      love.graphics.setColor(28,36,237)
    end
    w = 170
    love.graphics.rectangle("fill", (1024-w)/2, 500, w, 60)
    love.graphics.setColor(255,255,255)
    love.graphics.rectangle("line", (1024-w)/2, 500, w, 60)
    love.graphics.setFont(scoreFont)
    love.graphics.setColor(255,255,255)
    love.graphics.print("Begin", (1024-w)/2+10, 500+8)
  else
    love.graphics.setColor(100,100,100)
    love.graphics.line(0,379,1024,379)
    ball:draw()
    for i,player in ipairs(players) do
      player:draw(i)
    end
  end
end

function love.touchpressed(id,x,y)
  if colliderect(x,y,1,1,(1024-w)/2, 500, w, 60) then
    mendown = true
  end
end

function love.touchreleased()
  if mendown then
    menu = false
    mendown = false
  end
end
