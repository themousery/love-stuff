function dialogue(img, input)
  dialogueImg = img
  doingDialogue = true
  dialogueDone=false
  dialogueText = input
  dialogueStarted = frameCount
  sound.talk:play()
end

function drawDialogue()
  --183x177
  love.graphics.setColor(93,146,81)
  love.graphics.rectangle("fill",20,height-197,width-40,177)
  love.graphics.setColor(49,255,0)
  love.graphics.setLineWidth(3)
  love.graphics.rectangle("line",20,height-196,width-40,175)
  love.graphics.rectangle("line",29,height-187,width-225,157)
  love.graphics.setColor(white)
  love.graphics.setFontSize(30)
  if dialogueDone then
    if dialogueImg == img.static then
      love.graphics.draw(dialogueImg[math.floor(((frameCount-dialogueStarted)%(#dialogueImg*8))/8)+1],width-203,height-197)
    else
      love.graphics.draw(dialogueImg[1],width-203,height-197)
    end
    love.graphics.setColor(49,255,0)
    if sound.talk:isPlaying() then
      sound.talk:stop()
    end
    -- love.graphics.setShader(shader)
    love.graphics.printf(dialogueText,40,height-177,width-257,"left")
    -- love.graphics.setShader()
  else
    love.graphics.draw(dialogueImg[math.floor(((frameCount-dialogueStarted)%20)/10)+1],width-203,height-197)
    love.graphics.setColor(49,255,0)
    if math.floor((frameCount-dialogueStarted)/2)>=string.len(dialogueText) then
      dialogueDone=true
    end
    -- love.graphics.setShader(shader)
    love.graphics.printf(string.sub(dialogueText,1,math.floor((frameCount-dialogueStarted)/2)),40,height-177,width-257,"left")
    -- love.graphics.setShader()
    love.graphics.setColor(white)
    if gameState ~= menu.pause and (frameCount-dialogueStarted)/2 == math.floor((frameCount-dialogueStarted)/2) then
      sound.talk:play()
    end
  end
  if dialogueImg.blink and math.floor((frameCount%250)/5) == 1 then
    love.graphics.setColor(white)
    love.graphics.draw(dialogueImg.blink, width-203, height-197)
  end
  if dialogueImg.extra then
    love.graphics.setColor(white)
    love.graphics.draw(frame(dialogueImg.extra,5),width-203, height-197)
  end
  love.graphics.setColor(0,255,0)
  love.graphics.print("press "..controls.select, width-225-fontWidth("press "..controls.select), height-65)
end