module("story", package.seeall)
makeModule("story")
function setup()
  texty=height+20
  playMusic("story")
end
text={
      white,"In a faraway galaxy, an interstellar group known as the ",
      {255,0,0},"Accin ",
      white,"is bent on destroying all civilzation that stands in its way. Your home planet, known as ",
      {0,0,255}, "Leviathon",
      white,", has been all but destroyed. Only you and three others managed to escape. This is your story..."
     }
function update()end
function draw()
  font:setLineHeight(1.5)
  texty=texty-0.9
  love.graphics.setColor(black)
  love.graphics.rectangle("fill",0,0,width,height)
  love.graphics.setColor(white)
  love.graphics.setFontSize(60)
  love.graphics.printf(text, 10,texty,width-20,"center")
  if texty<=-700 then
    transition(menu.locationcard,2)
    stopMusic()
  end
  font:setLineHeight(1)
end