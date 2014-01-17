--speech.lua
--Trying to make all parts of Trent's speech in a fusion

speech = Gamestate.new();
local anim8 = require("libsAndSnippets/anim8"); --used for animating trent

function speech:init()
	background 	   = love.graphics.newImage("assets/bg.jpg");
	trentImg 	   = love.graphics.newImage("assets/robot.png"); 
--	anim 		   = newAnimation(trentImg, 178, 415, 0.15, 0);
	local g  	   = anim8.newGrid(178, 320, trentImg:getWidth(), trentImg:getHeight());
	animTest	   = anim8.newAnimation(g('1-4',1), 0.15)
	
	button = {}
	local font, fontNew = love.graphics.newFont("fonts/PixAntiqua.ttf", 30), font;
    hitButtonTimes = 0; --times hit button to change page[i]
	
	function button_spawn(x,y,text,id)
		table.insert(button, {x = x, y = y, text = text, id = id}); 
	end	
	button_spawn(700, 270, "->", "next");
end
function speech:update(dt)
	animTest:update(dt);
	collectgarbage(); --constant use of mem
end
function speech:draw()
	love.graphics.draw(background, 0, 0);
	animTest:draw(trentImg, 90, 0); 
 	
    -- All Graphics Stuff
    love.graphics.setNewFont("fonts/PixAntiqua.ttf", 21); 
    love.graphics.print("Trent The Quaint", 100, 315);
    love.graphics.setNewFont("fonts/PixAntiqua.ttf", 11.5);
    love.graphics.print("Press 'Enter' to skip", 680, 580);
    

    love.graphics.rectangle("line", 325, 82.5, 425, 195);
    love.graphics.setNewFont("fonts/PixAntiqua.ttf", 20);
    
	-- Trent's text
	local page0 = [[
	  Hey!
	  You over there!
	
	
	
	]]
	local page1 = [[
	  Hey!
	  Are you alright?
	  I heard your name was Bob...
	  Bob the Bacterium! 
	
	]]
	local page2 = [[
	  You were on a passenger ship to the
	  Mars. On The Curiosity to be exact! 
	  You and your lovely bacterioid girlfriend
	  Alice were passengers on that ship
	
	]]
	local page3 = [[
	  Unfortunately she got kidnapped by
	  Oscar The Bad Bacterium King and
	  his henchmen Mallory, Marvin and
	  Mallet when you were about 
	  to land on our great planet the Mars!
	]]
	local page4 = [[
	  But hey! Don't look so fuzzy!
	  You still have the chance to
	  get your lovely bacterioid girlfriend back.
	  You only need to fight.
	  I'll instruct you!
	]]
	if hitButtonTimes == 0 then love.graphics.print(page0, 340, 86); 
	elseif hitButtonTimes == 1 then love.graphics.print(page1, 340, 86); 
	elseif hitButtonTimes == 2 then love.graphics.print(page2, 340, 86); 
	elseif hitButtonTimes == 3 then love.graphics.print(page3, 340, 86); 
	elseif hitButtonTimes == 4 then love.graphics.print(page4, 340, 86); 
	elseif hitButtonTimes >= 5 then Gamestate.switch(Lvl1); hitButtonTimes = nil; end
	
	for i,v in ipairs(button) do
		love.graphics.print(v.text,v.x,v.y, 0, 1.5, 1.5);
	end 
end
function speech:mousepressed(x, y)
	speech:button_click(x,y);
end
-- you click on the button and if you're coursor's right between the borders you got it...
-- -> gamestate changes
function speech:button_click(x,y)
	for i, v in ipairs(button) do
			if x > v.x and
			x < v.x + fontNew:getWidth(v.text)+42.5 and
			y > v.y and
			y < v.y + fontNew:getHeight(v.text)+22.5 then
				if v.id == "next" then
					hitButtonTimes = hitButtonTimes + 1;
				end
			end
	end
end
function speech:keyreleased(k)
    if k == "return" then Gamestate.switch(Lvl1); ok = true;
	elseif k == "right" then Gamestate.switch(speech); hitButtonTimes = hitButtonTimes + 1; end
end