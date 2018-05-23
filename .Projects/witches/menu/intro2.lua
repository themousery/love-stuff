module("intro2", package.seeall)
function update()end
function draw()
  drawForest()
  love.graphics.setColor(236, 220, 176)
  love.graphics.rectangle("fill", 100, 100, 600, 400)
  love.graphics.setColor(193, 152, 117)
  love.graphics.setLineWidth(3)
  love.graphics.rectangle("line", 100, 100, 600, 400)
  love.graphics.printf("Ah, of course! Anyway, you're late, you must make the final decision on these witches. We have three potential witches here, you must use your wisdom to determine who is the real witch.",110,210,590,"left")
end
function keypressed(key)
   transition(game)
end
