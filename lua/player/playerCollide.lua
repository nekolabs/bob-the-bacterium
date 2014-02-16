--playerCollide.lua
--handling of collisions between player and tiles
--point: dont bloat player.lua and levels.lua 

local displayW, displayH = love.graphics.getWidth(), love.graphics.getHeight();

function playerCollide() --load images for status bar
	ok = true; --completing Lv. is possible 
	vx = 200; -- when entering level vx=200 (prevnts from having vx_gel after dying) 
	invSound = love.audio.newSource("sfx/Go_Cart.ogg")
	invSound:setLooping(false)
	invisSound = love.audio.newSource("sfx/MLOP.ogg")
	invisSound:setLooping(false)

	L1_ent, L2_ent = entity.new(510,100,32,32,atlMap,select(2,next(atlMap.layers))), entity.new(550,100,32,32,atlMap,select(2,next(atlMap.layers)));
	L3_ent = entity.new(590,100,32,32,atlMap,select(2,next(atlMap.layers)));
	L1, L2, L3 = love.graphics.newImage("assets/lives.png"), love.graphics.newImage("assets/lives.png"), love.graphics.newImage("assets/lives.png");
  starImg = love.graphics.newImage("assets/ability/invincState.png")
 
	-- <Collision Callback Pool for all Levels>
    function player:isResolvable(side, gx, gy, tile)
	   local tp = tile.properties
	   -- ice and dmg plus Gamestate switching
	   	   if tp.type == 'instruction1' then
				if side == 'right' or side == 'left' or side == 'bottom' then
					floorFound = true;
					vy = 0;
					ok = true; 
					Gamestate.switch(gotIt);
					wonSound:play();
					wonSound:setVolume(.475);
					wonSound:setLooping(false);
					local next = next; --traverse all field of tables to choose proper elements of tables to delete at end of Lv. 
					if (next(EasyEnemy) == nil or next(FollowerEnemy) == nil or next(coin) == nil
						or next(InvisJection) == nil or next(InvJection) == nil or next(drakulMallet1) == nil or
							next(turret) == nil or next(RedBoss) == nil) then 
								for i=1,#EasyEnemy do
									table.remove(EasyEnemy,ei)
								end
								for i=1,#FollowerEnemy do 
									table.remove(FollowerEnemy, ei)
								end
								for i=1,#coin do 
									table.remove(coin, ci)
								end 
								for i=1,#InvisJection do
									table.remove(InvisJection, is)
								end
								for i=1,#drakulMallet1 do
									table.remove(drakulMallet1, dM1i)
								end
								for i=1,#RedBoss do --bullets are deleted when leaving screen (see bossShot.lua)
									table.remove(RedBoss,ei)
								end
								for i=1,#turret do --same here (see turretShot.lua)
									table.remove(turret, ei)
								end
					end
					if change == 6 then 
						BGMusic:stop();
					end
					
					bounceSound:setVolume(0.00)
				--	gunshot:setVolume(0.00)
			   
					player.x = player.x - 150
					--Stop being invincible as soon as Bob hits on the endflag
					if invJStart < invJMax and collidedTimes == 1 then 
						invJStart = invJMax
						xp = xp -2
						invSound:stop()
					elseif invisJStart < invisJMax and collidedTimes1 == 1 then 
						invisJStart = invisJMax
						xp = xp -2
						invisSound:stop()
					end   
				end
		end
		-- ice and dmg plus Gamestate switching (no collision when item time running)
		if ((collidedTimes1 == 0) or (collidedTimes == 0)) then
			if tp.type == 'IceOb' or tp.type == 'IceRe' then  
				if side == 'bottom' then 
					Gamestate.switch(gotIt)
					ok = false
					playerIsAlive = false
				end
			end
			if tp.type == 'IceLi' then 
				if (side == 'top') or (side == 'bottom') or (side == 'right') then
					Gamestate.switch(gotIt)
					ok = false
					playerIsAlive = false
				end
			end
			if tp.type == 'IceUnt' or tp.type == 'IceOb' then
				-- has other points of collision than IceOb
				if side == "right"  then 
					Gamestate.switch(gotIt)
					ok = false
					playerIsAlive = false
				end
			end 
			if tp.type == 'IceRe' or tp.type == 'IceUnt' or tp.type == 'IceOb' then
				-- all points, but no right (view from Bob)
				if side == 'left' then 	
					Gamestate.switch(gotIt)
					ok = false
					playerIsAlive = false
				end
			end
			if tp.type == 'IceRe' or tp.type == 'IceUnt' then 
				if side == 'top' then
					Gamestate.switch(gotIt)
					ok = false
					playerIsAlive = false
				end
			end
		end
		-- Platforms
		-- Speedy Platform (vy speed increase)
		if tp.type == 'platformSpeedy' then
			if side == 'bottom' then floorFound = true; vy = -350; bounceSound:play() end
			return true
		end
		if tp.type == 'platformSpeedy' then 
			if side == 'left' then floorFound = true; vy = 0 end
			return true
		end
		if tp.type == 'platformSpeedy' then
			if side == 'right' then floorFound = true; vy = 0 end
			return true
		end
		-- Magnetize! You could also just include 'top' and add neg. yVelocity to Bob
		-- This way it takes the collision which stated here
		if tp.type == 'marsMag' then
			if side == 'bottom' then floorFound = true; vy = 0 end
			return true
		end	
		if tp.type == 'marsObSolid_clone' then 
			if side == 'top' then floorFound = false; vy = 0 end 
			return true
		end
		if tp.type == 'marsObSolid' then 
			if side == 'bottom' then floorFound = true; vy = 0 end 
			return true
		end
		if tp.type == 'marsObSolid_clone' then 
			if side == 'right' or side == 'left' then floorFound = true; vy = 0 end 
			return true
		end
		if tp.type == 'marsObSolid' then 
			if side == 'bottom' then floorFound = true; vy = 0 end
			return true 
	    end
	    if tp.type == 'marsUntSolid' then
			if side == 'bottom' then floorFound = true; vy = 0 end
			return true
		end
		if tp.type == 'marsReSolid' then
			if side == 'bottom' then floorFound = true; vy = 0 end
			return true 
		end
		if tp.type == 'marsLiSolid' then
			if side == 'bottom' then floorFound = true; vy = 0 end
			return true
		end
		if tp.type == 'marsObfSolid' then
			if side == 'bottom' then vx = 200; vy = 0; floorFound = true; end
			return true
		end
		-- "Underground" of Mars Setting
	    if tp.type == 'marsReUSolid' then 	
			if side == 'top' then floorFound = true; vy = 0 end
			return true
		end
		if tp.type == 'marsReObSolid' then
			if side == 'bottom' then floorFound = true; vy = 0 end
			return true
		end 
		if tp.type == 'marsLiObSolid' then
			if side == 'bottom' then floorFound = true; vy= 0 end
			return true
		end
		if tp.type == 'marsLiUSolid' then
			if side == 'top' then floorFound = true; vy = 0 end
			return true
		end		
		-- it seems that atc can't handle both bottom and top for a tile successful
		-- so split to several tiles
		if tp.type == 'marsUntfSolid' then 
			if side == 'top' then floorFound = false; vy = 0 end 
			return true
		end
		if tp.type == 'marsUntfSolid' then 
			if side == "right" or side == "left" then floorFound = true; vy = 0 end
			return true 
		end
		-- Propulsion (orange) and Repulsion (blue)
		-- SpeedX Gel (like the orange propulsion gel in portal) 
		-- we set the obf and ob vx to 200 so we're sure that Bob doesn't stay at 750 when he's back at the ground again
		if tp.type == 'marsOberFSpeedX' then 
			if side == 'bottom' then floorFound = true; vy = 0; vx = 750 end
			return true
		end
		-- repulsion gel, we use this to be able to handle better with jumpRe
		-- the speedy platform wouldn't satisfy us here because of the left and right "barriers"
		if tp.type == 'marsOberFSpeedY' then
			-- jump up, but hold the <, a whatever key you prefer 
			if side == 'bottom' then floorFound = true; vy = -365 end 
			return true 
		end
    end
	camera:setBounds(0, 0, atlMap.width*atlMap.tileWidth - displayW, atlMap.height*atlMap.tileHeight - displayH)
    atlMap:setDrawRange(0,0, atlMap.width*atlMap.tileWidth, atlMap.height*atlMap.tileHeight)
