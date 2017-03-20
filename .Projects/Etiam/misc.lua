function colliderect(x,y,w,h,x2,y2,w2,h2)
  return x + w >= x2 and x <= x2 + w2 and y + h >= y2 and y <= y2 + h2
end

function mouseover(x,y,w,h)
  return mouseX >= x and mouseX <= x + w and mouseY >= y and mouseY <= y + h
end

function randColor()
  return {random(255),random(255),random(255)}
end

function table.getKeys(tbl)
  local out = {}
  local n = 0
  for k,v in pairs(tbl) do
    print(k)
    n=n+1
    out[n] = k
  end
  return out
end
