function resetGame()
  score = 0
  aliensKilled=0
  fireStarted=0
  obstacles = {}
  glasers = {}
  blasers = {}
  aliens = {}
  alasers = {}
  powerups = {}
  explosions = {}
  bosses = {}
  bleed = false
  goback = false
  slomo = false
  powerupStarted = 0
  nolimitStarted=0
  bleedalpha = 0
  player.hp = 10
  player.x=width/2
  player.y=height/2
  player.cooldown=100
  alienpath = Path:new({Vector:new(100,75),Vector:new(width-100,75)},25)
end
keyboardInput = true
resetGame()
reset = {}
reset.update = resetGame
function reset.draw()
  transition(arcade,255)
end