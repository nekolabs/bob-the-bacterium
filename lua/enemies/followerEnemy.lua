-- FollowerEnemy.lua Working on Enemy Mechanics, Type II - The Follower

local lg = love.graphics
local pathToPlSrc = 'lua/player/'
require(pathToPlSrc .. 'bullet')

local standEnem = lg.newImage("assets/enemy/tutEnem.png")
local stEnemHeight, stEnemWidth = standEnem:getHeight(), standEnem:getWidth()

FollowerEnemy = {} 

function createNewFollowerEnemy(x, y)
	table.insert(FollowerEnemy, { x=x, y=y, width=stEnemWidth, height=stEnemHeight, vxEnem = 75 } )
end
function enemFollow_update(dt)

	-- The important things happen here --> As long as Bob's not in reach (means not more than (+/-)300px on away 
	-- from the enemy on the x axis (video coordinate system) the enemy stands still. Directly after Bob's in reach
	-- the Follower follows Bob. When Bob jumps over half the enemy it will change it's direction and follow Bob 
	-- vice versa
	for ei,ev in ipairs(FollowerEnemy) do 
		if player.x <= ev.x - 300 then 
			ev.x = ev.x + (ev.vxEnem*dt*0) 
		elseif player.x >= ev.x + 300 then 
			ev.x = ev.x + (ev.vxEnem*dt*0)
		end
		-- y axis with 0 xVelocity. The enemy shouldn't follow Bob when his at the top of the map or on a platform
		if player.y >= ev.y - 250 then 
			ev.x = ev.x + (ev.vxEnem*dt*0)
		elseif player.y <= ev.y + 250 then 
			ev.x = ev.x + (ev.vxEnem*dt*0)
		end
		-- important the inner borders (where the enemy is moving in)
		if (player.x > (ev.x - 300)) and not (player.x > (ev.x + stEnemWidth/2))
			and not (player.y < (ev.y - 250)) and not (player.y > (ev.y + 250)) then 
			ev.x = ev.x - (ev.vxEnem*dt) 
		elseif (player.x < (ev.x + 300)) and not (player.x < (ev.x - stEnemWidth/2))
			and not (player.y < (ev.y - 250)) and not (player.y > (ev.y + 250)) then 
			ev.x = ev.x + (ev.vxEnem*dt)
		end
	end
	-- Bullt and Follower Collision
	for ei,ev in ipairs(FollowerEnemy) do 
		for bi,bv in ipairs(bullet) do 
			if CheckCollision(ev.x,ev.y,ev.width,ev.height, bv.x,bv.y,bv.width,bv.height) then 
				table.remove(FollowerEnemy, ei)
				table.remove(bullet, bi)
				xp = xp + 1
			end
		end
	end
end

local rot,scale = 0,.99
function enemFollow_draw()
	for ei,ev in ipairs(FollowerEnemy) do
    love.graphics.draw(standEnem, ev.x, ev.y, rot, scale, scale)
  end
end
