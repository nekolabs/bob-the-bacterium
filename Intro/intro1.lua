-- intro1.lua
-- The Intro start of BTB

intro     = Gamestate.new();
local introLength, introCountSpeed, introCountOn = 4.1, .85, 0; -- Timers for the intro1 screen
function intro:init()
	self.bgIntro1 = love.graphics.newImage("assets/Jam.png"); --self just means the current object this is useful for reuse outside function
	self.intromusic = love.audio.newSource("sfx/canonInD8Bit.ogg");
  self.intromusic:setVolume(0.5)
	self.intromusic:play();
end
function intro:update(dt)	
	if introCountOn >= introLength then Gamestate.switch(poweredBy); self.bgIntro1 = nil; -- skip to menu after reaching end of Timer (introLength is timerMaxTime)
	elseif introCountOn < introLength then introCountOn = introCountOn + (introCountSpeed*dt); end --count up to end of timer
end
function intro:draw()
	love.graphics.draw(self.bgIntro1,0,0);
	love.graphics.setNewFont("fonts/PixAntiqua.ttf",16);
	love.graphics.print("Press Enter To Lose Yourself in Space", 272.5, 550);
end
function intro:keyreleased(key, unicode)
	if key == ("return") then Gamestate.switch(menu); self.intromusic:stop(); end  -- in the end gamestate switch to menu state 
end
