-- this file is for various things that don't fit anywhere else
white = {255,255,255,255}
black = {0,0,0,255}
random = love.math.random
love.math.setRandomSeed(os.time())
width, height = love.graphics.getDimensions()
version = "ALPHA 1"
load = false
back = false
alpha = 0

-- update 11/29: this code is so fucking retarded i swear to god matthew what the hell
function cur(module) -- modules can have these four functions, makes additions easier
  curupdate = module.update
  curdraw = module.draw -- only draw is required
  curmouse = module.mouse
  curesc = module.esc
  if not module.music:isPlaying() then -- modules have their own music
    love.audio.stop()
    module.music:play()
    module.music:setLooping(true)
  end
end

function miscupdate()
  frameCount = frameCount + 1
  mouseX, mouseY = love.mouse.getPosition()
  if load then
    if back then
      alpha = alpha - 25
    else
      alpha = alpha + 25
    end
    if alpha >= 255 then
      back = true
      aftload()
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