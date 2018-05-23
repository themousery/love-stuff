font = {}
font["title"] = love.graphics.newFont("files/Dual.otf", 80)
font["menu_options"] = love.graphics.newFont("files/Dual.otf", 30)
font["name"] = love.graphics.newFont("files/Dual.otf", 50)
font["reasons"] = love.graphics.newFont("files/Dual.otf", 30)
font["small"] = love.graphics.newFont("files/Dual.otf", 20)
function font:set(string)
  love.graphics.setFont(self[string])
end

music = {}
music.sources = {}
music.sources["title"] = love.audio.newSource("files/music/Ossuary-1.mp3")
music.sources["game"] = love.audio.newSource("files/music/Not As It Seems.mp3")
function music:set(string)
  for i,v in pairs(self.sources) do
    v:stop()
  end
  self.sources[string]:play()
  self.sources[string]:setLooping(true)
end

images = {}
images["forest_back"] = love.graphics.newImage("files/images/forest/back.png")
images["forest_light"] = love.graphics.newImage("files/images/forest/light.png")
images["forest_middle"] = love.graphics.newImage("files/images/forest/middle.png")
images["forest_front"] = love.graphics.newImage("files/images/forest/front.png")

mouse = {}
mouse["arrow"] = love.mouse.getSystemCursor("arrow")
mouse["hand"] = love.mouse.getSystemCursor("hand")
mouse["ibeam"] = love.mouse.getSystemCursor("ibeam")
function mouse:set(string)
  love.mouse.setCursor(self[string])
end
