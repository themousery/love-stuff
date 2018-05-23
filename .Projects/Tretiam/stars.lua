stars = {}
for i=1,500 do
  table.insert(stars, random(width))
  table.insert(stars, random(height))
end

function updateStars()
  for i=2,#stars,2 do
    if slomo then
      stars[i]=stars[i]+(((i%3)+1)/10)
    else
      stars[i]=stars[i]+(i%3)+1
    end
    if stars[i]>height then
      stars[i] = 0
      stars[i-1] = random(width)
    end
  end
end

function drawStars()
  love.graphics.points(stars)
end