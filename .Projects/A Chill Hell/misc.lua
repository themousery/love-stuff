width,height = love.graphics.getDimensions()
white = {255,255,255,255}
blue = {0,0,255}
red = {255,0,0}
green = {0,255,0}
load = false
alpha = 0
back = false
frameCount = 0

function colliderect(x,y,w,h,x2,y2,w2,h2)
  return x + w >= x2 and x <= x2 + w2 and y + h >= y2 and y <= y2 + h2
end

function colliderectmouse (x, y, xW, yW)
  return mouseX >= x and mouseX <= x + xW and mouseY >= y and mouseY <= y + yW
end

function miscUpdate()
  frameCount = frameCount+1
  mouseX,mouseY = love.mouse.getPosition()
  if load then
    if back then
      alpha = alpha - 25
      if alpha <= 0 then
        load = false
        alpha = 0
        back = false
      end
    else
      alpha = alpha + 25
      if alpha >= 255 then
        back = true
        aftload()
      end
    end
  end
end

function miscDraw()
  love.graphics.setColor(0,0,0,alpha)
  love.graphics.rectangle("fill",0,0,width,height)
end
