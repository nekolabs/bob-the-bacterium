-- Boss.lua
require("Enemies/bossShot")
require("libsAndSnippets/BoundingBox")
require("bullet")

local RedBossPicLeft, RedBossPicRight  = love.graphics.newImage("assets/enemy/miniBoss_laser.png"), love.graphics.newImage("assets/enemy/miniBoss_laserRight.png");  
local rBossHeight, rBossWidth = RedBossPicLeft:getHeight(), RedBossPicLeft:getWidth(); --width and length of left and right equal
local actImg = RedBossPicLeft; --img at start

local walkTimer, walkCount, countSpeed  = 0, 3, .5;
shotTimes1, bossLifes, bossAlive = 0, 10, true;
local countFrom, countUpSpeed, countAim = 0, 1, 1;

-- status bar of boss and life imgs
local bossLifeImages = {}
local bossLifeImg = love.graphics.newImage("assets/bossLifeImg.png");
for i=0,10 do -- equal to the number of boss lifes
  table.insert(bossLifeImages, bossLifeImg);
end 
local bossBarImg = love.graphics.newImage("assets/enemy/bossBar.png");

RedBoss = {} 
function createNewRedBoss(x, y)
	table.insert(RedBoss, { x=x, y=y, width=rBossWidth, height=rBossHeight, vxBoss = 50 } )
end
function boss_update(dt)
	for ei,ev in ipairs(RedBoss) do
		if walkTimer >= walkCount then
			ev.x = ev.x + ev.vxBoss*dt;
			walkTimer = walkTimer + (countSpeed*dt);
			actImg = RedBossPicRight;
		end
		if walkTimer < walkCount then
			walkTimer = walkTimer + (countSpeed*dt);
			ev.x = ev.x - ev.vxBoss*dt;
			actImg = RedBossPicLeft;
		end
		if walkTimer >= 6 then 
			walkTimer = 0;
		end
--		if ev.x > atlMap.width*atlMap.tileWidth - (ev.width+75) then 
--			walkTimer = 0;
--		end
		-- collision boss vs bullets
		for bi,bv in ipairs(bullet) do
			if CheckCollision(ev.x, ev.y, ev.width, ev.height, bv.x, bv.y, bv.width, bv.height) and ((shotTimes1 >= 0) and (shotTimes1 < 10)) then 
				shotTimes1 = shotTimes1 + 1;
				bossLifes = bossLifes - 1;
				table.remove(bullet, bi);
				table.remove(bossLifeImages, i);
				xp = xp + 1;
			elseif CheckCollision(ev.x, ev.y, ev.width, ev.height, bv.x, bv.y, bv.width, bv.height) and shotTimes1 == 10 then 
				table.remove(RedBoss, ei);
				table.remove(bullet, bi);
				xp = xp + 2;
				shotTimes1 = 0;
				bossLifes = -1; -- destroy last life on lifebar		
				table.remove(bossLifeImages, i);
			end
		end
	end
	for ei,ev in ipairs(RedBoss) do 
		if player.x <= ev.x - 500 then 
			bossShot2 = false 
		elseif player.x >= ev.x + 500 and bossShot2 then 
			bossShot2 = false
		end
		-- What happens outside the limit 
		if player.y >= ev.y - 125 and bossShot2  then 
			bossShot2 = false
		elseif player.y <= ev.y + 100 and bossShot2 then 	
			bossShot2 = false 
		end

		if (player.x > (ev.x - 500)) and not (player.x > (ev.x)) and not BossShot2
			and not (player.y < (ev.y - 125)) and not (player.y > (ev.y + 100)) then -- limit the y axis to save memory
			actImg = RedBossPicLeft; 
			if countFrom < countAim then 
				countFrom = countFrom + (countSpeed*dt*2.5)

				if shotTimes == 1 then 
					countFrom = countFrom + (countSpeed*dt*5)
				end
			-- countAim = 1
			elseif countFrom >= 1 and not bossShot2 then 
				bossShot2 = true 
				createBossBullet(ev.x, ev.y + ev.height/2, "anticlockwise")
				countFrom = 0
			end
		elseif (player.x < (ev.x + 500)) and not (player.x < (ev.x + ev.width)) and not shot2
			and not (player.y < (ev.y - 125)) and not (player.y > (ev.y + 100)) then 
			actImg = RedBossPicRight;
			if countFrom < countAim then 
				countFrom = countFrom + (countSpeed*dt*2.5)
				if shotTimes == 1 then 
					countFrom = countFrom + (countSpeed*dt*5)
				end
			elseif countFrom >= countAim and not bossShot2 then 
				bossShot2 = true 
				createBossBullet(ev.x + ev.width+80, ev.y + ev.height/2, "clockwise")
			
				countFrom = 0
			end
		end
	end
end
function boss_draw()
  for ei,ev in ipairs(RedBoss) do  
    love.graphics.draw(actImg, ev.x, ev.y, 0, 0.99,0.99)
   end
end
function boss_drawBar() -- outside of camera in lv7
  love.graphics.draw(bossBarImg, love.graphics.getWidth()/2-352.5, love.graphics.getHeight()/9);
  -- DRY implementation of boss life imgs 
  for i=1,#bossLifeImages do
  	love.graphics.draw(bossLifeImages[i], (love.graphics.getWidth()/2-349.5)*(i/17.99)+47.65, love.graphics.getHeight()/4.6); -- boss bar position
  end
end
