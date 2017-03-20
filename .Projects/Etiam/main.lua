-- SETUP
black = {0,0,0,255}
white = {255,255,255,255}
width, height = love.graphics.getDimensions()
random = love.math.random
mode = "mainMenu"

require "menu" -- GRAB DEPENDENCIES
require "misc"
require "arcade"
function love.load() --LOAD FILES
  title_font = love.graphics.newFont("fonts/Elianto.otf", 200)
  little_font = love.graphics.newFont("fonts/Stellar-regular.otf",20)
  options_font = love.graphics.newFont("fonts/Borg.ttf", 50)
  credits_name_font = love.graphics.newFont("fonts/Stellar-regular.otf",50)
  credits_job_font = love.graphics.newFont("fonts/Stellar-light.otf",50)

  ship_img = love.graphics.newImage("images/ship.png")
  heart_img = love.graphics.newImage("images/heart.png")
  ufo_img = love.graphics.newImage("images/ufo.png")

  explode_sound = love.audio.newSource("sounds/explosion.wav")
  hit_sound = love.audio.newSource("sounds/hit.wav")
  laser_sound = love.audio.newSource("sounds/laser.wav")
  powerup_sound = love.audio.newSource("sounds/powerup.wav")
  menu_background = love.audio.newSource("sounds/Phantom from Space.mp3")
  game_background = love.audio.newSource("sounds/Latin Industries.mp3")
  mmm_sound = love.audio.newSource("sounds/mmm.mp3")
  death_sound = love.audio.newSource("sounds/death.wav")
  menu_background:play()
  menu_background:setLooping(true)
  game_background:setVolume(0.5)
  laser_sound:setVolume(0.2)
  asteroid_imgs = {}
  for i = 1,4 do
    table.insert(asteroid_imgs,love.graphics.newImage("images/asteroid"..i..".png"))
  end
  frameCount = 0
end

function love.update(dt)
  badger = dt
  frameCount = frameCount + 1
  mouseX,mouseY = love.mouse.getPosition()
  if mode == "arcadeGame" then
    updateArcadeGame()
  end
end

function love.draw()
  if mode == "mainMenu" then
    drawMainMenu()
  elseif mode == "creditsMenu" then
    drawCreditsMenu()
  elseif mode == "campaignMenu" then
    drawCampaignMenu()
  elseif mode == "arcadeGame" then
    drawArcadeGame()
  end
end

function love.keypressed(key)
  if key == "escape" then
    if mode == "creditsMenu" or mode == "campaignMenu" then
      mode = "mainMenu"
    elseif mode == "mainMenu" then
      love.event.quit()
    elseif mode == "arcadeGame" and not dead then
      if pause then
        game_background:setVolume(0.5)
      else
        game_background:setVolume(0.03)
      end
      pause = not pause
      love.mouse.setPosition(player.x+22,player.y+35)
      love.mouse.setVisible(pause)
    end
  end
  if key == "a" then
    love.event.quit()
  end
end

function love.mousepressed()
  if mode == "arcadeGame" and not pause and not dead then
    table.insert(lasers,Laser:new(mouseX-2,mouseY,1))
    laser_sound:rewind()
    laser_sound:play()
  end
end

function love.mousereleased()
  if mode == "arcadeGame" then
    if pause then
      local w,h = 400,#pause_options*200
      for i,v in ipairs(pause_options) do
        if mouseY >= (i-1)*200+(height-h)/2+75 and mouseY <= (i-1)*200+(height-h)/2+75+60 and mouseX >= (width-w)/2 and mouseX <= (width-w)/2+400 then
          if i == 1 then
            pause = false
            love.mouse.setPosition(player.x+22,player.y+35)
            love.mouse.setVisible(false)
            game_background:setVolume(0.5)
          elseif i == 2 then
            resetArcadeGame()
            mode = "mainMenu"
            game_background:stop()
            menu_background:play()
            menu_background:setLooping(true)
          end
          return
        end
      end
    end
    if dead then
      local w,h = 400,400
      for i,v in ipairs(dead_options) do
        if mouseY >= (i-1)*200+(height-h)/2+175 and mouseY <= (i-1)*200+(height-h)/2+175+60 and mouseX >= (width-w)/2 and mouseX <= (width-w)/2+400 then
          if i == 1 then
            love.mouse.setVisible(false)
            game_background:play()
            dead = false
          elseif i == 2 then
            mode = "mainMenu"
            menu_background:play()
            menu_background:setLooping(true)
          end
          resetArcadeGame()
          mmm_sound:stop()
        end
      end
      return
    end
  end
  if mode == "mainMenu" then
    for i,v in ipairs(options) do
      if mouseY >= i*100+200 and mouseY <= i*100+200+60 then
        if i == 1 then
          mode = "campaignMenu"
        elseif i == 2 then
          mode = "arcadeGame"
          love.mouse.setVisible(false)
          menu_background:stop()
          game_background:play()
          game_background:setLooping(true)
        elseif i == 3 then
          mode = "creditsMenu"
        elseif i == 4 then
          love.event.quit()
        end
      end
    end
    return
  end
end
