width,height = love.graphics.getDimensions()
love.graphics.setDefaultFilter("nearest","nearest")
quit = {}
quit.update=function()love.event.quit()end
back=0
light=0
middle=0
front=0
goback = false
load = false
alpha = 0
name=''

function drawForest()
  love.graphics.setColor(255,255,255)
  love.graphics.draw(images["forest_back"], back, 0, 0, 3.75, 3.75)
  love.graphics.draw(images["forest_back"], back-1020, 0, 0, 3.75, 3.75)
  love.graphics.draw(images["forest_light"], light, 0, 0, 3.75, 3.75)
  love.graphics.draw(images["forest_light"], light-1020, 0, 0, 3.75, 3.75)
  love.graphics.draw(images["forest_middle"], middle, 0, 0, 3.75, 3.75)
  love.graphics.draw(images["forest_middle"], middle-1020, 0, 0, 3.75, 3.75)
  love.graphics.draw(images["forest_front"], front, 0, 0, 3.75, 3.75)
  love.graphics.draw(images["forest_front"], front-1020, 0, 0, 3.75, 3.75)
  back=back+0.25
  light=light+0.5
  middle=middle+0.75
  front=front+1.25
  if back>=width then
    back=back-1020
  end
  if light>=width then
    light=light-1020
  end
  if middle>=width then
    middle=middle-1020
  end
  if front>=width then
    front=front-1020
  end
end

function miscUpdate()
  mouse:set("arrow")
  mouseX,mouseY = love.mouse.getPosition()
  if load then
    if goback then
      alpha = alpha - 25
      if alpha <= 0 then
        load = false
        alpha = 0
        goback = false
      end
    else
      alpha = alpha + 25
      if alpha >= 255 then
        goback = true
        gameState = aftload
        if aftload==game then aftload.setup() end
      end
    end
  end
end

function miscDraw()
  if load then
    love.graphics.setColor(0,0,0,alpha)
    love.graphics.rectangle("fill",0,0,width,height)
  end
end

function transition(nextGameState)
  aftload = nextGameState
  load = true
end
