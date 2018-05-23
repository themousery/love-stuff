module("tutorial", package.seeall)
function spawnWave()
  UFO:new(3)
  UFO:new(2,-81,random(0,100))
  UFO:new(2,width,random(0,100))
  Bug:new()
end
function setup()
  started = nil
  wait = math.huge
  Alminus:setup()
  aliensKilled = 0
  alminus = false
  attackStarted = nil
  arcade.aliensKilled=0
  _G.aliensKilled=0
  victory = false
  victoryStarted = nil
  currentDialogue = 2
  if controls.up == "up" and controls.down == "down" and controls.right == "right" and controls.left == "left" then
    moveControls = "the arrow keys"
  else
    moveControls = string.upper(controls.up..controls.left..controls.down..controls.right)
  end
  dialogueTodo = {
    img.dialogue1, "heck?",
    img.main, "heck.",
    img.dialogue1, "heck",
    img.dialogue1, "heck",
    img.main, "heck...",
    img.dialogue1, "heck.",
    img.dialogue1, "heck!",
    img.dialogue1, "heck...",
    -- alien fight, kill 15 of them
    img.dialogue1, "heck... he-",
    img.static, "heck",
    img.static, "heck.", -- alminus enters
    img.main, "hec-",
    img.static, "heck.",
  }
  ifDo = {}
  for i=1,#dialogueTodo do table.insert(ifDo, function()return true end) end
  ifDo[18] = function()
    return aliensKilled >= 15 and #aliens == 0
  end
  
  whatDo = {}
  whatDo[18] = function()
    if save[1] == "0" then 
      save[1] = "1"
      saveGame()
    end
    if not doingDialogue then
      if aliensKilled < 15 then
        if not music.arcade:isPlaying() then playMusic("arcade") end
        if #aliens == 0 then
          spawnWave()
        end
        if frameCount % 60 == 0 then
          Obstacle:new(img.junk)
        end
        if frameCount % 150 == 0 then
          Powerup:new()
        end
      end
    end
  end
  
  whatDo[22] = function()
    stopMusic()
    sound.rumble:play()
    if not attackStarted then attackStarted = frameCount end
    if frameCount-attackStarted >= 180 then
      love.keypressed(controls.select)
    end
  end
  
  whatDo[24] = function()
    if #bosses == 0 then
      table.insert(bosses, Alminus)
      alminus = true
      playMusic("boss")
      for i=1,20 do
        Powerup:new(i*(width/20),0,5,7)
      end
    end
  end
  
  whatDo[28] = function()
    if not doingDialogue then
      if frameCount % 150 == 0 then
        Powerup:new()
      end
    end
  end
  
  playMusic("tutorial")
end

function update()
  updateStars()
  local l,n = dialogueTodo, currentDialogue -- shortcuts for lengthy names
  if not started and not load then
    started = frameCount
  elseif n<=#l and ifDo[n]() and not doingDialogue then
    dialogue(l[n-1], l[n])
    n=n+2
  elseif whatDo[n] then
    whatDo[n]()
  end
  currentDialogue = n
end

function predraw()
  if currentDialogue==22 and attackStarted and frameCount-attackStarted<=180 then
    shakeScreen(10)
  end
  if alminus and Alminus.hp <= 0 then
    if victory then
      if frameCount-victoryStarted <= 240 then
        shakeScreen(10)
        sound.rumble:play()
      end
    else
      stopMusic()
      victory = true
      victoryStarted = frameCount
    end
  end
end

function postdraw()
  if alminus and Alminus.hp <= 0 and victory and frameCount-victoryStarted <= 180 then
    love.graphics.setColor(255,255,255,50)
    -- love.graphics.rectangle("fill",0,0,width,height)
  elseif victory and frameCount-victoryStarted >= 240 then
    love.graphics.setColor(black)
    love.graphics.rectangle("fill",0,0,width,height)
    love.graphics.setColor(white)
    love.graphics.setFontSize(50)
    love.graphics.printf("To be continued...", 0,(height-fontHeight())/2,width,"center")
  end
  if victory and frameCount-victoryStarted >= 360 then
    transition(menu.level_select)
  end
end