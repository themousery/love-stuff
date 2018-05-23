--[[This folder contains all of the menus in the game. Each menu is a gameState,
    and has a number of things to make it function as a menu:
    
    isMenu - always true
    green - true if it is a menu with the green/purple background image
    options - a table of strings, the options you can select
    title - only used if green is true, the text to appear at the top of the menu
    y - a two piece table, essentially each option will have a y of y[1]*i + y[2], i being the index of the option, not neccesary if 'green' is true
    x - not neccesary if 'green' is true, same as y 
    actions - a table. Each item will either be a function or a gameState, corresponding to the option with the same index.
  ]]
module("menu", package.seeall)
local modules = {
  "title",
  "pause",
  "options",
  "title_card"
}
matt.system.require("menu", modules)