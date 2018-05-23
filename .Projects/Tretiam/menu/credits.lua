credits = {}

credits.credits = {
  "trevor","trevor",
  "trevor","trevor",
  "trevor","trevor",
  "trevor","trevor"}
credits.title = {
  {255,100,75},"T",
  {229,96,105},"R",
  {203,92,135},"E",
  {178,88,165},"V",
  {152,83,195},"O",
  {126,79,225},"R",
  {100,75,255},""}

function credits.draw()
  self = menu.credits
  if love.mouse.getCursor() == cursor.hand then
    love.mouse.setCursor(cursor.reg)
  end
  love.graphics.setFont(font.little)
  love.graphics.setColor(100,75,255)
  love.graphics.print(version,10,height-25)
  love.graphics.setColor(255,100,75)
  love.graphics.print("trevor",width-170,height-25)
  love.graphics.setColor(white)
  love.graphics.setFont(font.title)
  love.graphics.printf(self.title, 0, 50, width, "center")
  for i,v in ipairs(self.credits) do
    if i % 2 == 1 then
      love.graphics.setFont(font.credname)
      love.graphics.setColor(255,100,75)
      if i <= 4 then
        love.graphics.printf(v,0,i*100+225,width/2,"center")
      else
        love.graphics.printf(v,width/2,(i-4)*100+225,width/2,"center")
      end
    else
      love.graphics.setFont(font.credjob)
      love.graphics.setColor(100,75,255)
      if i <= 4 then
        love.graphics.printf(v,0,(i-1)*100+275,width/2,"center")
      else
        love.graphics.printf(v,width/2,(i-5)*100+275,width/2,"center")
      end
    end
  end
  love.graphics.setColor(white)
end

function credits.esc()
  load = true
  aftload = function()cur(menu.title)end
end

credits.music = sound.menu
