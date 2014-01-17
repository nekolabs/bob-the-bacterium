-- level3.lua

Lvl3 = Gamestate.new();
-- LV. 03 (first "bigger" Lv with two ways of choice)
function Lvl3:init()
	atlMap = atl.Loader.load("Maps/level3.tmx");
	player = entity.new(150,675,55,79,atlMap,select(2,next(atlMap.layers)));

	-- coins and enemies -> all in groups on  map
 	coin1 = createNewCoin(845 ,165 , width, height); coin2 = createNewCoin(2300 , 105 , width, height);
	coin3 = createNewCoin(2300 ,145 , width, height);coin4 = createNewCoin(2300 , 185, width, height);
	coin5 = createNewCoin(1250 ,1075 , width, height);coin6 = createNewCoin(1250 ,1115 , width, height);
 	coin7 = createNewCoin(1250 ,1155 , width, height);coin8 = createNewCoin(1290 ,1155 , width, height);
	coin9  = createNewCoin(2080 ,1225, width, height);coin10 = createNewCoin(2120 ,1225, width, height);
	coin11 = createNewCoin(2160 ,1225 , width, height);coin12 = createNewCoin(2200 ,1225, width, height);
	coin13 = createNewCoin(2240, 1225, width, height);coin14   = createNewCoin(2700 ,750 , width, height);
	coin15   = createNewCoin(2800 ,750 , width, height);
	-- and because it's a star ...
	coin15_2 = createNewCoin(2752.5 ,800 , width, height);coin16   = createNewCoin(2700 ,834 , width, height);
	coin17   = createNewCoin(2800, 834, width, height);
	
	EasyEnemy1 = createNewEasyEnemy(2125, 165, vxEnem );EasyEnemy2 = createNewEasyEnemy(2125, 834, vxEnem );
    EasyEnemy3 = createNewEasyEnemy(1475, 834, vxEnem );EasyEnemy4 = createNewEasyEnemy(2455, 1220, vxEnem );
			
	playerCollide();
end
function Lvl3:update(dt)
	if not gameIsPaused then 
		playerCollide_generalUpdate(dt);
		enem_update(dt);
		player_update(dt);
		coin_update(dt);
		bullet_update(dt);
	end 
end
function Lvl3:draw()
  camera:set();
  
  atlMap:draw();
  enem_draw();
  player_draw();
  coin_draw();
  bullet_draw();
  
  camera:unset();

  playerCollide_drawStatBar();
end
function Lvl3:keypressed(k)
	lvl_keypressed(k) 
end
function Lvl3:keyreleased(k)
	if k == 'r' then 
		player.x, player.y = 150, 675;
	end
end 
