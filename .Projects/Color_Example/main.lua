function love.load()
  color = {}
  cdir = {}
  src = {-1,1}
  for i=1,3 do
    table.insert(color, love.math.random(255))
    table.insert(cdir, src[love.math.random(2)])
  end
  font = love.graphics.newFont("SF Pixelate.ttf", 50)
  love.graphics.setFont(font)
end
function love.draw()
  i = love.math.random(3)
  if color[i] == 255 or color[i] == 0 then
    cdir[i] = -cdir[i]
  end
  color[i] = color[i] + cdir[i]

  for i=1,3 do
    src = {0,0,0}
    src[i] = color[i]
    love.graphics.setColor(src)
    love.graphics.print(color[i], 200*i-40, 40)
  end

  love.graphics.setColor(color)
  love.graphics.rectangle("fill", 0,100,800,500)
end
