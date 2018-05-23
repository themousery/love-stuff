function update(dt)
  badger = dt
  if sound.arcade:isStopped() and not slomo then
    sound.menu:stop()
    sound.arcade:play()
    sound.arcade:setLooping(true)
    sound.arcade:setVolume(0.4)
  end
  if slomo and frameCount-died >= 120 then
    dead = true
  end
  if not pause then
    updateStars()
    collisions()
    if #aliens == 0 then
      table.insert(aliens,Alien:new())
    end
    if random(1000) <= 5 and not slomo then
      table.insert(aliens,Alien:new())
    end
    if random(1000) <= 2 and not slomo then
      table.insert(powerups,Powerup:new())
    end
    if frameCount % 10 == 0 and not slomo then
      table.insert(asteroids,Asteroid:new())
    end
    for i,laser in ipairs(lasers) do
      laser:update(i)
    end
    for i,asteroid in ipairs(asteroids) do
      asteroid:update(i)
    end
    for i,alien in ipairs(aliens) do
      alien:update(i)
    end
    for i,powerup in ipairs(powerups) do
      powerup:update(i)
    end
    for i,galaxy in ipairs(galaxies) do
      galaxy:update(i)
    end
    for i,explosion in ipairs(explosions) do
      explosion:update(i) 
    end
    player:update()
    if bleed then
      if goback then
        bleedalpha = bleedalpha - 5
        if bleedalpha <= 0 then
          bleedalpha = 0
          bleed = false
          goback = false
        end
      else
        bleedalpha = bleedalpha + 5
        if bleedalpha >= 50 then
          goback = true
        end
      end
    end
  end
end

function draw()
  for i,galaxy in ipairs(galaxies) do
    galaxy:draw()
  end
  for i,laser in ipairs(lasers) do
    laser:draw()
  end
  for i,asteroid in ipairs(asteroids) do
    asteroid:draw()
  end
  for i,alien in ipairs(aliens) do
    alien:draw()
  end
  for i,powerup in ipairs(powerups) do
    powerup:draw()
  end
  for i,explosion in ipairs(explosions) do
    love.graphics.draw(explosion)
  end
  if not slomo then
    player:draw()
  end
  for i=1,player.hp do
    love.graphics.draw(img.heart, (i-1)*(32+10)+(love.graphics.getWidth()-((32+10)*player.hp)), 30)
  end
  love.graphics.setFont(font.credname)
  love.graphics.print(score,40,40)
  if bleed then
    love.graphics.setColor(255,0,0,bleedalpha)
    love.graphics.rectangle("fill",0,0,width,height)
    love.graphics.setColor(white)
  end
  if pause then
    love.graphics.setFont(font.options)
    love.graphics.setColor(100,100,100,150)
    love.graphics.rectangle("fill",0,0,width,height)
    love.graphics.setColor(0,0,0,200)
    local w,h = 400,#pause_options*200
    love.graphics.rectangle("fill",(width-w)/2,(height-h)/2,w,h)
    love.graphics.setFont(font.options)
    m = false
    for i,v in ipairs(pause_options) do
      if mouseY >= (i-1)*200+(height-h)/2+75 and mouseY <= (i-1)*200+(height-h)/2+75+60 and mouseX >= (width-w)/2 and mouseX <= (width-w)/2+400 then
        love.graphics.setColor(150,150,150,100)
        love.graphics.rectangle("fill",(width-w)/2,(i-1)*200+(height-h)/2+75,400,60)
        m = true
      end
      if m then
        love.mouse.setCursor(cursor.hand)
      else
        love.mouse.setCursor(cursor.reg)
      end
      love.graphics.setColor(pause_colors[i])
      love.graphics.printf(v, (width-w)/2, (i-1)*200+(height-h)/2+75, w, "center")
    end
    love.graphics.setColor(white)
  end
  if dead then
    love.graphics.setColor(100,100,100,150)
    love.graphics.rectangle("fill",0,0,width,height)
    love.graphics.setColor(white)
    love.graphics.setFont(font.title)
    love.graphics.printf(dead_title,0,50,width,"center")
    love.graphics.setColor(0,0,0,200)
    local w,h = 400,400
    love.graphics.rectangle("fill",(width-w)/2,(height-h)/2+100,w,h)
    love.graphics.setFont(font.options)
    m = false
    for i,v in ipairs(dead_options) do
      if mouseY >= (i-1)*200+(height-h)/2+175 and mouseY <= (i-1)*200+(height-h)/2+175+60 and mouseX >= (width-w)/2 and mouseX <= (width-w)/2+400 then
        love.graphics.setColor(150,150,150,100)
        love.graphics.rectangle("fill",(width-w)/2,(i-1)*200+(height-h)/2+175,400,60)
        m = true
      end
      if m then
        love.mouse.setCursor(cursor.hand)
      else
        love.mouse.setCursor(cursor.reg)
      end
      love.graphics.setColor(dead_colors[i])
      love.graphics.printf(v, (width-w)/2, (i-1)*200+(height-h)/2+175, w, "center")
    end
    if sound.m:isStopped() and sound.arcade:isStopped() then
      sound.arcade:play()
      sound.arcade:setVolume(0.5)
    end
  end
  love.graphics.setColor(white)
end

function esc()
  if not slomo and not dead then
    if pause then
      sound.arcade:setVolume(0.5)
    else
      sound.arcade:setVolume(0.03)
    end
    pause = not pause
    love.mouse.setPosition(player.x+22,player.y+35)
    love.mouse.setVisible(pause)
  end
end

function mouse()
  if pause then
    local w,h = 400,#pause_options*200
    for i,v in ipairs(pause_options) do
      if mouseY >= (i-1)*200+(height-h)/2+75 and mouseY <= (i-1)*200+(height-h)/2+75+60 and mouseX >= (width-w)/2 and mouseX <= (width-w)/2+400 then
        if i == 1 then
          love.mouse.setPosition(player.x+22,player.y+35)
          love.mouse.setVisible(false)
          sound.arcade:setVolume(0.5)
          pause = false
        elseif i == 2 then
          load = true
          aftload = function()cur(menu.title);reset()end
        end
        return
      end
    end
    return
  end
  if dead then
    local w,h = 400,400
    for i,v in ipairs(dead_options) do
      if mouseY >= (i-1)*200+(height-h)/2+175 and mouseY <= (i-1)*200+(height-h)/2+175+60 and mouseX >= (width-w)/2 and mouseX <= (width-w)/2+400 then
        if i == 1 then
          love.mouse.setVisible(false)
          sound.arcade:play()
          sound.arcade:setVolume(0.5)
          dead = false
          load = true
          aftload = reset
          sound.m:stop()
        elseif i == 2 then
          load = true
          aftload = function()cur(menu.title);reset()end
        end
        return
      end
    end
    return
  elseif not slomo then
    table.insert(lasers,Laser:new(mouseX-2,mouseY,1))
    sound.laser:rewind()
    sound.laser:play()
  end
end

music = sound.arcade
