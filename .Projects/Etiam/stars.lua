stars = {}
sm = 350
for i=1,sm do
  table.insert(stars, random(1365))
  table.insert(stars, random(768))
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
  love.graphics.setColor(11, 11, 15)
  love.graphics.rectangle("fill",0,0,width,height)
  love.graphics.setColor(white)
  for i=2,#stars,2 do
    love.graphics.setPointSize(((i%3)+1)/2)
    love.graphics.points(stars[i-1],stars[i])
  end
end