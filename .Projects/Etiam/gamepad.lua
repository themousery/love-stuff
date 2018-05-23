-- TODO: add support for controllers
-- let them choose which one if there is more than one.

local gamepads = love.joystick.getActiveJoysticks()
if #gamepads == 1 then
  gamepad = gamepads[1]
end