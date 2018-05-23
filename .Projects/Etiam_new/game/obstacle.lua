-- Obstacles that fall from the top

Obstacle = {}
function Obstacle:new(image)
  local i = matt.math.choice(image)
  o = {
    offset = true,
    img = i,
    width = i:getWidth(),
    height = i:getHeight(),
    x = random(width),
    y = -height,
    speed = random(7,10),
    hp = 1,
    rotate = random(0,3)
  }
  setmetatable(o,self)
  self.__index = self
  table.insert(obstacles,o)
end

function Obstacle:update(i)
  --blow up when necesary 
  if self.hp <= 0 then
    -- Particle:new("fire",self.x+self.width/2, self.y+self.height/2)
    table.remove(obstacles,i)
  end
  
  --move
  self.y = self.y + self.speed
  
  --delete if off screen
  if self.y >= height+self.width/2 then
    table.remove(obstacles,i)
  end
end


function Obstacle:draw()
  love.graphics.draw(self.img,self.x,self.y,(math.pi/2)*self.rotate, 1, 1, self.width/2, self.height/2)
end
