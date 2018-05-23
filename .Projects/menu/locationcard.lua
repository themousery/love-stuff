module("locationcard", package.seeall)
function setup()end
function update()end
started = false
function draw()
  if not started then
    start = frameCount
    started= true
  end
  love.graphics.setColor(black)
  love.graphics.rectangle("fill",0,0,width,height)
  love.graphics.setColor(white)
  love.graphics.setFontSize(70)
  love.graphics.printf("Sector Alpha\nNear Leviathon", 0,height/2-fontHeight(),width,"center")
  if frameCount>=start+150 then
    transition(arcade)
    arcade.setLevel(tutorial)
  end
end