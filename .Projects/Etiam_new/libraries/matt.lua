-- This is a custom library made by me, with special improvements and functions for Lua/LOVE2D

matt = {}
--------------------------------------------------------------------------------
--General functions
random = love.math.random
function matt.setup()
  -- width and height of screen, before scaling.
  love.graphics.setDefaultFilter("nearest", "nearest")
  owidth, oheight = love.graphics.getDimensions()
  matt.mouseInput = true
  pX,pY = 0,0
  white = {255,255,255}
  black = {0,0,0}
  red = {255,0,0}
  green = {0,255,0}
  blue = {0,0,255}
  uiGreen = {49,255,0}
  frameCount = 0
end

function matt.update()
  frameCount = frameCount+1
  
  mouseX, mouseY = love.mouse.getPosition()
  mouseX, mouseY = mouseX/matt.scalar, mouseY/matt.scalar
  if not matt.mouseInput then
    if math.abs(mouseX-pX)>5 or math.abs(mouseY-pY)>5 then
      matt.mouseInput = true
    end
  end
  pX, pY = mouseX, mouseY
  
  if gameState.isMenu then
    if not gameState.cursorOn then
      gameState.cursorOn = 1
    end
    if gameState.cursorOn < 1 then
      gameState.cursorOn = #gameState.options
    elseif gameState.cursorOn > #gameState.options then
      gameState.cursorOn = 1
    end
  end
  
  img.cursor = matt.graphics.frame(img.cursor_src, 4)
end

function matt.draw()
  love.graphics.push()
  love.graphics.setCanvas(matt.canvas)
  love.graphics.scale(matt.scalar)
  if matt.shakingScreen then
    -- See matt.graphics.shakeScreen
    local dx = love.math.random(-mag, mag)
    local dy = love.math.random(-mag, mag)
    love.graphics.translate(dx, dy)
  end
  
  if matt.mouseHand then
    love.mouse.setCursor(cursor.hand)
    matt.mouseHand = false
  else
    love.mouse.setCursor(cursor.reg)
  end
end

function matt.keypressed(key)
  matt.mouseInput = false
  if key == "f11" then
    love.window.setFullscreen(not love.window.getFullscreen())
  end
  
  --navigate menu with keyboard
  if gameState.isMenu then
    if key == controls.up then
      gameState.cursorOn = gameState.cursorOn - 1
    elseif key == controls.down then
      gameState.cursorOn = gameState.cursorOn + 1
    end
  end
  
  if key == "`" then
    matt.debug = true
  end
end

function matt.mousepressed()
  local g = gameState
  if g.isMenu then
    if g.slider then
      for i,v in ipairs(g.slider) do
        if v and g.cursorOn == i  then
          g.sliding = i
        end
      end
    elseif matt.mouseInput then
      matt.system.doAction()
    end
  end
end

function matt.mousereleased()
  if gameState.sliding then
    gameState.sliding = false
  end
end

function matt.resize()
  owidth, oheight = love.graphics.getDimensions()
  matt.graphics.newCanvas(width, height)
end
--------------------------------------------------------------------------------
--Graphics
matt.graphics = {}
img = {}
function matt.graphics.newCanvas(x,y)
  --[[Make a new canvas of x*y that scales to the screen]]
  width, height = x,y
  matt.scalar = Vector:new(owidth/x, oheight/y)
  matt.scalar = math.min(matt.scalar.x, matt.scalar.y)
  matt.canvas = love.graphics.newCanvas(1366,786)
end

function matt.graphics.drawCanvas()
  if matt.load then
    if matt.back then
      matt.alpha = matt.alpha - matt.step
      if matt.alpha <= 0 then
        matt.load = false
      end
    else
      matt.alpha = matt.alpha + matt.step
      if matt.alpha >= 255 then
        matt.alpha = 255
        matt.back = true
        gameState = matt.aftload
        gameState.setup()
      end
    end
    love.graphics.setColor(0,0,0,matt.alpha)
    love.graphics.rectangle("fill",0,0,width,height)
  end
  
  love.graphics.setColor(white)
  love.graphics.pop()
  love.graphics.setCanvas()
  love.graphics.draw(matt.canvas, (owidth-width*matt.scalar)/2, (oheight-height*matt.scalar)/2)
end

function matt.graphics.newFont(filename, glyphs)
  --[[Sets the font to a new ImageFont.]]
  matt.font = love.graphics.newImageFont("resources/images/"..filename..".png",  glyphs, 2)
  love.graphics.setFont(matt.font)
