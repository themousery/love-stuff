module("level_select", package.seeall)
makeModule("level_select", menu)

function setup()
  pos = {
    {411,372,428,389},
    {270,534,296,560},
    {798,525,848,575},
    {1140,294,1232,380}
  }
  names = {
    "Leviathon",
    "Roknapa",
    "Laurant",
    "Chedopy"
  }
end

function draw()
  bad=0
  love.graphics.draw(img.system, 0,0)
  love.graphics.setFontSize(45)
  for i,v in ipairs(pos) do
    love.graphics.setColor(white)
    love.graphics.draw(img[names[i]],v[1],v[2])
    if mouseX>v[1] and mouseX<v[3] and mouseY>v[2] and mouseY<v[4] then
      love.mouse.setCursor(cursor.hand)
      mouseOn = i
      if not planetStarted then planetStarted = frameCount end
      -- love.graphics.draw(img.system_box, 80, 645)
      love.graphics.setLineWidth(3)
      if i==1 then
        text = string.sub(names[i],1,frameCount-planetStarted)
      else
        text = string.sub("Coming Soon!",1,frameCount-planetStarted)
      end
      love.graphics.setColor(black)
      love.graphics.rectangle("fill", 80, 665, fontWidth(text)+20, fontHeight()+20)
      love.graphics.setColor(49,255,0)
      love.graphics.rectangle("line", 80, 665, fontWidth(text)+20, fontHeight()+20)
      love.graphics.print(text, 90, 685)
    else
      bad=bad+1
    end
  end
  if bad == #names then
    mouseOn = false
    planetStarted = false
  end
end

function mouse()
  if mouseOn == 1 then
    transition(arcade)
    arcade.setLevel(tutorial)
    stopMusic()
  end
end

function keypressed(key)
  if key=="escape" then
    transition(menu.title)
  end
  if key==controls.select then
    transition(arcade)
    arcade.setLevel(tutorial)
    stopMusic()
  end
end