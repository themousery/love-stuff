player = {x=0,y=0,hp=3,img=img.ship}
function player:update()
  self.width, self.height = self.img[1]:getDimensions()
  if not slomo then
    self.x,self.y = mouseX-self.width/2,mouseY-self.height/2
  end
  if self.hp <= 0 and not slomo then
    slomo = true
    died = frameCount
    love.mouse.setVisible(true)
    newExplosion(self.x+22,self.y+35)
    sound.arcade:stop()
    sound.explode:play()
  end
  
end
function player:draw()
  love.graphics.draw(img.ship[math.floor((frameCount%30)/10)+1],self.x,self.y)
end
