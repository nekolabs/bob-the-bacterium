-- ability1.lua
-- The 2nd special ability - Invisibility
-- cost: 2 xp, duration: 15 seconds (timer) 

-- Snippet for Box Collision
require("libsAndSnippets/BoundingBox")

-- InvisJection Imgs
invisJectionImg = love.graphics.newImage("assets/ability/invJection(grey).png")
invisJeHeight, invisJeWidth = invisJectionImg:getHeight(), invisJectionImg:getWidth()

-- duration timers
invisJStart = 0; invisJMax   = 15;  invisJVel   = 1;
collidedTimes1 = 0; --checks if already paid (for the invisibility item)
playerLifesCheck1 = playerLifesCheck1; 

InvisJection = {}

function InvisJectionCreate(x, y)
	table.insert(InvisJection, { x=x, y=y, width = invisJeWidth, height = invisJeHeight} )
end
function InvisJection_update(dt)
	for is,isv in ipairs(InvisJection) do 
		if xp >= 2 then --and invJStart == 0 then -- be able to pick it up when you have 2xp
			-- collision between the item box and the player  
			if CheckCollision(isv.x,isv.y,isv.width,isv.height, player.x, player.y, player.w, player.h) and collidedTimes1 == 0 then 
				collidedTimes1 = collidedTimes1 + 1 
				isv.x, isv.y = -500, -500 
				
				invisSound:play()
				playerLifesCheck1 = playerLifes;
			end
			-- split the collision condition from the timer otherwise the timer just counts up if touching the item
			if invisJStart < invisJMax and collidedTimes1 == 1 then 
				invisJStart = invisJStart + (invisJVel*dt)
				
				playerIsAlive = false -- Bob's like a ghost to the enemies
				
				if invJStart < invJMax and collidedTimes == 1 then 
					invJStart = 0
					collidedTimes = 0
				end
			elseif invisJStart >= invisJMax then
				playerIsAlive = true
				playerLifes = playerLifesCheck1;
			
				invisJStart = 0 
				collidedTimes1 = 0
				
				-- only the item shall be removed from the table with which Bob collided before
				if collidedTimes1 == 1 then 
					table.remove(InvisJection, is ) -- delete it outside screen (-500,-500) to save mem 
				end 
			
				xp = xp - 2
			end
		end
	end
end	
function InvisJection_draw()
	for is,isv in ipairs(InvisJection) do  
		love.graphics.draw(invisJectionImg, isv.x, isv.y, 0, 1.5, 1.5)
	end
end