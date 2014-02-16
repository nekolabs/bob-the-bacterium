-- Credits.lua A short credits list (extended and reversed order at end of game)

Credits   = Gamestate.new()
local lg = love.graphics 
local wiWidth, wiHeight  = lg.getWidth(), lg.getHeight(); 

function Credits:init()
	self.creditsBg = love.graphics.newImage("assets/bg.jpg")
	
	frameImg    = love.graphics.newImage("assets/credits.png")
	frameHeight = frameImg:getHeight()
	
	self.creditsMusic = love.audio.newSource("sfx/E_BRR.ogg") 
	-- don't do that into the update callback otherwise it'll crash
	self.creditsMusic:play()
	self.creditsMusic:setLooping(true)
	
	-- We add some values to the CreditFrame img because we want it
	-- to move down the screen
	creditFrame = {}
	creditFrame.x  = 225
	creditFrame.y  = (wiHeight-wiHeight) - frameHeight
	creditFrame.vy = 35.25
	creditFrame.vx = 0
end
function Credits:update(dt)
	-- make the credits frame move with vy (just down)
	-- + vy*dt because the Koord System begins upper left
	creditFrame.y = creditFrame.y + (creditFrame.vy*dt)
	
	-- the frame shall pass and then come from the top again
	if creditFrame.x and creditFrame.y >= wiHeight then 
		creditFrame.x = 225
		creditFrame.y = (wiHeight-wiHeight) - frameHeight
	end
end
function Credits:draw()
	love.graphics.draw(Credits.creditsBg, 0, 0)
	love.graphics.draw(frameImg, creditFrame.x, creditFrame.y)
	
    love.graphics.print("Press 'Enter' to go Back", 665, 580, 0, .75, .75)
end
function Credits:keyreleased(k)
	if k == "return" then 
		Gamestate.switch(menu); menu.backgroundMusic:play();
		
		-- stops music if you want to go back to the menu
		Credits.creditsMusic:stop()
		
		-- set position of creditFrame back (otherwise if you were in the credits
		-- left to the menu and entered the credits again the position would be the old one 
		creditFrame.x = 225
		creditFrame.y = (wiHeight-wiHeight) - frameHeight
	end
end
