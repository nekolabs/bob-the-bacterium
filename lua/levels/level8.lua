--level8.lua 
--the ingenious ending of BTB

Lvl8 = Gamestate.new()
function Lvl8:init()
	atlMap = atl.Loader.load('level0.tmx')
	player = entity.new(150,961.5,55,79,atlMap,select(2,next(atlMap.layers)))

	createAlice(400, 985) -- place Alice for the romantic end
	
	playerCollide()
end
function Lvl8:update(dt)
	if not ingameMenuOpen then 
		playerCollide_generalUpdate(dt)
	
		player_update(dt)
		alice_update(dt)
		bullet_update(dt)
	end
end
function Lvl8:draw()
	camera:set()
	
	atlMap:draw()
	player_draw()
	alice_draw()
	bullet_draw()
	ingameMenu_draw()

  camera:unset()
		
	playerCollide_drawStatBar()
end
function Lvl8:keypressed(key)
  ingameMenu_keypressed(key)
end

local releaseX, releaseY = 150, 150
function Lvl8:keyreleased(k)
	if k == 'r' then
		player.x, player.y = releaseX, releaseY
	end
end 
