-- level4.lua

Lvl4 = Gamestate.new()
-- LV. 04
function Lvl4:init()	
	atlMap = atl.Loader.load("Maps/level4.tmx")	
	player = entity.new(150,1550,55,79,atlMap,select(2,next(atlMap.layers)))

	coin1 = createNewCoin(1150,1625, width, height); coin2 = createNewCoin(1215, 1625, width, height);
	coin3 = createNewCoin(1275, 1625, width, height);coin4 = createNewCoin(1335, 1625, width, height);
	coin5 = createNewCoin(1405, 1625, width, height); turret1 = createTurret(2900, 1475) -- New Enemy the Turret
	createDrakul1(1010, 1470);createDrakul1(1100, 1470); --createDrakul1(1190, 1470); 
	
	playerCollide();
end
function Lvl4:update(dt)
	if not gameIsPaused then 
		playerCollide_generalUpdate(dt)	
		bullet_update(dt)
		turret_update(dt)
		turretBullet_update(dt)
		coin_update(dt)
		drakulMallet1_update(dt)

		player_update(dt)
	end
end
function Lvl4:draw()
  camera:set()
  
  atlMap:draw()
  coin_draw()
  turret_draw()
  turretBullet_draw()
  player_draw()
  bullet_draw()
  drakulMallet1_draw()
  
  camera:unset()
  
  playerCollide_drawStatBar()
end
function Lvl4:keypressed(k)
	lvl_keypressed(k) 
end
function Lvl4:keyreleased(k)	
	if k == 'r' then
		player.x, player.y = 150, 1550;
		vx = 200
	end
end 
