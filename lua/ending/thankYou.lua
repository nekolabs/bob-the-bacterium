-- thankYou.lua Thank you so much for playing the Beta! 

thankYou = Gamestate.new()

local lg = love.graphics
local creditFrame     = {}
local frameImg = love.graphics.newImage("assets/EndCredits.png")
local frameHeight, wiHeight = frameImg:getHeight(), love.graphics.getHeight()
local thankYouMusic   = love.audio.newSource("sfx/Resistance.ogg"); 
local isVolume = 0

function thankYou:init()
	self.background = love.graphics.newImage("assets/EndBG.png");	
	
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

local tyBgPosX,tyBgPosY = 0,0
function thankYou:draw()
	lg.draw(thankYou.background, tyBgPosX, tyBgPosY)
	lg.draw(frameImg, creditFrame.x, creditFrame.y)
end
