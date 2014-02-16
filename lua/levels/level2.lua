-- level2.lua

Lvl2      = Gamestate.new()

-- LV. 02
function Lvl2:init()
	atlMap = atl.Loader.load('level2.tmx')
	vx, vy = 200, 0
	player = entity.new(150,785.5,55,79,atlMap,select(2,next(atlMap.layers)))

	coin1 = createNewCoin(1750, 620, width, height);coin2 = createNewCoin(1850, 620, width, height)
	coin3 = createNewCoin(1950, 620, width, height);coin4 = createNewCoin(2050, 620, width, height)
	-- enemies for Lv2 
	enem1 = createNewEasyEnemy(2750, 835)
	
	playerCollide()
end
function Lvl2:update(dt)
	if not ingameMenuOpen then 
		playerCollide_generalUpdate(dt)
		enem_update(dt)
		player_update(dt)
		coin_update(dt)
		bullet_update(dt)
	end
end
function Lvl2:draw()
	camera:set()
	
	atlMap:draw()
	enem_draw()
	player_draw()
	coin_draw()
	bullet_draw()
	ingameMenu_draw()

  camera:unset()
	playerCollide_drawStatBar()
end
function Lvl2:keypressed(key)
  ingameMenu_keypressed(key)
end

local relaseX, releaseY = 150, 785.75
function Lvl2:keyreleased(k)
	if k == 'r' then
		player.x, player.y = releaseX, releaseY
	end
end 
