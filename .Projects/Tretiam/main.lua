require "misc"
require "stars"
require "files"
require "menu"
require "arcade"


function love.load()
  frameCount = 0
  cur(menu.title)
  print(#stars)
end

function love.update(dt)
  miscupdate()
  if curupdate then curupdate(dt)end
end

function love.draw()
  drawStars()
  curdraw()
  if load then
    love.graphics.setColor(0,0,0,alpha)
    love.graphics.rectangle("fill",0,0,width,height)
    love.graphics.setColor(white)
  end
end

function love.keypressed(key)
  if key ==  "escape" then
    if curesc then curesc()end
  end
  if key == "printscreen" then
    local screenshot = love.graphics.newScreenshot()
    screenshot:encode('png', os.time() .. '.png')
  end
end

function love.mousereleased()
  if curmouse then curmouse()end
end
