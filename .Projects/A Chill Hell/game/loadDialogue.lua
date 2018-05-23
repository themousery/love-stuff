deaths = {
  "you died of a broken heart",
  "you died from eating too much Taco Bell",
  "you died of old age. You're super old, bro",
  "you just kind of flopped over and died",
  "raptors",
}
function randomDeath()
  love.math.setRandomSeed(os.time())
  return deaths[love.math.random(#deaths)]
end

function loadDialogue()
  msgs = {
    {blue, save[currentSave][1]..": ", white,"WHAT? WHERE AM I?"}, --1
    {green,"DEVIL: ", white,"HEY BRO, I'M LIKE THE DEVIL OR SOMETHING. YOU'RE DEAD AND IN HELL."}, --2
    {blue,save[currentSave][1]..": ", white,"WHAT? HOW DID I DIE?"}, --3
    {green,"DEVIL: ", red,randomDeath():upper()..".", white," ANYWAY, WE GOTTA GET YOU A JOB, MAN."}, --4
    {green,"DEVIL: ", white,"ALRIGHT, YOU GOTTA CLICK THIS THING HERE. WE'LL PAY YOU WITH SOME HELL MONIES. SEE YA, DAWG."} --5
  }
end
