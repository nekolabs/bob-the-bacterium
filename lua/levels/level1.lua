-- level1.lua is the tutorial

Lvl1 = Gamestate.new()
local pathToLibs = 'lua/libraries/'

function Lvl1:init()	
	atlMap = atl.Loader.load('level1.tmx')
  local entity = require(pathToLibs .. 'atc') 
	player = entity.new(150,928.5,55,79,atlMap,select(2,next(atlMap.layers)))
  
	-- Create Coins and Enemies on Map 
	createNewFollowerEnemy(2000, 961.75); createNewEasyEnemy(2200, 961.75)
	createNewEasyEnemy(2400, 961.75); createNewCoin(867.5, 650, width, height)
	createNewCoin(967.5, 650, width, height); createNewCoin(1067.5, 650, width, height) 
--	InvisJectionCreate(700, 961.75)
	
	playerCollide()
end
function Lvl1:update(dt) 
	if not ingameMenuOpen then --true because p already pushed
		playerCollide_generalUpdate(dt)	
		enem_update(dt)
		enemFollow_update(dt)
		player_update(dt)
		coin_update(dt)
		bullet_update(dt)
		InvisJection_update(dt)
	end
end
function Lvl1:draw()
	camera:set()

	atlMap:draw()
	enem_draw()
	enemFollow_draw()
	player_draw()
	coin_draw()
	bullet_draw()
	InvisJection_draw()
  ingameMenu_draw()

	camera:unset()
	playerCollide_drawStatBar()
end
function Lvl1:keypressed(key)
  ingameMenu_keypressed(key)
end

local releaseX, releaseY = 150, 928.5 -- respawn coords. release on Pos when 'r' is pushed
function Lvl1:keyreleased(k)
	if k == 'r' then player.x, player.y = releaseX, releaseY end
end 
