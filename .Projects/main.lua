require "files"
require "misc"
require "vectors"
require "stars"
require "menu"
require "arcade"
matt = require "matt"

function love.load()
  frameCount = 0
  dialogueImg = img.dialogue1
  transition(menu.title,255)
  scalar = Vector:new(width/1366, height/768)
end

function love.update(dt)
  miscupdate()
  if gameState.update then gameState.update(dt)end
end

function love.draw()
  scalar = Vector:new(love.graphics.getWidth()/1366, love.graphics.getHeight()/768)
  love.graphics.scale(scalar.x,scalar.y)
  gameState.draw()
  if load then
    love.graphics.setColor(0,0,0,alpha)
    love.graphics.rectangle("fill",0,0,width,height)
  end
  love.graphics.setColor(white)
end

function love.keypressed(key)
  keyInput = true
  if gameState.keypressed then gameState.keypressed(key)end
  if key == "printscreen" then
    local screenshot = love.graphics.newScreenshot()
    screenshot:encode('png', os.time() .. '.png')
  end
  if key=="f11" then
    love.window.setFullscreen(not love.window.getFullscreen())
  end
  if not love.filesystem.isFused() then
    if key=="1" then
      love.event.quit()
    end
    if key=="2" then
      arcade.setLevel(tutorial)
      transition(arcade,255)
    end
    if key=="3" then
      arcade.setLevel(tutorial)
      transition(arcade,255)
      arcade.level.currentDialogue=20
      arcade.level.alminus=true
      arcade.level.attackStarted=-1000
    end
    if key=="4" then
      Alminus.hp=0
    end
    if key=="`" then
      debug=not debug
    end
  end
  if gameState.isMenu then
    if key=="escape" then
      if type(gameState.exit) == "function" then
        gameState.exit()
      else
        transition(gameState.exit)
      end
    end
    if key==controls.up and gameState.cursorOn>1 then
      gameState.cursorOn = gameState.cursorOn-1
    elseif key==controls.down and gameState.cursorOn<#gameState.options then
      gameState.cursorOn = gameState.cursorOn+1
    elseif key==controls.select then
      doAction()
    end
  end
end

function love.keyreleased(key)
  if gameState.keyreleased then gameState.keyreleased(key)end
end

function love.mousepressed()
  if gameState.mousepressed then gameState.mousepressed()end
end

function love.mousereleased()
  if gameState.mouse then gameState.mouse()end
  if gameState.isMenu then
    doAction()
  end
end

function love.gamepadpressed(joystick, button)
  if gameState.gamepadpressed then gameState.gamepadpressed(joystick, button) end
end

function love.joystickadded(joystick)
    gamepad = joystick
end
