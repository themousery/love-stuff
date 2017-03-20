require "frog"
require "board"
require "car"

function love.load()
  frog_img = love.graphics.newImage("images/frog.png")
  road_img = love.graphics.newImage("images/road.png")

  love.window.setTitle("this is a failure")

  cars = {}
  frameCount = 0
end

function love.update()
  frameCount = frameCount + 1
  if frameCount % 120 == 0 then
    table.insert(cars, Car:new())
  end
  if frameCount % 30 == 0 then
    for i,car in ipairs(cars) do
      car:update()
    end
  end
end

function love.draw()
  drawBoard()
end

function love.keypressed(key)
  if key == "up" then
    frog.y = frog.y - 1
  elseif key == "down" then
    frog.y = frog.y + 1
  elseif key == "right" then
    frog.x = frog.x + 1
  elseif key == "left" then
    frog.x = frog.x - 1
  end
end
