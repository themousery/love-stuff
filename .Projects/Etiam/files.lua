love.graphics.setDefaultFilter("nearest","nearest")
-- initialize modules, makes things easier
img = {}
music = {}
sound = {}
cursor = {}

-- load image files
local imgdir = "resources/images/"
function newImage(f)
  return love.graphics.newImage(imgdir..f..".png")
end
function newImages(f, n)
  local l = {}
  for i=1,n do
    table.insert(l, newImage(f..i))
  end
  return l
end
function newCharacter(f,n)
  f = "characters/"..f.."/"
  local l = {}
  for i=1,2 do
    table.insert(l, newImage(f..i))
  end
  l.blink = newImage(f.."blink")
  if n then 
    l.extra = newImages(f.."extra",n)
  end
  return l 
end
img.heart = newImage("powerups/heart")
img.laser = newImage("powerups/laser")
img.laserup = newImage("powerups/laserpu")
img.triple_ship = newImages("powerups/tripleship/",3)
img.tripleup = newImage("powerups/tripleup")
img.nolimits= newImage("powerups/nolimits")
img.big_battery = newImage("powerups/big_battery")
img.ufo = newImage("UFO")
img.title_screen = newImage("title")
img.ship = newImages("ship/", 3)
img.bug = newImages("bug/", 5)
img.alminus = newImage("alminus/alminus")
img.alminus_dots = newImages("alminus/dots",2)
img.alminus_lights = newImages("alminus/light",3)
img.alminus_laser = newImages("alminus/laser/",6)
img.boss_health = newImage("boss_health")
img.dialogue1 = newCharacter("terraman",3)
img.main = newCharacter("main")
img.static = newImages("static",3)
img.particle = newImage("particle")
img.menu = newImage("menu")
img.slider = newImage("slider")
img.system = newImage("solar_system/system")
img.cursor_src = newImages("cursor/",3)
img.demo = newImage("demo")
img.junk = newImages("junk", 2)
for i,v in ipairs({"Leviathon","Roknapa","Laurant","Chedopy"}) do
  img[v] = newImage("solar_system/"..v)
end

-- load font
font = love.graphics.newImageFont("resources/images/font.png"," abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789_,!?-+/():;&''+#=[]\".",2)
fontSize=1
love.graphics.setFont(font)

-- load sound files
local sounddir = "resources/sounds/"
local newSource = love.audio.newSource
function newSound(f)
  return love.audio.newSource(sounddir..f..".wav")
end
sound.hit = newSound("hit")
sound.powerup = newSound("powerup")
sound.explosion = newSound("explode")
sound.laser = newSound("laser")
sound.laser:setVolume(0.5)
sound.talk = newSound("talk")
sound.rumble = newSound("big_explosion")
sound.big_explosion = newSound("big_explosion2")

-- load music and make useful functions
function newMusic(f)
  return love.audio.newSource(sounddir..f..".mp3")
end
music["menu"] = newMusic("menu")
music["boss"] = newMusic("boss")
-- music["tutorial"] = newMusic("Overworld")
music["arcade"] = newMusic("battle")
-- music["story"] = newMusic("Shadowlands 4 - Breath")
function stopMusic()
  for k,v in pairs(music) do
    v:stop()
  end
end
function playMusic(s)
  stopMusic()
  music[s]:play()
  music[s]:setLooping(true)
end

-- grab mouse cursors from system
cursor.reg = love.mouse.getSystemCursor("arrow")
cursor.hand = love.mouse.getSystemCursor("hand")

shader = love.graphics.newShader("resources/trippy.glsl")

-- load the save file
function newSave()
  save={"0","100","100","up","left","down","right","z","x"}
  controls.fire = "z"
  controls.up = "up"
  controls.down = "down"
  controls.right = "right"
  controls.left = "left"
  controls.select = "x"
end

save = {}
controls = {}
if love.filesystem.exists(".sav") then
  for line in love.filesystem.lines(".sav") do
    table.insert(save,line)
  end
  if #save < 9 then
    newSave()
    saveGame()
  end
  controls.up = save[4]
  controls.left = save[5]
  controls.down = save[6]
  controls.right = save[7]
  controls.fire = save[8]
  controls.select = save[9]
else
  newSave()
end

for k,v in pairs(music) do
  v:setVolume(save[2]/100)
end
for k,v in pairs(sound) do
  v:setVolume(save[3]/100)
end
