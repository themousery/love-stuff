module("openingcredits", package.seeall)
words = {"Mousery Games","Programming:\nMatthew Francis","Art:\nTrevor Baughn"}
function setup()
  if not started then
    started = true
    startTime = frameCount
    word=1
  elseif word ~= #words and back == true then
    word=word+1
    again = false
  elseif word==#words then
    transition(menu.story)
  end
  stopMusic()
end
function update()end
function draw()
  love.graphics.setColor(black)
  love.graphics.rectangle("fill", 0,0,width,height)
  love.graphics.setFontSize(70)
  love.graphics.setColor(white)
  love.graphics.printf(words[word], 0,height/2-fontHeight()/2,width,"center")
  if word == #words and frameCount-startTime>=150*word then
    transition(menu.story,10)
    started=false
  end
  if frameCount-startTime>=150*word and word ~= #words then
    transition(menu.openingcredits,10)
  end
end

function keypressed() end