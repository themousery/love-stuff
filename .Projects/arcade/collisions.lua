function colliderect(x,y,w,h,x2,y2,w2,h2)
  return x + w >= x2 and x <= x2 + w2 and y + h >= y2 and y <= y2 + h2
end

function collide(thing1, thing2, hurt1, hurt2)
  didAHit=false
  for i,v in ipairs(thing1) do
    for j,a in ipairs(thing2) do
      hit = colliderect(v.x or v.pos.x, v.y or v.pos.y, v.width, v.height, a.x or a.pos.x, a.y or a.pos.y, a.width, a.height)
      if v.offset then hit = colliderect(v.x-v.width/2, v.y-v.height/2, v.width, v.height, a.x, a.y, a.width, a.height) end
      if hit then
        if hurt1 then 
          if v.hurt~=nil then v:hurt() 
          elseif v.hp ~= nil then v.hp=v.hp-1 
          else table.remove(thing1, i) end
        end
        if hurt2 then
          if a.hurt~=nil then a:hurt()
          elseif a.hp ~= nil then a.hp=a.hp-1
          else table.remove(thing2, j) end
        end
        didAHit=true
        hits = {v,a}
      end
    end
  end
  return didAHit
end

function collisions() 
  if collide(glasers, obstacles, true, true) then
    score = score+1
  end
  if collide(powerups, {player}) then
    hits[1]:activate()
    sound.powerup:rewind()
    sound.powerup:play()
  end
  collide(aliens, glasers, true, true)
  if player.laser and love.keyboard.isDown(controls.fire) then
    collide(aliens, {laser_vec}, true)
    collide(obstacles, {laser_vec}, true)
    collide(blasers, {laser_vec}, true)
    collide(bosses, {laser_vec}, true)
  end
  if not slomo then
    collide(aliens, {player}, false, true)
    if Alminus.hp > 0 then collide(bosses, glasers, true, true) end
    collide(obstacles, {player}, true, true)
    collide(blasers, {player}, true, true)
    collide(bosses, {player}, false, true)
  end
end