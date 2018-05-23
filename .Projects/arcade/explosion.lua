Particle = {}
Particle.system = love.graphics.newParticleSystem(img.particle, 5000)
function Particle:new(type,x,y)
  o = {}
  o.system = self.system:clone()
  if type=="fire" then
    o.system:setParticleLifetime(0.4,0.5)
    o.system:setSizeVariation(1)
    o.system:setColors(200,0,0,255, 255,165,0,100)
    o.system:setLinearAcceleration(-200,-200,200,200)
    o.system:setEmissionRate(1000)
  elseif type=="bigboi" then
    o.system:setParticleLifetime(3,4)
    o.system:setSizeVariation(1)
    o.system:setColors(255,0,0,255, 255,165,0,125)
    o.system:setLinearAcceleration(-200,-200,200,200)
    o.system:setEmissionRate(5000)
  end
  o.system:setPosition(x,y)
  o.system:update(badger)
  o.system:setEmissionRate(0)
  setmetatable(o,self)
  self.__index = self
  table.insert(explosions, o)
end

function Particle:update(dt)
  self.system:update(dt)
end

function Particle:draw()
  love.graphics.draw(self.system)
end