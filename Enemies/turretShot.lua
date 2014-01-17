-- turretShot.lua
-- The bullets for the turret (type III enemy) 

atlMap = atl.Loader.load("Maps/level0.tmx")
-- same size as bullet of Bob
local bulletImg    = love.graphics.newImage("assets/bullet.png")
local buW, buH 	     = bulletImg:getWidth(), bulletImg:getHeight()

-- don't mess this up with shot which is shot1
shot2 = false 

turretBullet = {}
--same concept as in the bullet.lua
function createTurretBullet(x,y,tbulletDir)
	table.insert(turretBullet, { x=x, y=y, width=buW-2.5, height=buH-2.5, tbulletDir = tbulletDir, vxtBu = 200 } )
end

function turretBullet_update(dt)
	-- we need to split it or after the turret is dead the bullets won't move further 
	for tbi,tbv in ipairs(turretBullet) do
			if tbv.tbulletDir == "clockwise" then  
					-- movement of the bullet to the right with velocity of Bu (overriding xPos(bu))
					tbv.x = tbv.x + math.abs(tbv.vxtBu*dt) 	
			elseif tbv.tbulletDir == "anticlockwise" then
					tbv.x = tbv.x - math.abs(tbv.vxtBu*dt)
			end
	end
	-- dont use to capacity: bullets're getting deleated if they cross the map (table.remove(t,i)) or if 
	-- the diff between the bullet and bobs max (or min) about 450px. the cause is that if bob stands  
	-- there and shoots around him like a gunslinger it wont use to cap. Bob's not fast enough to overtake
	-- the bullet
	for tbi,tbv in ipairs(turretBullet) do 
		for ei,ev in ipairs(turret) do 
			if tbv.tbulletDir == "clockwise" then 
				if tbv.x > atlMap.width*atlMap.tileWidth + (-1)*buW then
				-- just delete ONE single bullet (after another)
					for i=1,1 do 
						table.remove(turretBullet, tbi)
					end
				elseif tbv.x > ev.x + 750 then 
					for i=1,1 do
					table.remove(turretBullet, tbi)
					end
				end
			end
			if tbv.tbulletDir == "anticlockwise" then 
				if tbv.x <  ev.x - (750 + buW) then
					for i=1,1 do
						table.remove(turretBullet,tbi)
					end
				elseif tbv.x < (atlMap.width*atlMap.tileWidth-atlMap.width*atlMap.tileWidth) + buW then 
					for i=1,1 do
						table.remove(turretBullet,tbi)
					end
				end
			end
		end 
	end
end
function turretBullet_draw()
	for tbi,tbv in ipairs(turretBullet) do
		love.graphics.circle("fill", tbv.x, tbv.y, 5)
    end
end