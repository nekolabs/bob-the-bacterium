-- Fin.lua

Fin = Gamestate.new()
local finBg = love.graphics.newImage("assets/FIN.png")

function Fin:draw()
	love.graphics.draw(finBg, 0, 0)
end
function Fin:keypressed(k)
	if k == 'q' then love.event.push('quit') end
end
