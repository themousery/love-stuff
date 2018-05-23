Obstacle = {}
function Obstacle:new(image)
  o = {}
  -- o.img = choice(image)
  local r = random(#image)
  o.offset = true
  o.img = image[r]
  o.width, o.height = o.img:getDimensions()
  o.x = random(width)
  o.y = -o.img:getHeight()
  o.speed = random(7,10)
  o.hp = 1
  o.rotate = random(0,3)
  setmetatable(o,self)
  self.__index = self
  table.insert(obstacles,o)
end
function Obstacle:update(i)
  if self.hp <= 0 then
    Particle:new("fire",self.x+self.width/2, self.y+self.height/2)
    table.remove(obstacles,i)
  end
  if slomo then
    self.y = self.y + self.speed/10
  else
    self.y = self.y + self.speed
  end
  if self.y >= width then
    table.remove(obstacles,i)
  end
end
function Obstacle:draw()
  love.graphics.draw(self.img,self.x,self.y,(math.pi/2)*self.rotate)
end
