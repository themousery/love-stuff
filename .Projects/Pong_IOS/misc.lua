function colliderect(x,y,w,h,x2,y2,w2,h2)
  return x + w >= x2 and x <= x2 + w2 and y + h >= y2 and y <= y2 + h2
end
