
-- initialize modules, makes things easier
img = {}
font = {}
sound = {}
cursor = {}

-- load image files
local imgdir = "resources/images/"
local newImage = love.graphics.newImage
img.heart = newImage(imgdir.."heart.png")
img.ufo = newImage(imgdir.."UFO.png")
img.galaxy = {newImage(imgdir.."spiral_galaxy.png"),newImage(imgdir.."ellipse_galaxy.png")}
img.ship = {}
for i=0,2 do
  table.insert(img.ship, newImage(imgdir.."ship/ship_"..i..".png"))
end
img.asteroid = {}
for i=1,3 do
  table.insert(img.asteroid, newImage(imgdir.."asteroids/Asteroid"..i..".png"))
end
-- img.explosion = {}
-- for i=0,8 do
--   table.insert(img.explosion, newImage(imgdir.."explosions/explode"..i..".png"))
-- end
-- load font files
local fontdir = "resources/fonts/"
local newFont = love.graphics.newFont
font.options = newFont(fontdir.."Borg.ttf", 50)
font.title = newFont(fontdir.."Elianto.otf", 200)
font.credjob = newFont(fontdir.."Stellar-light.otf", 50)
font.credname = newFont(fontdir.."Stellar-regular.otf", 50)
font.little = newFont(fontdir.."Stellar-light.otf", 20)

-- load sound files
local sounddir = "resources/sounds/"
local newSource = love.audio.newSource
sound.explode = newSource(sounddir.."explosion.wav")
sound.hit = newSource(sounddir.."hit.wav")
sound.laser = newSource(sounddir.."laser.wav")
sound.arcade = newSource(sounddir.."Latin Industries.mp3")
sound.m = newSource(sounddir.."mmm.mp3")
sound.menu = newSource(sounddir.."Phantom from Space.mp3")
sound.powerup = newSource(sounddir.."powerup.wav")
--adjust some volumes
sound.menu:setVolume(1.5)
sound.arcade:setVolume(0.5)
sound.laser:setVolume(0.2)

-- grab mouse cursors from system
cursor.reg = love.mouse.getSystemCursor("arrow")
cursor.hand = love.mouse.getSystemCursor("hand")
