alien_path = Path:new({Vector:new(100,75),Vector:new(1366-100,75)},25)

function setLevel(l)
  level = levels[l]
  level.setup()
  resetGame()
end

function resetGame()
  score = 0
  ba = 0
  player:setup()
  glasers = {}
  blasers = {}
  obstacles = {}
  aliens = {}
  world = {glasers, blasers, obstacles, aliens, {player}}
end


function update()
  --make the stars move
  stars.update()
  
  --do collisions (see game/collisions.lua)
  collisions()
  
  --update everything in the world.
  for i,type in ipairs(world) do
    for j,object in ipairs(type) do
      object:update(j)
    end
  end
  
  --make the level do it's thing
  level.update()
end

function draw()
  stars.draw()
  
  --draw everything in the world.
  for i,v in ipairs(world) do
    for j,a in ipairs(v) do
      a:draw()
    end
  end
  
  --bleed
  if bleed then 
    if goback then 
      ba = ba - 3
      if ba <= 0 then
        bleed = false
        ba = 0
        goback = false
      end
    else
      ba = ba + 3
      if ba>=50 then
        goback = true
      end
    end
    love.graphics.setColor(255,0,0,ba)
    love.graphics.rectangle("fill", 0,0,width,height)
  end
  
  --let the level draw things if neccesary
  level.draw()
end

function keypressed(key)
  if key==controls.fire then
    fireStarted = frameCount
  elseif key=="escape" then
    matt.graphics.transition(menu.pause, 255)
  end
end

matt.system.makeModule("game")