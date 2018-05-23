function setup()
  music:set("game")
  randomPeople()
  currentPerson = 1
  next = false
  prev = false
end

function randomPeople()
  people = {}
  for i=1,3 do
    person = {}
    person.name = firstNames[love.math.random(#firstNames)].." "..lastNames[love.math.random(#lastNames)]
    person.reasons = {}
    for j=1,3 do
      table.insert(person.reasons, reasons[love.math.random(#reasons)])
    end
    table.insert(people,person)
  end
end

function update()end

function draw()
  drawForest()
  love.graphics.setColor(236, 220, 176)
  love.graphics.rectangle("fill", 100, 100, 600, 400)
  love.graphics.setColor(193, 152, 117)
  love.graphics.setLineWidth(3)
  love.graphics.rectangle("line", 100, 100, 600, 400)
  font:set("name")
  love.graphics.printf(people[currentPerson].name,110,150,590,"left")
  font:set("reasons")
  for i=1,3 do
    love.graphics.printf("•"..people[currentPerson].reasons[i],110,i*75+150,590,"left")
  end
  if currentPerson ~=3 then
    font:set("small")
    if (mouseX>540 and mouseX<700 and mouseY>475 and mouseY<500) then
      love.graphics.setColor(70,70,70)
      mouse:set("hand")
      next = true
    else
      love.graphics.setColor(0,0,0)
      next = false
    end
    love.graphics.printf("next", 110, 475, 580, "right")
  end
  if currentPerson ~=1 then
    font:set("small")
    if (mouseX>110 and mouseX<200 and mouseY>475 and mouseY<500) then
      mouse:set("hand")
      prev = true
      love.graphics.setColor(70,70,70)
    else
      love.graphics.setColor(0,0,0)
      prev = false
    end
    love.graphics.printf("prev", 110, 475, 580, "left")
  end
end

function mousereleased()
  print(currentPerson)
  if next and currentPerson<3 then
    currentPerson= currentPerson+1
  else if prev and currentPerson>1 then
    currentPerson = currentPerson-1
  end
end
end --I don't know why there's two ends here, but it breaks without it. Don't touch.
