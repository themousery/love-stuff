module("title_card", package.seeall)
matt.system.makeModule("title_card", menu)

cards = {}
cards["ch1"] = {"Chapter 1:", "Escape"}

function setCard(name)
  card = cards[name]
end

function setup()
  counter = 0
  current_line = 1
  alpha = {0,0,3.5}
  matt.music.play("transition")
end

function update()
  alpha[current_line] = alpha[current_line] + 0.04
  if alpha[current_line] >= 3.5 and current_line < #card then
    current_line = current_line + 1
  end
  if alpha[2] >= 6 then
    matt.graphics.transition(game)
    game.setLevel("starting_scene")
  end
end

function draw()
  for i,v in ipairs(card) do
    love.graphics.setColor(255,255,255,alpha[i])
    matt.graphics.printf(v, 0, height/2-matt.graphics.getFontHeight()-50+i*50, width, "center")
  end
  love.graphics.setColor(white)
  if frameCount%100==0 then love.graphics.draw(img.ufo, 10,10) end
end