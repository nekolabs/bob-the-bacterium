-- level5.lua

Lvl5 = Gamestate.new()
-- LV. 05
function Lvl5:init()	
	atlMap = atl.Loader.load('level5.tmx')
	player = entity.new(150,1550,55,79,atlMap,select(2,next(atlMap.layers)))
	playerCollide();
end
function Lvl5:update(dt)
	if not ingameMenuOpen then 
		playerCollide_generalUpdate(dt)
		boss_update(dt)
		bullet_update(dt)
		coin_update(dt)
		player_update(dt)
	end
end
function Lvl5:draw()
  camera:set()
  
  atlMap:draw()
  boss_draw()
  coin_draw()
  bullet_draw()
  player_draw()
  ingameMenu_draw()

  camera:unset()
  playerCollide_drawStatBar()
end
function Lvl5:keypressed(key)
  ingameMenu_keypressed(key)
end

local releaseX, releaseY = 150, 1550
function Lvl5:keyreleased(k)
	if k == 'r' then
		player.x, player.y = releaseX, releaseY
		vx = 200
	end
end 
