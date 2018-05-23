module("credits", package.seeall)

credits = {
  "programming / sound effects","Matthew Francis",
  "art / font","Trevor Baughn",
  "music","Kevin MacLeod",
  "programmed in","Lua / LOVE2D"}

function setup()
  cursorOn = 2
end
function update()
  updateStars()
  if menuUp and cursorOn > 1 then
    cursorOn = cursorOn-2
  end
  if menuDown and cursorOn < #credits then
    cursorOn = cursorOn+2
  end
end
function draw()
  drawStars()
  love.graphics.setFontSize(70)
  love.graphics.printf("Credits", 0,50,width,"center")
  love.graphics.setFontSize(45)
  for i=2,#credits,2 do
    love.graphics.setColor(100,75,255)
    love.graphics.printf(credits[i-1],0,i*70+60,width,"center")
    love.graphics.setColor(255,100,75)
    love.graphics.printf(credits[i],0,i*70+70+fontHeight(),width,"center")
    m = false
    if _G.mouseInput and mouseY>i*70+60 and mouseY<i*70+70+fontHeight()*2 then
      cursorOn = i
      love.mouse.setCursor(cursor.hand)
    end
    love.graphics.setColor(white)
    love.graphics.draw(img.cursor,width/2-400,cursorOn*70+70)
  end
end

function keypressed(key)
  if key=="escape" then
    transition(menu.title)
  end
  if key==controls.up and cursorOn>2 then
    cursorOn=cursorOn-2
    _G.mouseInput = false
  elseif key==controls.down and cursorOn<#credits then
    cursorOn=cursorOn+2
    _G.mouseInput = false
  elseif key==controls.select then
    mouse()
  end
end

function gamepadpressed(joystick, button)
  if button=="b" then
    transition(menu.title)
  end
  if button=="a" then
    mouse()
  end
end

function mouse()
  if cursorOn == 2 then
    open_url("https://themousery.github.io")
  elseif cursorOn == 4 then
    open_url("https://www.piskelapp.com/user/6683647952289792")
  elseif cursorOn == 6 then
    open_url("http://incompetech.com/")
  elseif cursorOn == 8 then
    open_url("http://www.zone38.net/")
  elseif cursorOn == 10 then
    open_url("https://www.lua.org/")
    open_url("https://love2d.org/")
  end
end