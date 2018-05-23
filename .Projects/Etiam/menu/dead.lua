module("dead", package.seeall)

function setup()
  cursorOn = 1
  options = {"restart","quit"}
  isMenu = true
  exit = menu.title
  y = {200,100}
  left = 444
  w = 478
  title = "Game Over"
  green = true
  actions = {
    function()
      arcade.resetGame()
      transition(arcade,255)
      if level == levels["tutorial"] then
        if level.alminus then
          arcade.setLevel(tutorial)
          level.currentDialogue = 20
          level.attackStarted=-1000
          level.alminus=true
          stopMusic()
        else
          arcade.setLevel(tutorial)
          level.currentDialogue = 16
          playMusic("arcade")
        end
      end
    end,
    menu.title
  }
end

function update()
  -- updateStars()
  if menuUp and cursorOn > 1 then
    cursorOn = cursorOn-1
  end
  if menuDown and cursorOn < #dead_options then
    cursorOn = cursorOn+1
  end
end

function draw()
  drawMenu()
  -- drawStars()
  -- love.graphics.setColor(black)
  -- love.graphics.line(width,0,width,height)
  -- love.graphics.setColor(white)
  -- love.graphics.draw(img.menu,0,0)
  -- love.graphics.setFontSize(50)
  -- love.graphics.setColor(49,255,0)
  -- love.graphics.printf("Game Over", 0,100,width,"center")
  -- local w,h = (width-400)/2,(height-400)/2
  -- love.graphics.setFontSize()
  -- for i,v in ipairs(dead_options) do
  --   if mouseInput and mouseY >= i*200+100 and mouseY <= i*200+100+font.options:getHeight() and mouseX >= 443 and mouseX <= 922 then
  --     cursorOn = i
  --     love.mouse.setCursor(cursor.hand)
  --   end
  --   love.graphics.setColor(49,255,0)
  --   love.graphics.printf(v, w, i*200+100, 400, "center")
  --   love.graphics.setColor(white)
  -- end
  -- love.graphics.draw(img.cursor, 463, cursorOn*200+100)
end

-- function mouse()
--   if cursorOn == 1 then
--     arcade.resetGame()
--     transition(arcade,255)
--     if level == levels["tutorial"] then
--       if level.alminus then
--         arcade.setLevel(tutorial)
--         level.currentDialogue = 20
--         level.attackStarted=-1000
--         level.alminus=true
--         stopMusic()
--       else
--         arcade.setLevel(tutorial)
--         level.currentDialogue = 16
--         playMusic("arcade")
--       end
--     end
--   elseif cursorOn == 2 then
--     transition(menu.title)
--     arcade.resetGame()
--   end
-- end

-- function keypressed(key)
--   if key==controls.up and cursorOn>1 then
--     cursorOn=cursorOn-1
--   elseif key==controls.down and cursorOn<#dead_options then
--     cursorOn=cursorOn+1
--   elseif key==controls.select then
--     mouse()
--   end
-- end

function gamepadpressed(joystick, button)
  if button=="a" then
    mouse()
  end
end