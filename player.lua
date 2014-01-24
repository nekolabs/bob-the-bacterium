-- player.lua belov bob (sry for the mess)

local displayW, displayH = love.graphics.getWidth(), love.graphics.getHeight();
function player_load()
  player = { facing = "stand", x=x, y=y, w=w, h=h } 
  player = entity.new(player.x,player.y,player.w,player.h,atlMap,select(2,next(atlMap.layers)));
  -- player anims
  -------------------------------
  -- load them in a table for each direction which is important for now
  playerleft = {}  
  -- loads the 5 left pics into an array
  for i=1,5 do playerleft[i] = love.graphics.newImage("assets/player/animations/playerleft" .. i .. ".png") end
  
  playeright = {}
  for i=1,5 do 	playeright[i] = love.graphics.newImage("assets/player/animations/playeright" .. i .. ".png") end  
  
  playerstand = {}
  for i=1,5 do playerstand[i] = love.graphics.newImage("assets/player/animations/playerstand" .. i .. ".png") end
  
  -- following the shooting animations (left and right)
  playershootleft = {}
  
  -- load the 6 left shoot pics into an array
  for i=1,6 do playershootleft[i] = love.graphics.newImage("assets/player/animations/shooting/playershootleft" .. i .. ".png") end 
  
  playershootright = {}
  for i=1,6 do playershootright[i] = love.graphics.newImage("assets/player/animations/shooting/playershootright" .. i .. ".png") end 
 

  headingFor, animCountThrough, animStartCountOn = playerstand[1],1,0 -- hold current image for anim
 
  -- load the skins for the special items 
  -- invinc 
  playerleftInvinc = {} 
  for i=1,5 do playerleftInvinc[i] = love.graphics.newImage("assets/player/aniInvinc/playerleft" .. i .. ".png") end
  
  playerightInvinc = {}
  for i=1,5 do playerightInvinc[i] = love.graphics.newImage("assets/player/aniInvinc/playeright" .. i .. ".png") end 
  playerstandInvinc = {}
  for i=1,5 do playerstandInvinc[i] = love.graphics.newImage("assets/player/aniInvinc/playerstand" .. i .. ".png") end
  
  -- Shooting in Invinc mode
  playershootleftInvinc = {}
  for i=1,6 do playershootleftInvinc[i] = love.graphics.newImage("assets/player/aniInvinc/shooting/playershootleft" .. i .. ".png") end 
  playershootrightInvinc = {}
  for i=1,6 do playershootrightInvinc[i] = love.graphics.newImage("assets/player/aniInvinc/shooting/playershootright" .. i .. ".png") end 
  
  -- load the skins for the special items 
  -- invis 
  playerleftInvis = {}
  for i=1,5 do playerleftInvis[i] = love.graphics.newImage("assets/player/aniInvis/playerleft" .. i .. ".png") end
  
  playerightInvis = {}
  for i=1,5 do playerightInvis[i] = love.graphics.newImage("assets/player/aniInvis/playeright" .. i .. ".png") end 
  playerstandInvis = {}
  for i=1,5 do playerstandInvis[i] = love.graphics.newImage("assets/player/aniInvis/playerstand" .. i .. ".png") end
  
  -- Shooting in Invinc mode
  playershootleftInvis = {}
  for i=1,6 do playershootleftInvis[i] = love.graphics.newImage("assets/player/aniInvis/shooting/playershootleft" .. i .. ".png") end 
  playershootrightInvis = {}
  for i=1,6 do playershootrightInvis[i] = love.graphics.newImage("assets/player/aniInvis/shooting/playershootright" .. i .. ".png") end 
  
  pHeight = playerstand[1]:getHeight()
  pWidth = playerstand[1]:getWidth()
 
  -- the atc lib says false/true for the best performance
    player.isBullet = false;
    player.isActive = true;

  -- Bob is not jumping and stands on floor (normal) 
  Jumping = false 
  floorFound = true 
  
  --Bob's Velocities and gravity influencing him (pulls him down)
  vx, vy, vj, gravity = 200, 0, 200, 300;
  -- Score/XP (Coins/XP)
  score, xp = 0, 0;
  -- Player Deaths and Lifes Stuff (and life img)
  playerLifes, playerDied, playerIsAlive = 3, 0, true;
  
  function changePlayerCoords(change) --handles playerdeaths and port under map
		coords = { player.x, player.y }
		if not(change == 1 or change == 2 or change == 3 or change == 4 or change == 5) then 
			player.x, player.y = 150, 925;
			return coords
		elseif change == 3 or change == 4 or change == 5 then 
			player.x, player.y = 150, 1550;
			return coords
		elseif change == 1 then 
			player.x, player.y = 150, 785.5;
			return coords
		elseif change == 2 then 
			player.x, player.y = 150, 675;
			return coords
		end
	end
