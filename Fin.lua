-- Fin.lua

Fin = Gamestate.new(); 
function Fin:init()
	self.background = love.graphics.newImage("assets/FIN.png");
end
function Fin:draw()
	love.graphics.draw(Fin.background, 0, 0);	
end
function Fin:keypressed(k)
	if k == 'q' then 
		love.event.push('quit');
	end
end