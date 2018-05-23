-- This folder contains all of the components that make up the gameplay.
module("game", package.seeall)
-- matt.system.makeModule("game")
local modules = {
  "main",
  "laser",
  "obstacle",
  "player",
  "collisions",
  "levels",
  "enemy"
}
for i,v in ipairs(modules) do require("game/"..v) end