module("endless", package.seeall)

function setup()
  playMusic("arcade")
end

function update()
  updateStars()
  if #aliens==0 then
    UFO:new()
  end
  if random(750)==1 then
    UFO:new()
  end
  if random(750)==1 then
    Bug:new()
  end
  if frameCount%30==0 then
    table.insert(obstacles,Obstacle:new(img.asteroid))
  end
  if random(750)==1 then
    table.insert(powerups,Powerup:new())
  end
end

function predraw()end

function postdraw()end