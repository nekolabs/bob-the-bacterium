--level7.lua
--Mini Boss Level

Lvl7 = Gamestate.new()

function Lvl7:init()
  atlMap = atl.Loader.load('level7.tmx')
  player = entity.new(151,551,55,79,atlMap,select(2,next(atlMap.layers)))
  
  --Sounds
  BGMusic = love.audio.newSource("sfx/Plant.ogg")
  BGMusic:play()
  BGMusic:setLooping(true)

  --Enemies
  createNewFollowerEnemy(1000, 961.75); createNewEasyEnemy(1100, 961.75)
  createNewEasyEnemy(850, 961.75) createNewEasyEnemy(1300, 961.75)
  createNewEasyEnemy(1150, 961.75) createNewEasyEnemy(1500, 961.75)
  createNewEasyEnemy(1350, 961.75)
  --Boss (check with Boss.lua)
  boss = createNewRedBoss(2300, 850)

  playerCollide()
end
  
function Lvl7:update(dt) 
	if not ingameMenuOpen then 
		playerCollide_generalUpdate(dt)
		enem_update(dt)
		enemFollow_update(dt)	
		player_update(dt)
		bullet_update(dt)
		boss_update(dt)
		bossBullet_update(dt)
	end
end
function Lvl7:draw()
  camera:set()
	
  atlMap:draw()
  turret_draw()
  turretBullet_draw()
  player_draw()
  bullet_draw()
  enem_draw()
  enemFollow_draw()
  boss_draw()
  bossBullet_draw()
  ingameMenu_draw()
	
  camera:unset()
  playerCollide_drawStatBar();
  boss_drawBar();
end
function Lvl7:keypressed(key)
  ingameMenu_keypressed(key)
end

local releaseX, releaseY = 151, 551
function Lvl7:keyreleased(k)
	if k == 'r' then
		player.x, player.y = releaseX, releaseY
		vx = 200
	end
end
