--The title screen
module("title", package.seeall)
matt.system.makeModule("title", menu)

function setup()
  isMenu = true
  options = {"Play", "Options", "Credits", "Exit"}
  green = false
  y = {136.5, 118}
  x = {-141, 1321}
  actions = {
    function()matt.graphics.transition(game); game.setLevel("starting_scene")end,
    menu.title_card,
    menu.credits,
    matt.quit
  }
  menu.title_card.setCard("ch1")
end

function update()
  stars.update()
end

function draw()
  stars.draw()
  love.graphics.draw(img.title,0,0)
  love.graphics.draw(img.demo,850,170)
  matt.graphics.drawMenu()
end