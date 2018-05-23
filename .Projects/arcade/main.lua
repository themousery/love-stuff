function setLevel(l)
  level = l
  level.setup()
  resetGame()
end

function update(dt)
  if love.mouse.isVisible() then love.mouse.setVisible(false) end
  badger = dt
  if slomo and frameCount-died >= 120 then
    transition(menu.dead,10)
  end
  collisions()
  level.update()
  for i,type in ipairs({glasers, blasers, obstacles, aliens, powerups}) do
    for j,object in ipairs(type) do
      object:update(j)
    end
  end
  for i,boss in ipairs(bosses) do
    if boss.hp > -1 then
      boss:update()
    else
      boss:explode()
    end
  end
  for i,explosion in ipairs(explosions) do
    explosion:update(dt)
  end
  player:update()
  if bleed then
    if goback then
      bleedalpha = bleedalpha - 3
      if bleedalpha <= 0 then
        bleedalpha = 0
        bleed = false
        goback = false
      end
    else
      bleedalpha = bleedalpha + 3
      if bleedalpha >= 50 then
        goback = true
      end
    end
    if gamepad and not keyboardInput then
      gamepad:setVibration(1,1)
    end
  else
    if gamepad then
      gamepad:setVibration(0,0)
    end
  end
  if frameCount-powerupStarted >= 300 then
    if player.laser then player.laser = false end
    if player.triple then player.triple = false end
  end
  if frameCount-nolimitStarted >= 300 then
    if player.nolimits then player.nolimits = false end
  end
end

function draw()
  level.predraw()
  if bleed or player.laser and love.keyboard.isDown(controls.fire) then
    shakeScreen(5)
  end
  if player.laser and love.keyboard.isDown(controls.fire) then
    shakeScreen(1)
  end
  drawStars()
  for i,laser in ipairs(glasers) do
    laser:draw()
  end
  for i,laser in ipairs(blasers) do
    laser:draw()
  end
  for i,asteroid in ipairs(obstacles) do
    asteroid:draw()
  end
  for i,alien in ipairs(aliens) do
    alien:draw()
  end
  for i,powerup in ipairs(powerups) do
    powerup:draw()
  end
  for i,boss in ipairs(bosses) do
    if boss.hp>-2 then
      boss:draw()
    end
  end
  for i,explosion in ipairs(explosions) do
    explosion:draw()
  end
  if not slomo then
    player:draw()
  end
  love.graphics.setColor(50,50,50)
  love.graphics.setLineWidth(5)
  love.graphics.rectangle("line", width-215,15,200,25)
  love.graphics.setColor(black)
  love.graphics.rectangle("fill", width-215,15,200,25)
  if player.hp >= 5 then
    love.graphics.setColor(map(player.hp,10,5,0,255),map(player.hp,5,10,165,255),0)
  else
    love.graphics.setColor(255,map(player.hp,5,1,165,0), 0)
  end
  love.graphics.rectangle("fill", width-215,15,200*(player.hp/10), 25)
  love.graphics.setColor(white)
  if player.laser then
    love.graphics.draw(img.laserup, width-240, 20)
  end
  if player.nolimits then
    love.graphics.draw(img.nolimits,width-240,20)
  end
  if player.triple then
    love.graphics.draw(img.tripleup, width-240,20)
    if player.nolimits then
      love.graphics.draw(img.nolimits,width-240,20)
    end
  end
  love.graphics.setFontSize(60)
  love.graphics.print(score,40,40)
  
  if doingDialogue then
    drawDialogue()
  end
  
  if bleed then
    love.graphics.setColor(255,0,0,bleedalpha)
    love.graphics.rectangle("fill",0,0,width,height)
    love.graphics.setColor(white)
  end
  if debug then
    for i,node in ipairs(alienpath.nodes) do
      love.graphics.setColor(255,0,0,100)
      if i~=#alienpath.nodes then
        love.graphics.line(node.x,node.y,alienpath.nodes[i+1].x,alienpath.nodes[i+1].y)
      end
      love.graphics.setPointSize(4)
      love.graphics.setLineWidth(alienpath.radius*2)
      love.graphics.setColor(255,0,0,100)
      love.graphics.circle("line", node.x,node.y,alienpath.radius)
      love.graphics.setColor(255,0,0)
      love.graphics.points(node.x,node.y)
    end
    love.graphics.points(width/2,300)
    love.graphics.setPointSize(1)
    for i,v in ipairs(aliens) do
      love.graphics.setColor(255,0,0)
      love.graphics.setLineWidth(2)
      love.graphics.line(v.pos.x+v.width/2, v.pos.y+v.height/2, v.pos.x+v.vel.x*4+v.width/2, v.pos.y+v.vel.y*4+v.height/2)
      love.graphics.setLineWidth(1)
      if v.type == "bug" then 
        love.graphics.rectangle("line",v.pos.x-v.width/2,v.pos.y-v.height/2,v.width,v.height)
      else
        love.graphics.rectangle("line",v.pos.x,v.pos.y,v.width,v.height)
      end
    end
    laserx,laserw = player.x+player.width/2-img.laser:getWidth()/2,img.laser:getWidth()
    love.graphics.rectangle("line", laserx, 0, laserw, height)
    love.graphics.rectangle("line",player.x,player.y,player.width,player.height)
    love.graphics.setFontSize(45)
    fps = round(1/love.timer.getAverageDelta(),2)
    love.graphics.print("FPS: "..fps,10,height-fontHeight())
  end
  level.postdraw()
  love.graphics.setColor(white)
  
end

function keypressed(key)
  if key=="escape" then
    if not slomo  then
      transition(menu.pause,254)
    end
  end
  if key==controls.fire and not slomo and not player.laser then
    player.fire()
    fireStarted = frameCount
  end
  if key==controls.select and doingDialogue then
    if math.floor((frameCount-dialogueStarted)/2)<string.len(dialogueText) and not dialogueDone then
      dialogueDone=true
    else
      doingDialogue=false
    end
  end
  keyboardInput = true
end

function gamepadpressed(joystick, button)
  if button=="a" and not slomo and not player.laser then
    player.fire()
  end
  if button=="x" and doingDialogue and not dialogueCon then
    if math.floor((frameCount-dialogueStarted)/2)<string.len(dialogueText) and not dialogueDone then
      dialogueDone=true
    else
      doingDialogue=false
    end
  end
  if button=="start" then
    transition(menu.pause)
  end
  keyboardInput = false
end