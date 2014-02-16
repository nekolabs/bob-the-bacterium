-- ingameMenu it's rather meant to pause the game and exit rather than actually providing a full menu

local lg,le = love.graphics, love.event
local pauseText = {}

function ingameMenu_init()
  local font = lg.newFont("fonts/PixAntiqua.ttf", 25)
  lg.setFont(font)
  local ingameMenuOpen = false
  pauseText.show = [[ un(P)ause or (E)xit ]] 
end
function ingameMenu_focus(f)
  if not f then ingameMenuOpen = true 
  else ingameMenuOpen = false end
end
function ingameMenu_keypressed(key)
  if key == 'p' then 
    ingameMenuOpen = not ingameMenuOpen -- pausing
  elseif key == 'e' and ingameMenuOpen then -- exit when pausing
    le.push('quit')
  end
end

local r,g,b = 255, 255, 255
function ingameMenu_draw()
  lg.setColor(r,g,b)
  if ingameMenuOpen then lg.print(pauseText.show, player.x-25, player.y-25) end
end
