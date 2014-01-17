-- coins.lua
-- coins are created and collide with the player (increases score) ... and they spin around

-- Snippet for Box Collision
require("libsAndSnippets/BoundingBox")

-- Animation of Coins
coins = {}
for i=1,11 do 
	coins[i] = love.graphics.newImage("assets/coinAnimation/coin" .. i .. ".png")
end

-- coin sfx
coinSound = love.audio.newSource("sfx/coin1.ogg")
coinSound:setLooping(false)

-- starts anim with img1 of 11
coinHead = coins[1]
coinCountThrough = 1 
coinCountOn      = 0

coin = {}

function createNewCoin(x, y, width, height)
	table.insert(coin, { x=x, y=y, width = 12, height = 16} )
end
function coin_update(dt)
	coinHead = coins[coinCountThrough] --make it turn around
	
	coinCountOn = coinCountOn + dt --changing the image
	if coinCountOn <= 0 then 
		coinCountOn = 0
	end
	-- the img shall change after countOn's bigger than .25s
    -- so the index (to the begin) counts -1 and after counting -1 countOn's 0 and
    -- starts counting again -> in fact that makes the animation. after the index is at the end
    -- it's back to 11 (the first img here) so animation starts again
	if coinCountOn >= .07 then 
		coinCountThrough = coinCountThrough + 1
		
		coinCountOn = 0
	end
	if coinCountThrough > 11 then 
		coinCountThrough = 1
	end
    -- collision between coin and player
	for ci,cv in ipairs(coin) do  
			if CheckCollision(cv.x,cv.y,cv.width,cv.height, player.x, player.y, player.w, player.h) then 
				table.remove(coin, ci)
				score = score + 1
				
				coinSound:play()
			end
	end
end 
function coin_draw()
	for ci,cv in ipairs(coin) do  
		love.graphics.draw(coinHead, cv.x, cv.y, 0, 1.5, 1.5)
	end
end