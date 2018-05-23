module("title", package.seeall)
text={
  {123, 67, 151},"A ",
  {134,64,140},"C",
  {145,60,128},"H",
  {155,57,117},"I",
  {166,53,105},"L",
  {177,50,94},"L ",
  {188,46,82},"H",
  {198,43,71},"E",
  {209,39,59},"L",
  {220, 36, 48},"L"}
options = {"play","credits","quit"}
function update()end

function draw()
  love.graphics.setFont(font.title)
  love.graphics.setColor(white)
  love.graphics.printf(text, 0, 50, width, "center")
  m = false
  for i,v in ipairs(options) do
    if mouseY > i*100+150 and mouseY < i*100+200 then
      love.graphics.setColor(0,0,255)
      m = i
    else
      love.graphics.setColor(white)
    end
    love.graphics.setFont(font.options)
    love.graphics.printf(v:upper(), 0, i*100+150, width, "center")
  end
  if m then
    love.mouse.setCursor(cursor.hand)
  else
    love.mouse.setCursor(cursor.reg)
  end
end

function mouse()
  if m==1 then
    _G.load = true
    _G.aftload = function()_G.cur=menu.newgame;end
  elseif m==2 then
    _G.load = true
    _G.aftload = function()_G.cur=menu.credits;end
  elseif m==3 then
    _G.load = true
    _G.aftload = love.event.quit
  end
end
