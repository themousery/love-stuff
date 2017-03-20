title_table = {
  {100,75,255},"E",
  {139,81,210},"T",
  {178,88,165},"I",
  {216,94,120},"A",
  {255,100,75},"M"}
options = {"campaign mode", "arcade mode", "credits", "exit"}
options_colors = {{100,75,255},{152,83,195},{203,92,135},{255,100,75}}
stars = love.graphics.newCanvas()
love.graphics.setCanvas(stars)
love.graphics.setColor(white)
for i=1,500 do
  love.graphics.points(random(width),random(height))
end
love.graphics.setCanvas()
function drawMainMenu()
  love.graphics.draw(stars,0,0)
  love.graphics.setFont(title_font)
  love.graphics.printf(title_table, 0, 50, width, "center")
  love.graphics.setFont(little_font)
  love.graphics.setColor(100,75,255)
  love.graphics.print("PROTOTYPE",10,height-25)
  love.graphics.setColor(255,100,75)
  love.graphics.print("by Mousery Games",width-170,height-25)
  love.graphics.setColor(white)
  love.graphics.setFont(options_font)
  for i,v in ipairs(options) do
    if mouseY >= i*100+200 and mouseY <= i*100+200+60 then
      love.graphics.setColor(150,150,150,100)
      love.graphics.rectangle("fill", 0,i*100+200,width,60)
      love.graphics.setColor(255,255,255,255)
    end
    love.graphics.setColor(options_colors[i])
    love.graphics.printf(v,0,i*100+200,width,"center")
  end
  love.graphics.setColor(white)
end

credits = {
  "Matthew Francis","programming",
  "Kevin MacLeod","music",
  "Tom Williams","art",
  "LÖVE2D and Lua","special thanks"}
credits_title = {
  {255,100,75},"C",
  {229,96,105},"R",
  {203,92,135},"E",
  {178,88,165},"D",
  {152,83,195},"I",
  {126,79,225},"T",
  {100,75,255},"S"}
function drawCreditsMenu()
  love.graphics.draw(stars,0,0)
  love.graphics.setFont(little_font)
  love.graphics.setColor(100,75,255)
  love.graphics.print("PROTOTYPE",10,height-25)
  love.graphics.setColor(255,100,75)
  love.graphics.print("by Mousery Games",width-170,height-25)
  love.graphics.setColor(white)
  love.graphics.setFont(title_font)
  love.graphics.printf(credits_title, 0, 50, width, "center")
  for i,v in ipairs(credits) do
    if i % 2 == 1 then
      love.graphics.setFont(credits_name_font)
      love.graphics.setColor(255,100,75)
      if i <= 4 then
        love.graphics.printf(v,0,i*100+225,width/2,"center")
      else
        love.graphics.printf(v,width/2,(i-4)*100+225,width/2,"center")
      end
    else
      love.graphics.setFont(credits_job_font)
      love.graphics.setColor(100,75,255)
      if i <= 4 then
        love.graphics.printf(v,0,(i-1)*100+275,width/2,"center")
      else
        love.graphics.printf(v,width/2,(i-5)*100+275,width/2,"center")
      end
    end
  end
  love.graphics.setColor(255,255,255)
end

soon_table = {
  {255,100,75},"COMING ",
  {100,75,255},"SOON"}
function drawCampaignMenu()
  love.graphics.draw(stars,0,0)
  love.graphics.setFont(little_font)
  love.graphics.setColor(100,75,255)
  love.graphics.print("PROTOTYPE",10,height-25)
  love.graphics.setColor(255,100,75)
  love.graphics.print("by Mousery Games",width-170,height-25)
  love.graphics.setFont(title_font)
  love.graphics.setColor(white)
  love.graphics.printf(soon_table,0,height/2-200,width,"center")
end
