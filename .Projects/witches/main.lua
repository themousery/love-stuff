require("game")
require("menu")
require("misc")
require("loadFiles")

function love.load()
  gameState = menu.main
  music:set("title")
end

function love.update()
  miscUpdate()
  gameState.update()
end

function love.draw()
  gameState.draw()
  miscDraw()
end

function love.keypressed(key)
  if key=="escape" then
    love.event.quit()
  end
  if gameState.keypressed then gameState.keypressed(key)end
end

function love.mousereleased()
  if gameState.mousereleased then gameState.mousereleased() end
end

function love.textinput(t)
  if gameState.textinput then gameState.textinput(t)end
end
