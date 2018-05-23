module("pause", package.seeall)
makeModule("pause", menu)

cursorOn=1
function setup()
  if gamepad then gamepad:setVibration(0,0) end
  cursorOn=1
  isMenu = true
  exit = arcade
  options = {"resume","options","quit"}
  y = {150,100}
  left = 444
  w = 478
  title = "Pause"
  green = true
  actions = {
    arcade, 
    function()
      transition(menu.options,255)
      menu.options.back = menu.pause
    end,
    menu.title
  }
end
function update()
  -- updateStars()
  if menuUp and cursorOn > 1 then
    cursorOn = cursorOn-1
  end
  if menuDown and cursorOn < #pause_options then
    cursorOn = cursorOn+1
  end
end
function draw()
  drawMenu()
end

function gamepadpressed(joystick, button)
  if button=="start" then
    transition(arcade,255)
    love.mouse.setVisible(false)
  end
  if button=="a" then
    m = cursorOn
    mouse()
  end
end