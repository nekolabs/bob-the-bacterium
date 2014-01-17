-- level1.lua
-- The Tutorial

Lvl1 = Gamestate.new();
-- LV. 01
function Lvl1:init()	
	atlMap = atl.Loader.load("Maps/level1.tmx");
	player = entity.new(150,928.5,55,79,atlMap,select(2,next(atlMap.layers)));
--	vx = 200;
  
	-- Create Coins and Enemies on Map 
	createNewFollowerEnemy(2000, 961.75); createNewEasyEnemy(2200, 961.75);
	createNewEasyEnemy(2400, 961.75); createNewCoin(867.5, 650, width, height);
	createNewCoin(967.5, 650, width, height); createNewCoin(1067.5, 650, width, height); 
	InvisJectionCreate(700, 961.75)
	
	playerCollide();
end
function Lvl1:update(dt) 
	if not gameIsPaused then --true because p already pushed
		playerCollide_generalUpdate(dt);	
		enem_update(dt);
		enemFollow_update(dt);
		player_update(dt);
		coin_update(dt);
		bullet_update(dt);
		InvisJection_update(dt)
	end
end
function Lvl1:draw()
	camera:set();

	atlMap:draw();
	enem_draw();
	enemFollow_draw();
	player_draw();
	coin_draw();
	bullet_draw();
	InvisJection_draw();
  
	camera:unset();
	playerCollide_drawStatBar();
end
function Lvl1:keypressed(k)
	lvl_keypressed(k);
end
function Lvl1:keyreleased(k)
	if k == "r" then 
		player.x, player.y = 150, 928.5; 
	end
end 
