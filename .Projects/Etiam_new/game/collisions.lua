--This file controls all of the collisions that take place

function colliderect(x,y,w,h,x2,y2,w2,h2)
  --detects a collision between two rectangles
  return x + w >= x2 and x <= x2 + w2 and y + h >= y2 and y <= y2 + h2
end

function collide(thing1, thing2, hurt1, hurt2)
  --A complicated function to easily collide two types of objects
  --Basically the "thing"s are tables of objects and the "hit"s are whether or not to damage
  --This function is a mess. For your own sake, don't try to understand it.
  didAHit=false
  for i,v in ipairs(thing1) do
    for j,a in ipairs(thing2) do
      hit = colliderect(v.x or v.pos.x, v.y or v.pos.y, v.width, v.height, a.x or a.pos.x, a.y or a.pos.y, a.width, a.height)
      if v.offset then hit = colliderect(v.x-v.width/2, v.y-v.height/2, v.width, v.height, a.x, a.y, a.width, a.height) end
      if hit then
        if hurt1 then 
          if v.hurt then v:hurt() 
          elseif v.hp then v.hp=v.hp-1 
          else table.remove(thing1, i) end
        end
        if hurt2 then
          if a.hurt then a:hurt()
          elseif a.hp then a.hp=a.hp-1
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
  --actaully do all the collisions for the game
  if collide(obstacles, glasers, true, true) then score=score+1 end
  -- if collide(powerups, {player}, true) then hits[1]:activate() end
  collide(aliens, glasers, true, true)
  collide({player}, aliens, true)
  collide({player}, blasers, true, true)
  -- collide({player}, bosses, true)
  collide(obstacles, {player}, true, true)
end