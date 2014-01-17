-- turret.lua
-- Type III - The Turret

require("Enemies/turretShot")
atl = require("libsAndSnippets/ATL")
require("libsAndSnippets/BoundingBox")

-- turret img, model L21
local l21       = love.graphics.newImage("assets/enemy/turret.png")
local l21Height, l21Width = standEnem:getHeight(), standEnem:getWidth()

-- the table which holds the important parameters concerning the turret
turret = {} 

-- number of times you hurt The Turret (max is 2)
shotTimes = 0 

-- Timers for shooting rate of the turret
countFrom = 0  
countSpeed = 1
countAim = 1

-- the turrent shouldn't move 
function createTurret(x, y)
	table.insert(turret, { x=x, y=y, width=l21Width, height=l21Height } )
end
function turret_update(dt)		
	for ei,ev in ipairs(turret) do 
		-- you have to shoot the turret twice to make it disappear and you'll get +3 score
		-- you could also use that in boss fight
		for bi,bv in ipairs(bullet) do 
			if CheckCollision(ev.x,ev.y,ev.width,ev.height, bv.x,bv.y,bv.width,bv.height) and shotTimes == 0  then 
				shotTimes = shotTimes + 1
				table.remove(bullet, bi)
				xp = xp + 1
			elseif CheckCollision(ev.x,ev.y,ev.width,ev.height, bv.x,bv.y,bv.width,bv.height) and shotTimes == 1 then 
				shotTimes = shotTimes + 1
				table.remove(turret, ei)
				table.remove(bullet, bi)
				
				-- when Bob destroys the turret every turretBullet'd be deleted too 
			--[[for i=1,#turretBullet do
					table.remove(turretBullet, tbi)
				end
			--]]
				xp = xp + 2 
			end
		end
	end

	-- the turretBullet Shot
	-- you can use shot2 because it's required through turretShot. 
	for ei,ev in ipairs(turret) do 
		if player.x <= ev.x - 500 then 
			shot2 = false 
		elseif player.x >= ev.x + 500 and shot2 then 
			shot2 = false
		end
		-- What happens outside the limit
		if player.y >= ev.y - 125 and shot2  then 
			shot2 = false
		elseif player.y <= ev.y + 100 and shot2 then 	
			shot2 = false 
		end
	
	    -- in these 2 big blocks we handle the shoot of The Turret. We set the shooting zones and
		-- let a counter count until a shot is fired (-> fire rate). 
		if (player.x > (ev.x - 500)) and not (player.x > (ev.x)) and not shot2
			and not (player.y < (ev.y - 125)) and not (player.y > (ev.y + 100)) then -- limit the y axis to save memory
			if countFrom < countAim then 
				countFrom = countFrom + (countSpeed*dt*2.5)
				
				-- The Turret enrages if Bob shot it once and wants to live longer so it increases (doubles) its 
				-- shooting rate
				if shotTimes == 1 then 
					countFrom = countFrom + (countSpeed*dt*5)
				end
			-- countAim = 1
			elseif countFrom >= 1 and not shot2 then 
				shot2 = true 
				-- the position where the turret bullet will be created with the transfer parameters used
				createTurretBullet(ev.x, ev.y + ev.height/2, "anticlockwise")

				-- set back so it can count again and shoot again
				countFrom = 0
			end
		elseif (player.x < (ev.x + 500)) and not (player.x < (ev.x + ev.width)) and not shot2
			and not (player.y < (ev.y - 125)) and not (player.y > (ev.y + 100)) then 
			if countFrom < countAim then 
				countFrom = countFrom + (countSpeed*dt*2.5)
				if shotTimes == 1 then 
					countFrom = countFrom + (countSpeed*dt*5)
				end
			elseif countFrom >= countAim and not shot2 then 
				shot2 = true 
				createTurretBullet(ev.x + ev.width+80, ev.y + ev.height/2, "clockwise")
			
				countFrom = 0
			end
		end
	end
end
function turret_draw()
	for ei,ev in ipairs(turret) do  
	--	love.graphics.rectangle('line', ev.x,ev.y,ev.width,ev.height)
		love.graphics.draw(l21, ev.x, ev.y, 0, 0.99,0.99)
	end
end
