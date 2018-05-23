shoptions = {"MONEY PER CLICK  $", "AUTOCLICKS  $"}
shopprices = {1,1}
function drawShop()
  love.graphics.setColor(0,0,0)
  love.graphics.rectangle("fill",0,0,width,height)
  love.graphics.setColor(white)
  love.graphics.rectangle("line",1,1,width-1,height-1)
  love.graphics.setColor(white)
  love.graphics.print(save[currentSave][2], 0,0)
  m = false
  for i,v in ipairs(shoptions) do
    if mouseY > i*100 and mouseY < i*100+50 then
      love.graphics.setColor(blue)
      m = i
    else
      love.graphics.setColor(white)
    end
    love.graphics.printf(v..shopprices[i], 0, i*100, width, "center")
  end

  if mouseY > height-50 and mouseX < 100 then
    love.graphics.setColor(blue)
    m = -1
  else
    love.graphics.setColor(white)
  end
  love.graphics.print("BACK", 0,height-50)
  if m then
    love.mouse.setCursor(cursor.hand)
  else
    love.mouse.setCursor(cursor.reg)
  end
end
