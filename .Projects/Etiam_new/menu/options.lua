--The options menu
module("options", package.seeall)
matt.system.makeModule("options", menu)

function setup()
  isMenu = true
  green = true
  title = "Options"
  options = {"Music", "SFX", "Controls"}
  slider =  {true, true}
  values = {save[1],save[2]}
  actions = {
    0,
    0,
    menu.controls
  }
end

function update()
  matt.music.setVolume(values[1])
  matt.sfx.setVolume(values[2])
end

function draw()
  matt.graphics.drawMenu()
end