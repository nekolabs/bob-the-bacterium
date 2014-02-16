-- Fin.lua

local lg = love.graphics 
Fin = Gamestate.new()
local finBg, finBgPosX, finBgPosY = lg.newImage('assets/FIN.png'), 0, 0

function Fin:draw()
	lg.draw(finBg, finBgPosX, finBgPosY)
end
function Fin:keypressed(k)
	if k == 'q' then love.event.push('quit') end
end
