-- level6.lua

Lvl6 = Gamestate.new();
-- LV. 06
function Lvl6:init()
	atlMap = atl.Loader.load("Maps/level6.tmx");
	player = entity.new(151,1550,55,79,atlMap,select(2,next(atlMap.layers)));

	coin1 = createNewCoin(3472, 1120, width, height); coin2 = createNewCoin(3248, 823, width, height);
	coin3 = createNewCoin(3472, 448, width, height); coin4 = createNewCoin(3472, 576, width, height);
	coin5 = createNewCoin(3472, 300, width, height); coin6 = createNewCoin(275, 1200, width, height);
	coin7 = createNewCoin(275, 500, width, height); coin8 = createNewCoin(95, 700, width, height);
	enemy1 = createNewEasyEnemy(2400, 1635, vxEnem );enemy2 = createNewEasyEnemy(2200, 1635, vxEnem );
	enemy3 = createNewEasyEnemy(2000, 1635, vxEnem );enemy4 = createNewEasyEnemy(1800, 1635, vxEnem );
	enemy5 = createNewEasyEnemy(1600, 1635, vxEnem );enemy6 = createNewEasyEnemy(1400, 1635, vxEnem );
	enemy7 = createNewEasyEnemy(1200, 1635, vxEnem );enemy8 = createNewEasyEnemy(1000, 1635, vxEnem );
	enemy9 = createNewEasyEnemy(800, 1635, vxEnem );enemy10 = createNewEasyEnemy(600, 1635, vxEnem );
	enemy11 = createNewEasyEnemy(450, 1635, vxEnem );
	--Enemies on the Platform
	enemy12 = createNewEasyEnemy(3200, 1317, vxEnem );enemy13 = createNewEasyEnemy(3300, 1317, vxEnem );
	--Injection
	InvJectionCreate(3472, 200);
	
	playerCollide()
end
function Lvl6:update(dt)
	if not gameIsPaused then 
		playerCollide_generalUpdate(dt);	
		bullet_update(dt);
		coin_update(dt);
		enem_update(dt);
		player_update(dt);
		InvJection_update(dt);
	end
end
function Lvl6:draw()
  camera:set();
  
  atlMap:draw();
  coin_draw();
  player_draw();
  bullet_draw();
  enem_draw();
  InvJection_draw();
  
  camera:unset();
  
  playerCollide_drawStatBar();
end
function Lvl6:keypressed(k)
	lvl_keypressed(k) 
end
function Lvl6:keyreleased(k)
	if k == 'r' then
		player.x,player.y = 151, 1550;
		vx = 200;
	end
end 
