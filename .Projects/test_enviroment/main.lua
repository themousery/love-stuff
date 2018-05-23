function love.load()
  x,y = 801,70
  width, height = love.graphics.getDimensions()
end

function love.update()

end

function love.draw()
  love.graphics.rectangle("fill", (width-x)/2, (height-y)/2, x, y)
end
