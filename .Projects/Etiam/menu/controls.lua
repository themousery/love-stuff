module("controls", package.seeall)

function setup()
  text = {
    "Up",
    "Left",
    "Down",
    "Right",
    "Fire",
    "Select"
  }
  choosing = false
  mouseOn=1
end

function update()
  updateStars()
end

function draw()
  drawStars()
  love.graphics.setColor(black)
  love.graphics.line(width,0,width,height)
  love.graphics.setColor(white)
  love.graphics.draw(img.menu,0,0)
  love.graphics.setFontSize(60)
  love.graphics.setColor(49,255,0)
  love.graphics.printf("Controls", 0,100,width,"center")
  for i,v in ipairs(text) do
    love.graphics.setFontSize(30)
    love.graphics.setColor(49,255,0)
    love.graphics.print(v, 493, i*75+125)--475
    love.graphics.printf(controls[string.lower(text[i])], 463,i*75+115,415,"right")
    if not choosing and mouseX>444 and mouseX<920 and mouseY>i*75+125 and mouseY<i*75+125+fontHeight() then
      mouseOn = i
      love.mouse.setCursor(cursor.hand)
    end
  end
  love.graphics.setColor(white)
  if choosing then
    love.graphics.setColor(49,255,0)
  end
  love.graphics.draw(img.cursor, 449, mouseOn*75+120)
end

function keypressed(key)
  if key=="escape" then
    transition(menu.options)
  end
  if choosing then
    controls[string.lower(text[choosing])] = key
    choosing = false
    justChose = true
  elseif key==controls.up and mouseOn>1 then
    mouseOn=mouseOn-1
  elseif key==controls.down and mouseOn<6 then
    mouseOn=mouseOn+1
  elseif key==controls.select then
    mouse()
  end
end

function mouse()
  choosing = mouseOn
end