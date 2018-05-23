title = {}
title.title_table = {
  {100,75,255},"T",
  {139,81,210},"R",
  {178,88,165},"E",
  {216,94,120},"V",
  {255,100,75},"O",
  {255,100,75},"R"}
title.options = {"trevor", "trevor", "trevor"}
title.options_colors = {{100,75,255},{178,88,165},{255,100,75}}
function title.draw()
  self = menu.title
  love.graphics.setFont(font.title)
  love.graphics.printf(self.title_table, 0, 50, width, "center")
  love.graphics.setFont(font.little)
  love.graphics.setColor(100,75,255)
  love.graphics.print(version,10,height-25)
  love.graphics.setColor(255,100,75)
  love.graphics.print("trevor",width-170,height-25)
  love.graphics.setColor(white)
  love.graphics.setFont(font.options)
  local m = false
  for i,v in ipairs(self.options) do
    if mouseY >= i*100+250 and mouseY <= i*100+250+60 then
      love.graphics.setColor(255,255,255,50)
      love.graphics.rectangle("fill", 0,i*100+250,width,60)
      love.graphics.setColor(white)
      m = true
    end
    if m then
      love.mouse.setCursor(cursor.hand)
    else
      love.mouse.setCursor(cursor.reg)
    end
    love.graphics.setColor(self.options_colors[i])
    love.graphics.printf(v,0,i*100+250,width,"center")
  end
  love.graphics.setColor(white)
end

function title.mouse()
  for i,v in ipairs(self.options) do
    if mouseY >= i*100+250 and mouseY <= i*100+250+60 then
      if i == 1 then
        load = true
        aftload = function()cur(arcade);love.mouse.setVisible(false)end
      elseif i == 2 then
        load = true
        aftload = function()cur(menu.credits)end
      elseif i == 3 then
        load = true
        aftload = love.event.quit
      end
      love.mouse.setCursor(cursor.reg)
    end
  end
end

title.music = sound.menu
