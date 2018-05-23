-- this file is for various things that don't fit anywhere else
white = {255,255,255,255}
black = {0,0,0,255}
random = love.math.random
love.math.setRandomSeed(os.time())
math.randomseed(os.time())
owidth, oheight = love.graphics.getDimensions()
width, height = 1366,768
pMouseX, pMouseY = 0,0
version = "alpha 0.2"
load = false
back = false
alpha = 0
quit = {}
debug = false
mouseInput = true
stickUp = true
function quit.update()
  love.event.quit()
end
function quit.draw()end
blank = {}
function blank.draw() 
  love.graphics.setColor(black)
  love.graphics.rectangle("fill",0,0,width,height)
end

function transition(module, t)
  time = t or 25
  if time == 255 then
    gameState = module
    if gameState.setup then gameState.setup()end
  else
    aftload = module
    load = true
  end
end

function saveGame()
  love.filesystem.write(".sav", "")
  for i,v in ipairs(save) do
    love.filesystem.append(".sav", v)
    love.filesystem.append(".sav", "\r\n")
  end
end


function miscupdate()
  ticker=0
  img.cursor = img.cursor_src[math.floor((frameCount%12)/4)+1]
  if gameState ~= arcade and not love.mouse.isVisible() then love.mouse.setVisible(true) end
  love.mouse.setCursor(cursor.reg)
  width = 1366
  height = 768
  frameCount = frameCount + 1
  mouseX, mouseY = love.mouse.getPosition()
  mouseX = map(mouseX,0,love.graphics.getWidth(),0,1366)
  mouseY = map(mouseY,0,love.graphics.getHeight(),0,768)
  menuUp = false
  menuDown = false
  if gamepad then
    local leftstick = gamepad:getGamepadAxis("lefty")
    if leftstick > 0.8 and stickup then
      menuDown = true
    elseif leftstick < -0.8 and stickup then
      menuUp = true
    end
    if leftstick > 0.8 or leftstick < -0.8 then
      mouseInput = false
      stickup = false
    else
      stickup = true
    end
  end
  if math.abs(mouseX-pMouseX)>20 or math.abs(mouseY-pMouseY)>20 then
    mouseInput = true
    keyInput = false
  end
  pMouseX = mouseX
  pMouseY = mouseY
  if load then
    if back then
      alpha = alpha - time
    else
      alpha = alpha + time
    end
    if alpha >= 255 then
      back = true
      gameState = aftload
      if gameState.setup then gameState.setup()end
    end
    if alpha <= 0 and back then
      alpha = 0
      back = false
      load = false
    end
  end
end

function num(var)
  return var and 1 or 0
end

function map(n, start1, stop1, start2, stop2)
  return (n-start1) / (stop1-start1) * (stop2-start2) + start2
end

function choice(t)
  return t[random(#t)]
end

function open_url(url)
  local OS = love.system.getOS()
  if OS == "OS X" then
    os.execute('open "" "' .. url .. '"')
  else
    os.execute('start "" "' .. url .. '"')
  end
end

function shakeScreen(mag)
  local dx = love.math.random(-mag, mag)
  local dy = love.math.random(-mag, mag)
  love.graphics.translate(dx, dy)
end

function round(v, p)
  local mult = math.pow(10, p or 0) -- round to 0 places when p not supplied
  return math.floor(v * mult + 0.5) / mult;
end

function table.clone(org)
  return {unpack(org)}
end
function table.val_to_str ( v )
  if "string" == type( v ) then
    v = string.gsub( v, "\n", "\\n" )
    if string.match( string.gsub(v,"[^'\"]",""), '^"+$' ) then
      return "'" .. v .. "'"
    end
    return '"' .. string.gsub(v,'"', '\\"' ) .. '"'
  else
    return "table" == type( v ) and table.tostring( v ) or
      tostring( v )
  end
end

function table.key_to_str ( k )
  if "string" == type( k ) and string.match( k, "^[_%a][_%a%d]*$" ) then
    return k
  else
    return "[" .. table.val_to_str( k ) .. "]"
  end
end
function table.tostring( tbl )
  local result, done = {}, {}
  for k, v in ipairs( tbl ) do
    table.insert( result, table.val_to_str( v ) )
    done[ k ] = true
  end
  for k, v in pairs( tbl ) do
    if not done[ k ] then
      table.insert( result,
        table.key_to_str( k ) .. "=" .. table.val_to_str( v ) )
    end
  end
  return "{" .. table.concat( result, "," ) .. "}"
end

function makeModule(name, p)
  p = p or _G
  local f = function()end
  p[name].setup = f
  p[name].update = f
  p[name].draw = f
  p[name].keypressed = f
  p[name].keyreleased = f
  p[name].mousepressed = f
  p[name].mouse = f
  p[name].gamepadpressed = f
end

function drawMenu()
  local g = gameState
  if g.green then
    updateStars()
    drawStars()
    love.graphics.setColor(black)
    love.graphics.line(width,0,width,height)
    love.graphics.setColor(white)
    love.graphics.draw(img.menu)
    love.graphics.setColor(49,255,0)
    love.graphics.setFontSize(50)
    love.graphics.printf(g.title, 0,100,width,"center")
  end
  love.graphics.setFontSize(45)
  love.graphics.setColor(white)
  love.graphics.draw(img.cursor, g.left+20, g.cursorOn*g.y[1]+g.y[2]+10)
  for i,v in ipairs(g.options) do
    love.graphics.setColor(49,255,0)
    currentY = i*g.y[1]+g.y[2]
    love.graphics.printf(v, g.left, currentY, g.w, "center")
    if mouseY > currentY and mouseY < currentY+fontHeight() and not keyInput then
      love.mouse.setCursor(cursor.hand)
      g.cursorOn = i
    end
  end
end

function doAction()
  local a = gameState.actions[gameState.cursorOn]
  if type(a) == "function" then
    a()
  else
    transition(a)
  end
end

function frame(image,mult,offset)
  offset = offset or 0
  return image[math.floor(((frameCount-offset)%(#image*mult))/mult)+1]
end

old_printf = love.graphics.printf
love.graphics.printf = function(a,b,c,d,e)
  local s = fontSize
  love.graphics.push()
  love.graphics.scale(s)
  old_printf(a,b/s,c/s,d/s,e)
  love.graphics.pop()
end

old_print = love.graphics.print
love.graphics.print = function(a,b,c)
  local s = fontSize
  love.graphics.push()
  love.graphics.scale(s)
  old_print(a,b/s,c/s)
  love.graphics.pop()
end

love.graphics.setFontSize = function(s)
  fontSize = s/30
end

function fontHeight()
  return font:getHeight()*fontSize
end

function fontWidth(s)
  return font:getWidth(s)*fontSize
end

function setRequirePath(s)
  love.filesystem.setRequirePath(s.."/?.lua;"..s.."/?/init.lua")
end