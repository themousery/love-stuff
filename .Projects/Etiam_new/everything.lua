-- A universal hub that grabs all the files we need
require "libraries"
local modules = {
  "resources",
  "game",
  "menu",
  "stars"
}
matt.system.require("", modules)