end
function playerCollide_generalUpdate(dt)
	-- Focus Cam on Player Position
	camera:setPosition(math.floor(player.x - (displayW/ 2)), math.floor(player.y - displayH/ 2))
end
function playerCollide_drawStatBar() --not really for collision, but for simplifcation too
   if playerLifes == 3 then 
   L1_ent:draw(L1); L2_ent:draw(L2); L3_ent:draw(L3);
   love.graphics.print("Lifes: " .. playerLifes, 640, 95); 
  elseif playerLifes == 2 then
   L1_ent:draw(L1); L2_ent:draw(L2);
   love.graphics.print("Lifes: " .. playerLifes, 640, 95);
  elseif playerLifes == 1 then 
   L1_ent:draw(L1);
   love.graphics.print("Lifes: " .. playerLifes, 640, 95);
  elseif playerLifes == 0 then 
	love.graphics.print("Lifes: Bonus +1", 640, 95)
  elseif not playerIsAlive and invJStart < invJMax and collidedTimes == 1 and
	not(playerLifes == 1 or playerLifes == 2 or playerLifes == 3) then 
		playerIsAlive = false
		love.graphics.print("Lifes: XX", 640, 95)
		love.graphics.draw(starImg, 550, 95)
  end 
  love.graphics.print("Score: " .. score, 510, 70)
  love.graphics.print("XP: " .. xp, 640 , 70 ) 
  camera:set()
  if gameIsPaused then
	love.graphics.print("Window is not active\nPush 'P' or activate", player.x - pWidth/2 ,player.y - pHeight/2 -50)
  end
  camera:unset()
end
function lvl_keypressed(k) 
	if k == 'q' then
	  love.event.push('quit')
	end
end
