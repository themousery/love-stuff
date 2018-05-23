stars = {}

stars.points = {}
local sm = 350
for i=1,sm do
  table.insert(stars.points, random(1364))
  table.insert(stars.points, random(768))
end

function stars.update()
  local s = stars.points
  for i=2,#stars.points,2 do
    s[i]=s[i]+(i%3)+1
    if s[i]>height then
      s[i] = 0
      s[i-1] = random(1364)
    end
  end
end

function stars.draw()
  love.graphics.setColor(11, 11, 15)
  love.graphics.rectangle("fill",0,0,width,height)
  love.graphics.setColor(white)
  for i=2,#stars.points,2 do
    love.graphics.setPointSize(((i%3)+1)/2)
    love.graphics.points(stars.points[i-1],stars.points[i])
  end
end