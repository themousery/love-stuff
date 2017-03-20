-- in every language:
-- board = {}
-- for x=1,10 do
--   board[x] = {}
--   for y=1,5 do
--     board[x][y] = 0
--   end
-- end

-- in Python: board = [[0]*5]*10 ... I'm really tired of hearing Python isn't as powerful as other languages.

function drawBoard()
  for x=1,10 do
    for y = 1,5 do
      love.graphics.draw(road_img, x*64,y*64)
    end
  end
  love.graphics.draw(frog_img, frog.x*64, frog.y*64)
  for i,car in ipairs(cars) do
    love.graphics.rectangle("fill", car.x*64, car.y*64, 64, 54)
  end
end
