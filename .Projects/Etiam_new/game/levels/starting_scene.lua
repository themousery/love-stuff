module("starting_scene", package.seeall)

function setup()
  player_pos = 0
  player_visible = true
  ship_pos = {width/2, height-64}
  s_counter = 0
end

function update()
  if player_pos < width/2 then
    player_pos = player_pos + 5
  else
    player_visible = false
    if s_counter > 90 then
      ship_pos[2] = ship_pos[2] - 8
    else
      s_counter = s_counter+1
    end
  end
end

function draw()
  love.graphics.setColor(135, 206, 235)
  love.graphics.rectangle("fill", 0,0,width,height)
  love.graphics.setColor(white)
  if player_visible then
    -- love.graphics.rectangle("fill", player_pos, height-50, 25, 50)
    love.graphics.draw(frame(img.man,5), player_pos, height-33)
  end
  love.graphics.draw(matt.graphics.frame(img.ship,4), ship_pos[1], ship_pos[2])
end