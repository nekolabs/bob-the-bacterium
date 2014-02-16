-- Alice.lua
--[[ Lövely Bacterioid Girlfriend Alice! Finally.
 For those who don't get it: The sentence Bob's yelling at Alice 
 originates from the 50er TV series "I Love Lucy" (Lucy! I'm home!)
 ~Gaichu --]]

local lg = love.graphics
local aliceImg    = lg.newImage("assets/Alice.png")
local aliceHeight, aliceWidth = aliceImg:getHeight(), aliceImg:getWidth()

--msgs of Bob and Alice at the end 
local bobMsg, aliceMsg = love.graphics.newImage("assets/endMsg1.png"), love.graphics.newImage("assets/endMsg2.png")

aliceTimer,  aliceAim, aliceCountSpeed = 0, 2.5, 0.5 -- alice counter for last "Lv."
  
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

local rot, scale = 0,.99
function alice_draw()
	for ai,av in ipairs(Alice) do 
		love.graphics.draw(aliceImg, av.x, av.y, rot,scale,scale)
		if aliceTimer >= 1.625 then 
			love.graphics.draw(aliceMsg, av.x+14.5, av.y-125)
		end
	end
	if aliceTimer >= .866 then --draw Bob's msg to Alice (timer won't be exactly 2 thus >=2)
		love.graphics.draw(bobMsg, player.x-195, player.y - 125)
	end
end
