-- intro2.lua
-- The Second Part of the Intro of BTB

poweredBy = Gamestate.new();
local ver = "Version 0.095 Beta"; 
local poweredByLength, poweredByCountSpeed, poweredByCountOn = 2.0, .42, 0;
function poweredBy:init()
	self.bgIntro2 	= love.graphics.newImage("assets/poweredBy.png");
end
function poweredBy:update(dt)
	if poweredByCountOn >= poweredByLength then intro.intromusic:stop(); Gamestate.switch(menu); self.bgIntro2 = nil; --save mem
	elseif poweredByCountOn < poweredByLength then poweredByCountOn = poweredByCountOn + (poweredByCountSpeed*dt); end
end
function poweredBy:draw()
	love.graphics.draw(self.bgIntro2,0,0);
	love.graphics.print(ver, 335, 220);
end
function poweredBy:keyreleased(key, unicode)
	if key == ("return") then Gamestate.switch(menu); intro.intromusic:stop(); intro,intromusic = nil; end
end