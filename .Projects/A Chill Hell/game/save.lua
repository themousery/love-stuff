function saveGame()
  love.filesystem.write("save"..currentSave, "")
  for i,v in ipairs(save[currentSave]) do
    love.filesystem.append("save"..currentSave, v)
    love.filesystem.append("save"..currentSave, "\r\n")
  end
  saved = true
  savecount = 0
end
