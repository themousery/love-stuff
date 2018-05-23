--[[This is the heart of the entire application. Essentially the game is composed
    of "gameState"s that have their own update, draw, and input functions.]]

--Grabs all of the other files, besides main.lua:
require "everything"
love.graphics.setDefaultFilter("nearest","nearest")

function love.load()
  matt.setup()
  -- Make a canvas that scales to 1366x768
  matt.graphics.newCanvas(1366,768)
  gameState = menu.title
  menu.title.setup()
  matt.playing = "menu"
  matt.music.play("menu")
end

function love.update()
  matt.update()
  gameState.update()
end

function love.draw()
  matt.draw()
  gameState.draw()
  matt.graphics.drawCanvas()
end

function love.keypressed(key)
  matt.keypressed(key)
  gameState.keypressed(key)
end

function love.keyreleased()
  gameState.keyreleased()
end

function love.mousepressed()
  matt.mousepressed()
  gameState.mousepressed()
end

function love.mousereleased()
  matt.mousereleased()
  gameState.mousereleased()
end

function love.resize()
  matt.resize()
end