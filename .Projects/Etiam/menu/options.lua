module("options", package.seeall)
makeModule("options", menu)

function setup()
  values = {save[2],save[3]}
  for i=1,2 do
    values[i] = tonumber(values[i])
  end
  rightStarted = math.huge
  leftStarted=math.huge
  pressing = false
  isMenu=true
  options = {"Music","SFX",0}
  cursorOn=1
  local f = function()end
  actions = {
    f,f,
    menu.controls
  }
  exit = function()
    transition(back)
    if save[2] ~= values[1] or save[3] ~= values[2] or table.tostring({save[4],save[5],save[6],save[7],save[8],save[9]}) ~= table.tostring({controls.up,controls.left,controls.down,controls.right,controls.fire,controls.select}) then
      _G.save={save[1],values[1],values[2],controls.up,controls.left,controls.down,controls.right,controls.fire,controls.select}
      saveGame()
    end
  end
end

function update()
  updateStars()
  if frameCount-rightStarted>30 then
    values[cursorOn] = values[cursorOn]+10
  elseif frameCount-leftStarted>30 then
    values[cursorOn] = values[cursorOn]-10
  end
end

function draw()
  drawStars()
  love.graphics.setColor(black)
  love.graphics.line(width,0,width,height)
  love.graphics.setColor(white)
  love.graphics.draw(img.menu,0,0)
  love.graphics.setFontSize(50)
  love.graphics.setColor(49,255,0)
  love.graphics.printf("Options", 0,100,width,"center")
  love.graphics.setFontSize(30)
  for i=1,2 do
    love.graphics.print(options[i], 503, i*150+100)
    local x = 600
    love.graphics.rectangle("fill",x, i*150+108, 860-x, 4)
    love.graphics.draw(img.slider, map(values[i], 0,100, x,860)-img.slider:getWidth()/2, i*150+110-img.slider:getHeight()/2)
    if mouseY>i*150+110-img.slider:getHeight()/2 and mouseY<i*150+110+img.slider:getHeight() and mouseX>x and mouseX<860 then
      cursorOn = i
      love.mouse.setCursor(cursor.hand)
    end
    if cursorOn==i then
      love.graphics.setColor(white)
      love.graphics.draw(img.cursor,453,cursorOn*150+110-img.slider:getHeight()/2)
      love.graphics.setColor(49,255,0)
    end
    if pressing == i then
      values[i] = map(mouseX, x,860, 0,100)
      for k,v in pairs(music) do
        v:setVolume(values[1]/100)
      end
      for k,v in pairs(sound) do
        v:setVolume(values[2]/100)
      end
      sound.laser:setVolume(values[2]/200)
    end
    if values[i] > 100 then
      values[i] = 100
    elseif values[i] < 0  then
      values[i] = 0
    end
  end
  love.graphics.printf("Controls", 0, 550, width, "center")
  if mouseY>550 and mouseY<550+fontHeight() and mouseX>444 and mouseX<920 then
    cursorOn=3
    love.mouse.setCursor(cursor.hand)
    love.graphics.setColor(white)
  end
  if cursorOn==3 then
    love.graphics.setColor(white)
    love.graphics.draw(img.cursor,453,550)
  end
end

function keypressed(key)
  if cursorOn<=2 then
    if key==controls.right and rightStarted == math.huge then
      values[cursorOn] = values[cursorOn]+10
      rightStarted = frameCount
    elseif key==controls.left and leftStarted == math.huge then
      values[cursorOn] = values[cursorOn]-10
      leftStarted = frameCount
    end
  end
end

function keyreleased(key)
  if key==controls.right then
    rightStarted=math.huge
  elseif key==controls.left then
    leftStarted=math.huge
  end
end

function mousepressed()
  if cursorOn<=2 then
    pressing=cursorOn
  end
end

function mouse()
  pressing = false
  if cursorOn==3 then
    transition(menu.controls,255)
  end
end