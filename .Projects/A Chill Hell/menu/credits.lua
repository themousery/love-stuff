module("credits", package.seeall)

text = {
  {123,67,151},"C",
  {139,62,134},"R",
  {155,57,117},"E",
  {172,52,100},"D",
  {188,46,82},"I",
  {204,41,65},"T",
  {220,36,48},"S"}
jobs = {
  "Programming/art : themousery",
  "Music : Kevin MacLeod",
  "Halogen font : Jeremy Vessey",
  "language : Lua",
  "framework : LOVE2D",
  "Special thanks to Idle Thumbs, and everyone who helped me out"}
page = 1

function update()end

function draw()
  love.graphics.setFont(font.title)
  love.graphics.setColor(white)
  love.graphics.printf(text,0,50,width,"center")
  love.mouse.setCursor(cursor.reg)
  m = false
  for i,v in ipairs(jobs) do
    if i <= page*3 and i > (page-1)*3 then
      if mouseY > (i-(page-1)*3)*100+100 and mouseY < (i-(page-1)*3)*100+150 then
        love.graphics.setColor(0,0,255)
        m = i
      else
        love.graphics.setColor(white)
      end
      love.graphics.setFont(font.options)
      love.graphics.printf(v:upper(), 0,(i-(page-1)*3)*100+100,width,"center")
      if i < #jobs-2 then
        if mouseY > height-50 and mouseX > width/2 then
          love.graphics.setColor(0,0,255)
          m = -1
        else
          love.graphics.setColor(white)
        end
        love.graphics.printf("NEXT PAGE", 0,height-50,width,"right")
      end
      if i > 3 then
        if mouseY > height-50 and mouseX < width/2 then
          love.graphics.setColor(0,0,255)
          m = -2
        else
          love.graphics.setColor(white)
        end
        love.graphics.printf("PREVIOUS PAGE", 0,height-50,width,"left")
      end
    end
  end
  if mouseY < 50 and mouseX < width/2 then
    love.graphics.setColor(0,0,255)
    m = 0
  else
    love.graphics.setColor(white)
  end
  love.graphics.printf("BACK", 0,0,width,"left")
  if m then
    love.mouse.setCursor(cursor.hand)
  else
    love.mouse.setCursor(cursor.reg)
  end
end

function mouse()
  if m==-2 then
    page = page-1
  elseif m==-1 then
    page = page+1
  elseif m==0 then
    _G.load = true
    _G.aftload = function()_G.cur=menu.title;page=1;end
  elseif m==1 then
    os.execute("start https://themousery.github.io/")
  elseif m==2 then
    os.execute("start http://incompetech.com/")
  elseif m==3 then
    os.execute("start http://jeremyvessey.com/")
  elseif m==4 then
    os.execute("start https://www.lua.org/")
  elseif m==5 then
    os.execute("start https://love2d.org/")
  elseif m==6 then
    os.execute("start https://www.idlethumbs.net/")
  end
end