end
function player_update(dt)
	collectgarbage(collect);
	-- movement of player 
    if love.keyboard.isDown('right','d') then
	    player.facing = "right" 
	
		    -- math.abs not important, just here for testing 
			dx = math.abs(vx*dt)
			headingFor = playeright[animCountThrough]
	
			-- The Timer counts and like mentioned above if a specific time's reached the pic 
			-- counts +1 and overrides the old pic of the player 
			animStartCountOn = animStartCountOn + dt 
			if animStartCountOn <= 0 then 
				animCountThrough = 0
			end 
			if animStartCountOn >= .08 then
					animCountThrough = animCountThrough + 1
					
					-- Reset the Timer (like mentioned above)
					animStartCountOn = 0
			end
			
			-- If last element of array is reached -> start again from pic 1
			if animCountThrough > 5 then
				animCountThrough = 1 
			end
			
			-- Invinc
			if not playerIsAlive and invJStart < invJMax and collidedTimes == 1 then -- as long as the invinc timer is running 
				headingFor = playerightInvinc[animCountThrough]
			elseif not playerIsAlive and invisJStart < invisJMax and collidedTimes1 == 1 then 
				headingFor = playerightInvis[animCountThrough]
			end
		elseif love.keyboard.isDown('left', 'a') then 
			player.facing = "left"

			dx = -1*(math.abs(vx*dt))
			headingFor = playerleft[animCountThrough]
			
			animStartCountOn = animStartCountOn + dt
			if animStartCountOn <= 0 then 
				animCountThrough = 0
			end 
			if animStartCountOn >= .08 then
					animCountThrough = animCountThrough + 1
					animStartCountOn = 0
			end
			if animCountThrough > 5 then
				animCountThrough = 1 
			end
			if not playerIsAlive and invJStart < invJMax and collidedTimes == 1 then 
				headingFor = playerleftInvinc[animCountThrough]
			elseif not playerIsAlive and invisJStart < invisJMax and collidedTimes1 == 1 and invJStart == 0 then 
				headingFor = playerleftInvis[animCountThrough]
			end
		else
			-- Same here, but without movement... (stand around in else case)
			player.facing = "stand"
			
			dx = 0
			headingFor = playerstand[animCountThrough]
			animStartCountOn = animStartCountOn + dt
			if animStartCountOn <= 0 then 
				animCountThrough = 0
			end 
			if animStartCountOn >= .092 then
					animCountThrough = animCountThrough + 1
					
					-- Set timer back - again
					animStartCountOn = 0
			end
			if animCountThrough > 5 then
				animCountThrough = 1 
			end
			if not playerIsAlive and invJStart < invJMax and collidedTimes == 1 then -- as long as the invinc timer is running 
				headingFor = playerstandInvinc[animCountThrough]
			elseif not playerIsAlive and invisJStart < invisJMax and collidedTimes1 == 1 and invJStart == 0 then 
				headingFor = playerstandInvis[animCountThrough]
			end
		end
		
		-- y direction (Jumping with Gravity)
		local gdt = gravity*dt;
		vy = vy + gdt -- gravity is pulling the player down (+gravity because its a Video Coordinate System which begins upper left)
		dy = (2*vy + gdt)*dt; -- smooth jump
		-- Bob's not flying and stands on the floor
		if Jumping and floorFound then 
			Jumping = false; 
			floorFound = true; 
		elseif love.keyboard.isDown('up', 'w', ' ' ) and floorFound and not Jumping then
			bounceSound:play();
			
			vy = -vj; --set the jump power 
		    dy = vy*dt;
			
			Jumping = true; -- Bob's already jumping
			floorFound = false;  
		end
		player:move(dx,dy);

		
		-- Spin of the player when he shoots clockwise or anticlockwise and looks to the oder side. It has
        -- the function of a Shooting Direction Adjustment.
		-- Also there: player cant shoot left if standing there because he looks to the right
        -- purpose: before that you've been able to shoot left if standing to the right side also if you've been
		-- running or jumping, that's not longer possible
		for bi,bv in ipairs(bullet) do 
			if bv.bulletDir == "clockwise" and player.facing == "left" then 
				player.facing = "right" 
				
				headingFor = playeright[animCountThrough]
				
				if animStartCountOn >= 1 and animCountThrough ~= -1 then 
					animCountThrough = animCountThrough + 1
					
					animStartCountOn = 0 
				end 
				if animCountThrough > 5 then 
					animCountThrough = -1
				end
				if not playerIsAlive and invJStart < invJMax and collidedTImes == 1 then -- as long as the invinc timer is running 
					headingFor = playerightInvinc[animCountThrough]
				elseif not playerIsAlive and invisJStart < invisJMax and collidedTimes1 == 1 and invJStart == 0 then 
					headingFor = playerightInvis[animCountThrough]
				end
			end
			if bv.bulletDir == "anticlockwise" and player.facing == "right" then 
				player.facing = "left" 
				headingFor = playerleft[animCountThrough]
				
				if animStartCountOn >= 1 and animCountThrough ~= -1 then 
					animCountThrough = animCountThrough + 1
					
					animStartCountOn = 0 
				end 
				if animCountThrough > 5 then 
					animCountThrough = -1
				end
				if not playerIsAlive and invJStart < invJMax and collidedTimes == 1 then -- as long as the invinc timer is running 
					headingFor = playerleftInvinc[animCountThrough]
				elseif not playerIsAlive and invisJStart < invisJMax and collidedTimes1 == 1 and invJStart == 0 then 
					headingFor = playerleftInvis[animCountThrough]
				end
			end
			-- following the shooting anims. 
			if bv.bulletDir == "anticlockwise" and player.facing == "stand" then 
				player.facing = "left" 
				headingFor = playershootleft[animCountThrough]
		
				-- the bullet is removes when it leaves screen, kills an enemy or is +/- 650px away from the player
				-- and the the animation endures the time of the bullet available in a direction so we have to slow the down it to make it look independet from bullet
			  animStartCountOn = animStartCountOn + dt*.005;
				if animStartCountOn >= 1 then 
						animCountThrough = animCountThrough + 1 
						animStartCountOn = 0 
				end 
				if animCountThrough > 6 then
			    animCountThrough = 0
				end
				-- Invinc Imgs for Shooting
				if not playerIsAlive and invJStart < invJMax and collidedTimes == 1 then -- as long as the invinc timer is running 
					headingFor = playershootleftInvinc[animCountThrough]
				elseif not playerIsAlive and invisJStart < invisJMax and collidedTimes1 == 1  and invJStart == 0 then 
					headingFor = playershootleftInvis[animCountThrough]
				end
			elseif bv.bulletDir == "clockwise" and player.facing == "right" then 
				player.facing = "right" 
				headingFor = playershootright[animCountThrough]
				
				animStartCountOn = animStartCountOn + dt*.005 
				
				if animStartCountOn >= 1 and animCountThrough ~= -1 then 
						animCountThrough = animCountThrough + 1 
						animStartCountOn = 0 
				end 
				if animCountThrough > 6 then
					animCountThrough = -1
				end
				if not playerIsAlive and invJStart < invJMax and collidedTimes == 1 then -- as long as the invinc timer is running 
					headingFor = playershootrightInvinc[animCountThrough]
				elseif not playerIsAlive and invisJStart < invisJMax and collidedTimes1 == 1 and invJStart == 0 then 
					headingFor = playershootrightInvis[animCountThrough]
				end
			elseif bv.bulletDir == "clockwise" and player.facing == "stand" then 
				player.facing = "right" 
				headingFor = playershootright[animCountThrough]
				
				animStartCountOn = animStartCountOn + dt*.005
					
				if animStartCountOn >= 1 and animCountThrough ~= -1 then 
						animCountThrough = animCountThrough + 1 
						animStartCountOn = 0 
				end 
				if animCountThrough > 6 then
					animCountThrough = -1
				end
				if not playerIsAlive and invJStart < invJMax and collidedTimes == 1 then -- as long as the invinc timer is running 
					headingFor = playershootrightInvinc[animCountThrough]
				elseif not playerIsAlive and invisJStart < invisJMax and collidedTimes1 == 1 and invJStart == 0 then 
					headingFor = playershootrightInvis[animCountThrough]
				end
			elseif bv.bulletDir == "anticlockwise" and player.facing == "left" then 
				player.facing = "left" 
				headingFor = playershootleft[animCountThrough]
				
				animStartCountOn = animStartCountOn + dt*.005
					
				if animStartCountOn >= 1 and animCountThrough ~= -1 then 
					animCountThrough = animCountThrough + 1 
					animStartCountOn = 0 
				end 
				if animCountThrough > 6 then
					animCountThrough = -1
				end
				if not playerIsAlive and invJStart < invJMax and collidedTimes == 1 then -- as long as the invinc timer is running 
					headingFor = playershootleftInvinc[animCountThrough]
				elseif not playerIsAlive and invisJStart < invisJMax and collidedTimes1 == 1 and invJStart == 0 then 
					headingFor = playershootleftInvis[animCountThrough]
				end
			end
    end
	-- port back if collision fails and Bob falls through map
	-- the coords are ok for now if they change because of the maps we could change this here later
	if player.y > atlMap.height*atlMap.tileHeight or  
		player.y < atlMap.height*atlMap.tileHeight + (-1)*atlMap.height*atlMap.tileHeight+32 or 
			player.x > atlMap.width*atlMap.tileWidth - player.w or 
				player.x < (atlMap.width*atlMap.tileWidth + (-1)*atlMap.width*atlMap.tileWidth) then 
				changePlayerCoords(change); 
	end 
	-- The Dying of the Player's handled in here. The player can die has 3 lifes and can die 4 times
   -- from 3 to 0. Also decide between different Levels (ToDo)
   for ei,ev in ipairs(EasyEnemy) do 
		if CheckCollision(ev.x, ev.y, ev.width, ev.height, player.x, player.y, player.w,player.h) then  
			-- playerDied <= 2 because Died shall stop counting if we reached 3. So the last Count's on 2 to 3
			if playerDied <= 2 and playerIsAlive then
				playerIsAlive = true 
				
				changePlayerCoords(change);

				playerDied  = playerDied + 1 -- aim: 4 times dead -> lose 
				playerLifes = playerLifes - 1
				-- Directly after dying the last time Bob get's ported to the death gamestate and lost the game 
			elseif playerDied == 3 then
				playerIsAlive = false
				Gamestate.switch(gotIt)
				ok = false -- totally needed here otherwise player would fwd a Lv.
				
				playerDied = 0 
			end
		end
		if not playerIsAlive and CheckCollision(ev.x, ev.y,ev.width,ev.height, player.x,player.y,player.w,player.h) and 
			collidedTimes == 1 then -- test for invinc state (not just wander through enemies)
			playerIsAlive = false 
			table.remove(EasyEnemy, ei)
		end
    end
	for ei,ev in ipairs(RedBoss) do 
		if CheckCollision( ev.x, ev.y,ev.width,ev.height, player.x,player.y,player.w,player.h) then  
			-- playerDied <= 2 because Died shall stop counting if we reached 3. So the last Count's on 2 to 3
			if playerDied <= 2 and playerIsAlive then
				playerIsAlive = true 
				
				changePlayerCoords(change);
				
				playerDied  = playerDied + 1 -- aim: 4 times dead -> lose 
				playerLifes = playerLifes - 1
			     
				-- Directly after dying the last time Bob get's ported to the death gamestate and lost the game 
			elseif playerDied == 3 then
				playerIsAlive = false
				Gamestate.switch(gotIt)
				ok = false
				
				playerDied = 0 
			end
		end
    end 
	 for ei,ev in ipairs(FollowerEnemy) do 
		if CheckCollision( ev.x, ev.y,ev.width,ev.height, player.x,player.y,player.w,player.h) then  
			-- playerDied <= 2 because Died shall stop counting if we reached 3. So the last Count's on 2 to 3
			if playerDied <= 2 and playerIsAlive then
				playerIsAlive = true 
				
				changePlayerCoords(change);
				
				playerDied  = playerDied + 1 
				playerLifes = playerLifes - 1
			     
				-- Directly after dying the last time Bob get's ported to the death gamestate and lost the game 
			elseif playerDied == 3 then
				playerIsAlive = false
				Gamestate.switch(gotIt)
				ok = false
				
				playerDied = 0 
			end
			if not playerIsAlive and CheckCollision(ev.x, ev.y,ev.width,ev.height, player.x,player.y,player.w,player.h) and
				collidedTimes == 1 then -- test for invinc state (not just wander through enemies)
				playerIsAlive = false 
				table.remove(FollowerEnemy, ei)
			end
		end
    end
	for ei,ev in ipairs(turret) do
		if CheckCollision( ev.x, ev.y,ev.width,ev.height, player.x,player.y,player.w,player.h) then
			-- playerDied <= 2 because Died shall stop counting if we reached 3. So the last Count's on 2 to 3
			if playerDied <= 2 and playerIsAlive then
				playerIsAlive = true
				
				changePlayerCoords(change);

				playerDied = playerDied + 1 -- aim: 4 times dead -> lose
				playerLifes = playerLifes - 1
				
				vx = 200
				-- Directly after dying the last time Bob get's ported to the death gamestate and lost the game
			elseif playerDied == 3 then
				playerIsAlive = false
				Gamestate.switch(gotIt)
				ok = false
				
				playerDied = 0 
				vx = 200
			end
		end
	end
	for tbi,tbv in ipairs(turretBullet) do
		if CheckCollision( tbv.x, tbv.y,tbv.width, tbv.height, player.x,player.y,player.w,player.h) then
			if playerDied <= 2 and playerIsAlive then
				playerIsAlive = true
				
				changePlayerCoords(change);
			
				playerDied = playerDied + 1 
				playerLifes = playerLifes - 1
				
				vx = 200
				table.remove(turretBullet, tbi)
			elseif playerDied == 3 then
				playerIsAlive = false
				Gamestate.switch(gotIt)
				ok = false
				
				playerDied = 0 
				table.remove(turretBullet, tbi)
			end
		end
	end
	for Bbi,Bbv in ipairs(bossBullet) do
		if CheckCollision( Bbv.x, Bbv.y, Bbv.width, Bbv.height, player.x,player.y,player.w,player.h) then
			if playerDied <= 2 and playerIsAlive then
				playerIsAlive = true
				
				changePlayerCoords(change);
				
				playerDied = playerDied + 1 
				playerLifes = playerLifes - 1
				
				vx = 200
				table.remove(bossBullet, Bbi)
			elseif playerDied == 3 then
				playerIsAlive = false
				Gamestate.switch(gotIt)
				ok = false
				
				playerDied = 0 

				vx = 200 
				
				table.remove(bossBullet, Bbi)
			end
		end
	end
	for dM1i,dM1v in ipairs(drakulMallet1) do 
		if CheckCollision(dM1v.x, dM1v.y, dM1v.width, dM1v.height, player.x, player.y, player.w,player.h) then  
			if playerDied <= 2 and playerIsAlive then
				playerIsAlive = true 
			    
				changePlayerCoords(change);
				
				playerDied  = playerDied + 1 
				playerLifes = playerLifes - 1
				vx=200
			elseif playerDied == 3 then
				playerIsAlive = false
				Gamestate.switch(gotIt)
				ok = false
				
				playerDied = 0
				vx=200
			end
		end
		if not playerIsAlive and CheckCollision(dM1v.x, dM1v.y,dM1v.width,dM1v.height, player.x,player.y,player.w,player.h) and 
			collidedTimes == 1 then -- just to wander through the little Mallet even if invinc state
			playerIsAlive = false 
		end
    end
end
function player_keyreleased(key)
end
function player_draw()
	player:draw(headingFor, player.x, player.y)
end
