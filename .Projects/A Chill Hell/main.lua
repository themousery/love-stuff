require "menu"
require "misc"
require "game"
-- screen dimensions : 800x600

function love.load()
  require "loadFiles"
  cur = menu.title
  music.menu:play()
  music.menu:setLooping(true)
end

function love.update()
  miscUpdate()
  cur.update()
end

function love.draw()
  cur.draw()
  miscDraw()
end

function love.mousereleased()
  cur.mouse()
end

function love.keypressed(key)
  if cur.keypressed then cur.keypressed(key) end
end

function love.textinput(t)
  if cur.textinput then cur.textinput(t) end
end
