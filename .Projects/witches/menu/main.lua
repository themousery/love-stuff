options={"Play", "Credits", "Exit"}

main = {}
function main.update()end
function main.draw()
  mouse:set("arrow")
  drawForest()
  love.graphics.setColor(22,22,29,220)
  love.graphics.rectangle("fill", 0,90,width,100)
  love.graphics.setColor(115,115,186)
  font:set("title")
  love.graphics.printf("Witch Hunt", 0, 100, width, "center")
  love.graphics.setColor(255,255,255)
  font:set("menu_options")
  m = false
  for i,v in ipairs(options) do
    if (mouseY>i*100+150 and mouseY<i*100+180) then
      love.graphics.setColor(200,0,0)
      m = i
      mouse:set("hand")
    else
      love.graphics.setColor(255,255,255)
    end
    love.graphics.printf(v, 0, i*100+150, width, "center")
  end
end

function main.mousereleased()
  if m==1 then
    transition(intro)
  elseif m==3 then
    transition(quit)
  end
end
