-- This folder contains all of our images and sound files.
love.graphics.setDefaultFilter("nearest","nearest")

--Music
local names = {
  "battle",
  "boss",
  "menu",
  "transition"
}
matt.music.new(names)

--SFX
local names = {
  "big_explosion",
  "big_explosion2",
  "explosion",
  "hit",
  "laser",
  "powerup",
  "talk"
}
matt.sfx.new(names)

--load single images
local names = {
  "boss_health",
  "demo",
  "font",
  "greenMenu",
  "particle",
  "slider",
  "title",
  "ufo",
  "diamond"
}
matt.graphics.massImage(names)

-- load multiple frame images
local names = {
  "bug",5,
  "cursor_src",3,
  "junk",2,
  "ship",3,
  "man",4
}
matt.graphics.massImages(names)

matt.graphics.newFont("font"," abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789_,!?-+/():;&''+#=[]\".")

cursor = {}
cursor.reg = love.mouse.getSystemCursor("arrow")
cursor.hand = love.mouse.getSystemCursor("hand")

save = {}
controls = {}
if love.filesystem.exists(".sav") then
  for line in love.filesystem.lines(".sav") do
    table.insert(save, line)
  end
  for i,v in ipairs({"up", "left", "down", "right", "fire", "select"}) do
    controls[v] = save[i+2]
  end
else
  save={50,50,"up","left","down","right","z","x"}
  controls.up = "up"
  controls.down = "down"
  controls.right = "right"
  controls.left = "left"
  controls.fire = "z"
end

matt.music.setVolume(save[1])
matt.sfx.setVolume(save[2])