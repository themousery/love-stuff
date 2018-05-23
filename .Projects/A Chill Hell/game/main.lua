color = {love.math.random(255),love.math.random(255),love.math.random(255)}
s = {-1,1}
cdir = {s[love.math.random(#s)],s[love.math.random(#s)],s[love.math.random(#s)]}
options = {"SHOP", "SAVE", "QUIT"}
why = {"left","center","right"}

function drawThing()
  love.graphics.setColor(color)
  love.graphics.rectangle("fill", width/2-100, 100, 200, 200)
end

function setup()
  things = {}
  love.mouse.setCursor(cursor.reg)
  music.menu:stop()
  shop = false
end

function update()
  if (frameCount % 60) == 0 then
    save[currentSave][2] = save[currentSave][2] + save[currentSave][5]
  end
  if save[currentSave][3]=="0" then
    tutorial = true
    currentMsg = 1
    fc = 0
    loadDialogue()
    save[currentSave][3] = 1
    save[currentSave][4] = 1
    save[currentSave][5] = 0
  else
    music.game:play()
    music.game:setLooping(true)
  end
  i = love.math.random(3)
  color[i] = color[i]+cdir[i]
  if color[i] == 255 or color[i] == 0 then
    cdir[i] = -cdir[i]
  end
  for i,v in ipairs(things) do
    v:update(i)
  end
  if (frameCount%1800) == 0 then
    saveGame()
  end
end

function draw()
  if tutorial then
    fc = fc+1
    love.graphics.setColor(white)
    love.graphics.rectangle("line",10,height-210,width-20,200)
    love.graphics.setColor(0,0,0)
    love.graphics.rectangle("fill",10,height-210,width-20,200)

    love.graphics.setColor(white)
    love.graphics.printf(msgs[currentMsg], 10,height-210,width-20, "left")
    if currentMsg > 1 and currentMsg < #msgs then
      love.graphics.draw(img.devil, (width-60)/2, 100)
    end
    if currentMsg == #msgs then
      drawThing()
    end
  else
    drawThing()
    for i,v in ipairs(things) do
      v:draw()
    end
    love.graphics.setColor(white)
    love.graphics.print(save[currentSave][2], 0,0)
    love.graphics.rectangle("line",10,height-60,width-20,50)
    love.graphics.setColor(0,0,0)
    love.graphics.rectangle("fill",10,height-60,width-20,50)
    m = false
    for i,v in ipairs(options) do
      if mouseY>height-60 and mouseX>(i-1)*400-200 and mouseX<i*400-200 and not shop then
        love.graphics.setColor(blue)
        m = i
      else
        love.graphics.setColor(white)
      end
      love.graphics.printf(v, 10,height-60,width-20, why[i])
    end
    if m then
      love.mouse.setCursor(cursor.hand)
    else
      love.mouse.setCursor(cursor.reg)
    end
    if saved then
      savecount=savecount+1
      love.graphics.setFont(font.save)
      love.graphics.setColor(white)
      love.graphics.printf("SAVED GAME", 0,0,width,"center")
      love.graphics.setFont(font.options)
      if savecount >= 30 then
        savecount = 0
        saved = false
      end
    end
    if shop then
      drawShop()
    end
  end
end

function mouse()
  if tutorial and fc>=30 then
    currentMsg = currentMsg+1
    fc = 0
    if currentMsg == #msgs+1 then
      tutorial = false
    end
    if currentMsg == 2 then
      music.game:play()
      music.game:setLooping(true)
    end
  end
  if not tutorial then
    if mouseX>width/2-100 and mouseX<width/2-100+200 and mouseY>100 and mouseY<300 then
      save[currentSave][2] = save[currentSave][2]+save[currentSave][4]
      table.insert(things, Thing:new())
    end
    if not shop and m then
      if m == 1 then
        shop = true
        m = false
      elseif m == 2 then
        saveGame()
      elseif m == 3 then
        saveGame()
        _G.load = true
        _G.aftload = function()_G.cur=menu.title;music.game:stop();music.menu:play();music.menu:setLooping(true);end
      end
    end
    if shop and m then
      if m == 1 and save[currentSave][2] > shopprices[1] then
        save[currentSave][4] = save[currentSave][4]+1
        save[currentSave][2] = save[currentSave][2]-shopprices[1]
        shopprices[1] = shopprices[1] * 2
      elseif m == 2 and save[currentSave][2] > shopprices[2] then
        save[currentSave][5] = save[currentSave][5]+1
        save[currentSave][2] = save[currentSave][2]-shopprices[2]
        shopprices[2] = shopprices[2] * 2
      elseif m == -1 then
        shop = false
      end
    end
  end
end
