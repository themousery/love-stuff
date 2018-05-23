module("title", package.seeall)
options = {"Play", "Options", "Credits", "Exit"}
function setup()
  cursorOn = 1
  stickup = true
  if not music["menu"]:isPlaying() then playMusic("menu")end
end
function update()
  updateStars()
  if menuUp and cursorOn > 1 then
    cursorOn = cursorOn-1
  end
  if menuDown and cursorOn < #options then
    cursorOn = cursorOn+1
  end
end
function draw()
  drawStars()
  love.graphics.draw(img.title_screen,1,0)
  love.graphics.draw(img.demo, 850, 170)
  love.graphics.setFontSize(45)
  m = false
  love.graphics.setColor(white)
  for i,v in ipairs(options) do
    love.graphics.printf(v, width-45-141*i,height-650+i*136.5,width,"left")
    if mouseInput and mouseX>width-45-141*i and mouseX<width and mouseY>height-650+i*136.5 and mouseY<height-650+i*136+fontHeight() then
      m = i
      love.mouse.setCursor(cursor.hand)
    end
    if m then
      cursorOn = m
    end
    if cursorOn==i then
      love.graphics.draw(img.cursor, width-100-i*141, height-650+i*136.5+5)
    end
  end
  if not m then
    love.mouse.setCursor(cursor.reg)
  end
  love.graphics.setColor(white)
end

function keypressed(key)
  if key=="d" then
    gameState=reset
  end
end

function mouse()
  if m==1 then
    if save[1]=="1" then
      transition(menu.level_select)
    else
      transition(menu.openingcredits)
    end
  elseif m==2 then
    transition(menu.options)
    menu.options.back = menu.title
  elseif m==3 then
    transition(menu.credits)
  elseif m==4 then
    transition(quit)
  end
end

function keypressed(key)
  if key==controls.up and cursorOn>1 then
    cursorOn=cursorOn-1
  elseif key==controls.down and cursorOn<#options then
    cursorOn=cursorOn+1
  elseif key==controls.select then
    m = cursorOn
    mouse()
  end
end

function gamepadpressed(joystick, button)
  if button=="a" then
    m = cursorOn
    mouse()
  end
end