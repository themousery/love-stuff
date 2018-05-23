module("intro", package.seeall)
function update()end
function draw()
  mouse:set("arrow")
  drawForest()
  love.graphics.setColor(236, 220, 176)
  love.graphics.rectangle("fill", 100, 100, 600, 400)
  love.graphics.setColor(193, 152, 117)
  love.graphics.setLineWidth(3)
  love.graphics.rectangle("line", 100, 100, 600, 400)
  love.graphics.printf("Hello, traveler. I assume you are here to oversee the witch trials... \n\nEr, what was your name again?",
                        110,150,590,"left")
  love.graphics.setColor(255,255,255)
  love.graphics.rectangle("fill",120,400,560,40)
  love.graphics.setLineWidth(1)
  love.graphics.setColor(0,0,0)
  love.graphics.printf(name, 120,405,560, "left")
  if mouseX>100 and mouseX<600 and mouseY>400 and mouseY<440 then
    mouse:set("ibeam")
  end
end

function textinput(t)
  if string.len(name)<20 then
    name = name..t
  end
end

function keypressed(key)
  if key=="backspace" then
    name = name:sub(1,-2)
  end
  if key=="return" and string.len(name)>0 then
    transition(intro2)
  end
end