end

function matt.graphics.setFontSize(size)
  --[[Sets the size to draw ImageFonts. See matt.graphics.print and 
      matt.graphics.printf for more information.]]
  matt.fontSize = size/30
end

function matt.graphics.print(text, x, y)
  --[[This is so ImageFonts can be resized.]]
  local s = matt.fontSize
  love.graphics.push()
  love.graphics.scale(s)
  love.graphics.setDefaultFilter("nearest", "nearest")
  love.graphics.print(text, x/s, y/s)
  love.graphics.pop()
end

function matt.graphics.printf(text, x, y, limit, align)
  --[[This is so ImageFonts can be resized.]]
  local s = matt.fontSize
  love.graphics.push()
  love.graphics.scale(s)
  love.graphics.printf(text, x/s, y/s, limit/s, align)
  love.graphics.pop()
end

function matt.graphics.getFontWidth(line)
  --[[Return the width of the font with this given line of text.]]
  return matt.font:getWidth(line)*matt.fontSize
end

function matt.graphics.getFontHeight()
  --[[Return the height of the font.]]
  return matt.font:getHeight()*matt.fontSize
end

function matt.graphics.frame(image, mult, offset)
  --[[Easily go through a table of images at a certain speed, and optionally
      have an offset]]
    offset = offset or 0
    return image[math.floor(((frameCount-offset)%(#image*mult))/mult)+1]
end
frame = matt.graphics.frame

function matt.graphics.shakeScreen(mag)
  --[[Shake the screen around on the next frame]]
  matt.shakingScreen = true
  matt.shakeMag = mag
end

function matt.graphics.newImage(filename)
  --[[This saves me the trouble of writing "resources/images/" every time.]]
  return love.graphics.newImage("resources/images/"..filename..".png")
end

function matt.graphics.newImages(filename, n)
  --[[Returns a table with multiple images, useful for images having multiple frames]]
  local images = {}
  for i=1,n do
    table.insert(images,matt.graphics.newImage(filename.."/"..i))
  end
  return images
end

function matt.graphics.massImage(filenames)
  --[[Load a bunch of images at once, based on their names]]
  for i,filename in ipairs(filenames) do
    img[filename] = matt.graphics.newImage(filename)
  end
end

function matt.graphics.massImages(names)
  --[[Load a bunch of multi-framed images]]
  for i=2,#names,2 do
    name = names[i-1]
    n = names[i]
    img[name] = matt.graphics.newImages(name, n)
  end
end

function matt.graphics.drawMenu()
  --[[Easily draw a menu based on the current gameState. This is probably the messiest
      function of the lot, but it works as intended.]]
  local g = gameState
  if g.green then
    g.left, g.right = 500, 866
    g.x, g.w = {0, g.left}, g.right-g.left
    g.y = {500/#g.options, 75}
    stars.update()
    stars.draw()
    love.graphics.setColor(white)
    love.graphics.draw(img.greenMenu, 0,0)
    love.graphics.setColor(uiGreen)
    matt.graphics.setFontSize(75)
    matt.graphics.printf(g.title, 0,100,width,"center")
  end
  matt.graphics.setFontSize(40)
  local cY,cX,h,w
  for i,v in ipairs(g.options) do
    cY = g.y[1]*i + g.y[2]
    h = matt.graphics.getFontHeight()
    if g.left then
      cX = g.left
      w = g.w
      if g.slider and g.slider[i] then
        local x,y = 630, cY+matt.graphics.getFontHeight()/2-4
        if g.sliding==i then
          g.values[i] = matt.math.map(mouseX, x,900, 0,100)
        end
        if g.values[i] > 100 then g.values[i] = 100 end
        if g.values[i] < 0 then g.values[i] = 0 end
        w = 922-g.left
        matt.graphics.print(v, g.left, cY)
        love.graphics.rectangle("fill", x, y, 900-x, 4)
        love.graphics.draw(img.slider, matt.math.map(g.values[i], 0,100, x,900)-img.slider:getWidth()/2, y-img.slider:getHeight()/2)
      else
        matt.graphics.printf(v, g.left, cY, w, "center")
      end
    else
      cX = g.x[1]*i + g.x[2]
      w = matt.graphics.getFontWidth(v)
      matt.graphics.print(v, cX, cY)
    end
    if matt.mouseInput and mouseX>cX and mouseX<cX+w and mouseY>cY and mouseY<cY+h then
      g.cursorOn = i
      matt.mouseHand = true
    end
  end
  love.graphics.setColor(white)
  love.graphics.draw(img.cursor, g.x[1]*g.cursorOn + g.x[2] - 50, g.y[1]*g.cursorOn + g.y[2])
end

function matt.graphics.transition(module, n)
  --[[Transition to another gameState]]
  matt.load = true
  matt.aftload = module
  matt.alpha = 0
  matt.back = false
  matt.step = n or 25
end

function HSL(h, s, l, a)
  -- converts hsl to rgb
  if s<=0 then return l,l,l,a end
  h, s, l = h/256*6, s/255, l/255
  local c = (1-math.abs(2*l-1))*s
  local x = (1-math.abs(h%2-1))*c
  local m,r,g,b = (l-.5*c), 0,0,0
  if h < 1     then r,g,b = c,x,0
  elseif h < 2 then r,g,b = x,c,0
  elseif h < 3 then r,g,b = 0,c,x
  elseif h < 4 then r,g,b = 0,x,c
  elseif h < 5 then r,g,b = x,0,c
  else              r,g,b = c,0,x
  end return (r+m)*255,(g+m)*255,(b+m)*255,a
end
--------------------------------------------------------------------------------
--[[Audio: This is split into a "sfx" and a "music" module. Each has a sources 
    table that contains the audio file objects.]]
matt.sfx = {}
matt.sfx.sources = {}
function matt.sfx.new(names)
  --[[Load new sound files and put it in the sources table.]]
  for i,name in ipairs(names) do
    matt.sfx.sources[name] = love.audio.newSource("resources/sfx/"..name..".wav")
  end
end

function matt.sfx.play(name)
  --[[Rewind the sound and play it. If I didn't rewind it and it was already playing,
      It wouldn't play it again, since it was already playing.]]
  matt.sfx.sources[name]:rewind()
  matt.sfx.sources[name]:play()
end

function matt.sfx.setVolume(volume)
  for k,sfx in ipairs(matt.sfx.sources) do
    sfx:setVolume(volume/100)
  end
end

matt.music = {}
matt.music.sources = {}
function matt.music.new(names)
  --[[Load new sound files and put it in the sources table.]]
  for k,name in pairs(names) do
    matt.music.sources[name] = love.audio.newSource("resources/music/"..name..".mp3")
  end
end

function matt.music.stop()
  --[[Stop the current playing music.]]
  matt.music.sources[matt.playing]:stop()
  matt.playing = nil
end

function matt.music.play(name)
  --[[Stop the current playing music and play another one. This prevents
      multiple background music files from playing.]]
  matt.music.stop()
  matt.music.sources[name]:play()
  matt.music.sources[name]:setLooping(true)
  matt.playing = name
end

function matt.music.setVolume(volume)
  for k,music in pairs(matt.music.sources) do
    music:setVolume(volume/100)
  end
end
--------------------------------------------------------------------------------
--Filesystem
matt.system = {}

function matt.system.require(path, names)
  --[[This is in case the init.lua being required sets the require path to 
      something else]]
  for i,name in ipairs(names) do
    require(path.."/"..name)
  end
end

function matt.system.makeModule(name, p)
  --[[Set up a gameState with this name. Optional parameter 'p' for parent.]]
  p = p or _G
  local f = function()end
  local funcs = {
    "setup",
    "update",
    "draw",
    "keypressed",
    "keyreleased",
    "mousepressed",
    "mousereleased",
    "gamepadpressed"
  }
  for i,func in ipairs(funcs) do
    if not p[name][func] then p[name][func] = f end
  end
end

function matt.system.doAction()
  --[[What to do when an option in a menu is selected]]
  local a = gameState.actions[gameState.cursorOn]
  if type(a) == "function" then
    a()
  else
    matt.graphics.transition(a)
  end
end
--------------------------------------------------------------------------------
matt.math = {}
function matt.math.map(n, start1, stop1, start2, stop2)
  --[[Map a value from one scale to another]]
  return (n-start1) / (stop1-start1) * (stop2-start2) + start2
end

function matt.math.choice(l)
  --[[Choose a random item from a list]]
  return l[random(#l)]
end
--------------------------------------------------------------------------------
-- Misc
matt.quit = {}
matt.system.makeModule("quit", matt)
matt.quit.setup = function() love.event.quit() end

function table.tostring(t)
  local s = "{"
  for k,v in pairs(t) do
    s=s..v..", "
  end
  return s.."}"
end
--------------------------------------------------------------------------------