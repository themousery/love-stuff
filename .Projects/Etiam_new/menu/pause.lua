--The pause menu
module("pause", package.seeall)
matt.system.makeModule("pause", menu)

function setup()
  isMenu = true
  green = true
  title = "Pause"
  options = {"Resume", "Options", "Quit"}
  actions = {
    game,
    menu.options,
    menu.title
  }
end

function draw()
  matt.graphics.drawMenu()
end