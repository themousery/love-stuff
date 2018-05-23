function love.conf(t)
  t.window.fullscreen = true
  t.window.resizable = true
  t.window.title = "Etiam"
  t.window.width = 910
  t.window.height = 512
  t.version = "0.10.2"
  t.identity = "MouseryGames/Etiam"
  t.console = not love.filesystem.isFused()
end
