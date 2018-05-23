module("newgame", package.seeall)

done = false

function update()

end

function draw()
  m = false
  for i=1,3 do
    if colliderectmouse((i-1)*250+50,100,200,400) then
      love.graphics.setColor(0,0,255)
      m = i
    else
      love.graphics.setColor(white)
    end
    love.graphics.rectangle("line",(i-1)*250+50,100,200,400)
    if save[i] then
      love.graphics.printf(save[i][1], (i-1)*250+50,100,200,"center")
      love.graphics.setFont(font.stuffs)
      love.graphics.printf("MONEY : "..save[i][2], (i-1)*250+50,250,200, "center")
      love.graphics.setFont(font.options)
    elseif tm ~= i then
      love.graphics.printf("NEW GAME", (i-1)*250+50,250,200,"center")
    end
  end
  if m then
    love.mouse.setCursor(cursor.hand)
  else
    love.mouse.setCursor(cursor.reg)
  end
  if typing then
    if name == "" then
      love.graphics.printf("(TYPE NAME)", (tm-1)*250+50,100,200,"center")
    else
      love.graphics.printf(name:upper(), (tm-1)*250+50,100,200,"center")
    end
    if done then
      typing = false
      done = false
      love.filesystem.write("save"..tm, name:upper().."\r\n")
      love.filesystem.append("save"..tm, 0)
      love.filesystem.append("save"..tm, "\r\n")
      love.filesystem.append("save"..tm, 0)
      love.filesystem.append("save"..tm, "\r\n")
      save[tm] = {}
      for line in love.filesystem.lines("save"..tm) do
        table.insert(save[tm], line)
      end
    end
  end
end

function mouse()
  if save[m] then
    _G.load = true
    _G.aftload = function()_G.cur=game;_G.currentSave=m;_G.cur.setup();end
  elseif m then
    typing = true
    name = ""
    tm = m
    -- love.filesystem.write("save"..m, "test")
  end
end

function textinput(t)
  if typing == true and string.len(name)<7 then
    name = name..t
  end
end

function keypressed(key)
  if key=="backspace" and typing then
    name = name:sub(1,-2)
  end
  if key=="return" and typing and string.len(name)>0 then
    done = true
  end
end
