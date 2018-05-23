function loadFont(filename,size)
  return love.graphics.newFont("resources/fonts/"..filename,size)
end

img = {}
img.devil = love.graphics.newImage("resources/images/devil.png")

font={}
font.title = loadFont("halogen.otf", 100)
font.options = loadFont("halogen.otf",50)
font.stuffs = loadFont("halogen.otf",40)
font.save = loadFont("halogen.otf", 20)

cursor = {}
cursor.reg = love.mouse.getSystemCursor("arrow")
cursor.hand = love.mouse.getSystemCursor("hand")

music = {}
music.menu = love.audio.newSource("resources/music/Kool Kats.mp3")
music.game = love.audio.newSource("resources/music/Off to Osaka.mp3")

save = {}
for i=1,3 do
  if love.filesystem.exists("save"..i) then
    save[i] = {}
    for line in love.filesystem.lines("save"..i) do
      table.insert(save[i],line)
    end
  end
end
