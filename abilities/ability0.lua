-- ability0.lua
-- The 1st special ability - Invincibility
-- cost: 2 xp, duration: 15 seconds (timer) 

-- Snippet for Box Collision
require("libsAndSnippets/BoundingBox")

-- InvJection Imgs
invJectionImg = love.graphics.newImage("assets/ability/invJection(blue).png")
invJeHeight, invJeWidth = invJectionImg:getHeight(), invJectionImg:getWidth()
starImg = love.graphics.newImage("assets/ability/invincState.png")

-- duration timers
invJStart = 0;
invJMax   = 15; 
invJVel   = 1;

collidedTimes = 0; --checks if already paid
playerLifesCheck = playerLifesCheck; --set value back to playerLifes before after 15s

InvJection = {}

function InvJectionCreate(x, y)
	table.insert(InvJection, { x=x, y=y, width = invJeWidth, height = invJeHeight} )
end
function InvJection_update(dt)
	for ii,iv in ipairs(InvJection) do 
		if xp >= 2 then --and invJStart == 0 then -- be able to pick it up when you have 2xp
			-- collision between the item box and the player  
			if CheckCollision(iv.x,iv.y,iv.width,iv.height, player.x, player.y, player.w, player.h) and collidedTimes == 0 then 
				collidedTimes = collidedTimes + 1 
				iv.x, iv.y = -500, -500 -- no abuse if xp == 4 or likewise (could leave that out as collidedTimes changed before)
	 
				invSound:play()
				playerLifesCheck = playerLifes; --save actual value in LifesCheck
			end
			-- split the collision condition from the timer otherwise the timer just counts up if touching the item
			if invJStart < invJMax and collidedTimes == 1 then
				invJStart = invJStart + (invJVel*dt)
				
				playerIsAlive = false -- in this case immortal (won't be killed through enemies)
				
				playerLifes = 4 -- just sth to change Lifes (and at the same time the print on screen)
			elseif invJStart >= invJMax then 
				playerIsAlive = true
				playerLifes = playerLifesCheck; --give value back
			
				invJStart = 0 
				collidedTimes = 0
				
				-- only the item shall be removed from the table with which Bob collided before
				if collidedTimes == 1 then 
					table.remove(InvJection, ii ) -- delete it outside screen (-500,-500) to save mem 
				end 
				-- cost of item; the cost affects the general XP at the end of the timer
				-- because the condition of the timer is that there are >= 2xp.
				-- cant be abused (if still >=2xp while timer is running because of collidedTimes(+1) and pos change of the item
				xp = xp - 2
			end
		end
	end
end	
function InvJection_draw()
	for ii,iv in ipairs(InvJection) do  
		love.graphics.draw(invJectionImg, iv.x, iv.y, 0, 1.5, 1.5)
	end
end
