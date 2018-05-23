-- This folder contains all of the files necesary for the actual gameplay
module("arcade", package.seeall)

-- love.filesystem.setRequirePath("arcade/?.lua;arcade/?/init.lua")
require "arcade/main"
require "arcade/levels"
require "arcade/player"
require "arcade/misc"
require "arcade/enemy"
require "arcade/obstacle"
require "arcade/laser"
require "arcade/powerup"
require "arcade/dialogue"
require "arcade/collisions"
require "arcade/boss"
require "arcade/explosion"
-- love.filesystem.setRequirePath("?.lua;?/init.lua")