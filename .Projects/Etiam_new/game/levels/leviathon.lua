module("leviathon", package.seeall)

function setup()
  matt.music.play("battle")
  aliensKilled = 0
end

function update()
  if frameCount % 100 == 0 then
    Obstacle:new(img.junk)
  end
  
  if #aliens == 0 then
    for i=1,50 do
      Diamond:new()
    end
  end
end


function draw()end