-- thankYou.lua
-- Thank You For Playing The Beta! :P
-- Take a look at https://github.com//jamlabs for new Code and Content

thankYou = Gamestate.new();
local creditFrame     = {}
local frameImg        = love.graphics.newImage("assets/EndCredits.png");
local frameHeight 	  = frameImg:getHeight();
local wiHeight    	  = love.graphics.getHeight();
local thankYouMusic   = love.audio.newSource("sfx/Resistance.ogg"); 
function thankYou:init()
	self.background = love.graphics.newImage("assets/EndBG.png");
	
	bounceSound:setVolume(0)
	gunshot:setVolume(0)
	
	thankYouMusic:play()
	thankYouMusic:setLooping(false)
	
	creditFrame.x  = 225
	creditFrame.y  = wiHeight + 67.5
	creditFrame.vy = 35.25
	creditFrame.vx = 0
	creditFrame.img = frameImg -- for removing
end
function thankYou:update(dt)
	creditFrame.y = creditFrame.y - (creditFrame.vy*dt)
	
	-- delete img after fading out
	if creditFrame.x and creditFrame.y >= (wiHeight-wiHeight) - frameHeight then 
		table.remove(creditFrame, img);
	elseif creditFrame.x and creditFrame.y <= wiHeight - frameHeight then 
		Gamestate.switch(Fin);
	end
end
function thankYou:draw()
	love.graphics.draw(thankYou.background, 0, 0)
	love.graphics.draw(frameImg, creditFrame.x, creditFrame.y)
end