-- drakMallet1.lua
-- One of the drakuls of the Mini Boss Mallet 

atl = require("libsAndSnippets/ATL")
require("libsAndSnippets/BoundingBox")
require("bullet") --del the player bullet

-- Img of the drakul
drakulMallet1Img 	= love.graphics.newImage("assets/Mallet/malletUHalf.png")
drakulMallet1Height = drakulMallet1Img:getHeight()
drakulMallet1Width  = drakulMallet1Img:getWidth()

drakulMallet1 = {} 

levitateTimer = 0;
levitateCount = .51;
levitateCountSpeed = .5;

function createDrakul1(x, y)
	table.insert(drakulMallet1, { x=x, y=y, width=drakulMallet1Width, height=drakulMallet1Height, vx = 0, vyPos = 300, vyNeg = -100 } ) --vyPos is the y velocity to knock on the ground, vyNeg to go the way back
end
function drakulMallet1_update(dt)
    -- The little Mallet doesn't react to the player, but shall move between borders through timers and with differen y velocities
    -- "smash down" and "go back" velocities	
	for dM1i,dM1v in ipairs(drakulMallet1) do
		-- little mallet standing still doing nothing
		if levitateTimer < levitateCount then
			levitateTimer = levitateTimer + (levitateCountSpeed*dt)
		elseif ((levitateTimer >= levitateCount) and not (levitateTimer >= levitateCount*2)) then
			dM1v.y = dM1v.y + dM1v.vyPos*dt -- use smash down velocity in here
			levitateTimer = levitateTimer + (levitateCountSpeed*dt)
		elseif ((levitateTimer >= levitateCount*2) and not (levitateTimer >= levitateCount*5)) then
			dM1v.y = dM1v.y + dM1v.vyNeg*dt -- go back
		    levitateTimer = levitateTimer + (levitateCountSpeed*dt)
		elseif (levitateTimer >= levitateCount*5) then -- balance going back with negYVel (find proper position)
			levitateTimer = 0
			dM1v.y = dM1v.y + (0*dt)
		end
	end
	for dM1i,dM1v in ipairs(drakulMallet1) do 
		for bi,bv in ipairs(bullet) do 
			if CheckCollision(dM1v.x,dM1v.y,dM1v.width,dM1v.height, bv.x,bv.y,bv.width,bv.height) then 
				table.remove(bullet, bi)
			end
		end
	end 
end
function drakulMallet1_draw()
	for dM1i,dM1v in ipairs(drakulMallet1) do  
		love.graphics.draw(drakulMallet1Img, dM1v.x, dM1v.y, 0, 0.99,0.99)
	end
end