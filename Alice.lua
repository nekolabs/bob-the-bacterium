-- Alice.lua
-- Lövely Bacterioid Girlfriend Alice! Finally.
-- For those who don't get it: The sentence Bob's yelling at Alice 
-- originates from the 50er TV series "I Love Lucy" (Lucy! I'm home!)
-- ~Gaichu

atl = require("libsAndSnippets/ATL")
require("libsAndSnippets/BoundingBox")

aliceImg    = love.graphics.newImage("assets/Alice.png")
aliceHeight = standEnem:getHeight()
aliceWidth  = standEnem:getWidth()
--msgs of Bob and Alice at the end
bobMsg 		= love.graphics.newImage("assets/endMsg1.png")
aliceMsg    = love.graphics.newImage("assets/endMsg2.png")

-- alice counter for last Lv.
aliceTimer = 0;
aliceAim = 2.5;
aliceCountSpeed = 0.5;
  
Alice = {} 

function createAlice(x, y)
	table.insert(Alice, { x=x, y=y, width=aliceWidth, height=aliceHeight, vxAlice = 0  } )
end
function alice_update(dt)
	--for ai,av in ipairs(Alice) do 
	if aliceTimer < aliceAim and aliceTimer ~= -1 then 
		aliceTimer = aliceTimer + (aliceCountSpeed*dt)
	elseif aliceTimer >= aliceAim then 
		Gamestate.switch(thankYou)
	end
end
function alice_draw()
	for ai,av in ipairs(Alice) do 
		love.graphics.draw(aliceImg, av.x, av.y, 0, 0.99,0.99)
		if aliceTimer >= 1.625 then 
			love.graphics.draw(aliceMsg, av.x+14.5, av.y-125)
		end
	end
	if aliceTimer >= .866 then --draw Bob's msg to Alice (timer won't be exactly 2 thus >=2)
		love.graphics.draw(bobMsg, player.x-195, player.y - 125)
	end
end