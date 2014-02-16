-- gotIt.lua
-- Gamestate which appears after succesfully completing a Lv.

gotIt = Gamestate.new()
local BobLoser = love.graphics.newImage("assets/loser.png");
local wiWidth, wiHeight  = love.graphics.getWidth(), love.graphics.getHeight(); 
function gotIt:init()
	self.background = love.graphics.newImage("assets/bg.jpg")
	
	wonSound = love.audio.newSource("sfx/Endflag.ogg")
	invSound:stop()
	invisSound:stop()
	-- the ok boolean is able to switch between "reached end of level stuff" and "death stuff" 
	ok = true --gotIt is possible
	if toSettings == 0 then change = 0; else change = change end --var for level switch and dying (toSettings - checks if you start in tutLv or enter per Settings)
	function changePlCoordsGotIt(change) --change to Lv.+1 (for loop?)
			if change == 0 then Gamestate.switch(Lvl2); elseif change == 1 then Gamestate.switch(Lvl3); 
			elseif change == 2 then Gamestate.switch(Lvl4); elseif change == 3 then Gamestate.switch(Lvl5);
			elseif change == 4 then Gamestate.switch(Lvl6); elseif change == 5 then Gamestate.switch(Lvl7);
			elseif change == 6 then Gamestate.switch(Lvl8);
			end
	end
	function changePlCoordsGotcha(change)
			coords = { player.x, player.y }
			if change == 0 then Gamestate.switch(Lvl1); 
				player.x, player.y = 150, 928.5;
				return coords
			elseif change == 1 then Gamestate.switch(Lvl2); 
				player.x, player.y = 150, 928.5;
				return coords
			elseif change == 2 then Gamestate.switch(Lvl3);
				player.x, player.y = 150, 625;
				return coords
			elseif change == 3 then Gamestate.switch(Lvl4); 
				player.x, player.y = 150, 1550;
				return coords
			elseif change == 4 then Gamestate.switch(Lvl5);
				player.x, player.y = 150, 1550;
				return coords
			elseif change == 5 then Gamestate.switch(Lvl6); 
				player.x, player.y = 150, 1550
				return coords
			elseif change == 6 then Gamestate.switch(Lvl7); 
				player.x, player.y = 150, 928.5;
				return coords
			end
	end
end
function gotIt:update(dt)
end
function gotIt:draw()
	love.graphics.draw(self.background, 0, 0)
	if ok then 
		love.graphics.print("You Got It!", wiWidth/2 - 112.5, wiHeight/2 -215, 0, 2.25, 2.25)

		-- Go ahead 
		love.graphics.print("Press 'Enter'!", 695, 580, 0, .75, .75)
	
		-- Show the Results Bob received in the Lv
		love.graphics.print("Score: " .. score, wiWidth/2 - 250, wiHeight/2 - 125, 0, 1.25, 1.25)
	
		love.graphics.print("You still have", wiWidth/2 -250, wiHeight/2-95, 0, 1.25, 1.25)
		-- We want to see how many hearts we still have ;P
		if playerLifes == 3 then 
		-- all the 3 hearts are drawn
			love.graphics.draw(L1, wiWidth/2 - 77.5, wiHeight/2-95)
			love.graphics.draw(L2, wiWidth/2 - 38, wiHeight/2-95)
			love.graphics.draw(L3, wiWidth/2 + 1.5,  wiHeight/2-95)
	
			-- end the sentence begun above (at the proper position) for each case
			love.graphics.print("Lifes!", wiWidth/2 + 43.5, wiHeight/2-95)
			-- insert motivation here 
			love.graphics.print("Well done!", wiWidth/2 - 77.5, wiHeight/2 - 17.5, 0, 1.25, 1.25)
		elseif playerLifes == 2 then 
			love.graphics.draw(L1, wiWidth/2 - 77.5, wiHeight/2-95)
			love.graphics.draw(L2, wiWidth/2 - 38, wiHeight/2-95)
	
			-- here we have to adjust the position because only 2 lifes are left (just x-coord affected)
			love.graphics.print("Lifes!", wiWidth/2 + 1.5 , wiHeight/2-95)
		
			-- More Motivation!
			love.graphics.print("Still Nice!", wiWidth/2 - 77.5, wiHeight/2 - 17.5, 0, 1.25, 1.25)
		elseif playerLifes == 1 then 
			-- just the last one reminds on screen...
			love.graphics.draw(L1, wiWidth/2 - 77.5, wiHeight/2-95)
		
			love.graphics.print("Lifes!", wiWidth/2 - 25, wiHeight/2-95)
		
			love.graphics.print("Take Care!", wiWidth/2 - 77.5, wiHeight/2 - 17.5, 0, 1.25, 1.25)
		elseif invJStart >= invJMax  then 
				playerIsAlive = true
				playerLifes = playerLifesCheck; 
			
				invJStart = 0 
				collidedTimes = 0	
		elseif invisJStart >= invisJMax then 
				playerIsAlive = true
				playerLifes = playerLifesCheck1;
				invisJStart = 0 
				collidedTimes = 0	
		else 
			love.graphics.print("1 Bonus Life!", wiWidth/2 - 75, wiHeight/2-95, 0, 1.25, 1.25) 

			love.graphics.print("Only Just..", wiWidth/2-95, wiHeight/2-17.5, 0, 1.25, 1.25)
		end
	elseif not ok then 
		love.graphics.draw(self.background,0,0) 
		-- draw the mean enemy 
		love.graphics.draw(BobLoser, wiWidth/2 -55, wiHeight/2-85, 0, 1.5, 1.5)
		love.graphics.print("Gotcha!", wiWidth/2 -85, wiHeight/2 -215, 0, 2.25, 2.25)
		-- tips
		love.graphics.print("'Q' to Quit", wiWidth/2-85, wiHeight/2 + 50, 0, 0.99, 0.99)
		love.graphics.print("'Enter' To Try Again", wiWidth/2-85, wiHeight/2 + 100, 0, 0.99, 0.99)	
	end 
end
function gotIt:keypressed(k)
	if k == 'q' then
	  love.event.push('quit')
	end
end
function gotIt:keyreleased(k)
	-- change to Lv. above(+1)
	if ok then
		if k == ("return") then
			if (playerLifes < 3 and playerDied > 0) then 
				if ((change%2 == 0) or (change == 0)) then --Lifes +1 all 2 Lvls > Lvl1(Tut)
					playerLifes = playerLifes + 1;
					playerDied = playerDied - 1;
				end
			end
			changePlCoordsGotIt(change);
			change = change+1; --here otherwise we would need to write it n times or we would reach the wrong Lv.
		end
	elseif not ok then --die
		ok = false
		if k == ("return") then
			ok = true 
			playerIsAlive = true
			playerLifes = 1 
 			playerDied = 2 --you get one bonus life (Gotcha appears if playerDied equals 4)
			changePlCoordsGotcha(change)
		end
	end
end
