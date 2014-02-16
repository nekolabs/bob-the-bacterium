-- BTB 0.095B MIT License created by nekolabs (ElHuron and Gaichu) former jamlabs 
-- Thank you so much for playing (and reading the source code all the more)! 

local lg,la = love.graphics,love.audio
lg.setDefaultFilter("nearest", "nearest") -- filter mode used when scaling images down, up

local paths = { 'lua/enemies/', 'lua/player/', 'lua/libraries/', 'lua/startscreen_options/', 'lua/ending/', 'lua/levels/', 'lua/abilities/', 'lua/intro/' } -- just some shortenings 
local pathToEnemySrc, pathToPlSrc, pathToLibs, pathToOptionSrc, pathToEndSrc, pathToLvlSrc, pathToAbilSrc, pathToIntroSrc = unpack(paths)

-- pool of requirements (names should be quite obvious)
require(pathToLibs .. 'camera')
atl = require 'lua/libraries/ATL' -- used for maps
loader = require 'lua/libraries/ATL.Loader' 
loader.path = 'maps/'
atlMap = atl.Loader.load('level0.tmx') -- example map for math in player, bullet file etc
require(pathToLibs .. 'BoundingBox') 
entity = require(pathToLibs .. 'atc')

require(pathToEnemySrc .. 'easyEnemy')
require(pathToEnemySrc .. 'followerEnemy')
require(pathToEnemySrc .. 'turret')
require(pathToEnemySrc .. 'turretShot')
require(pathToEnemySrc .. 'drakMallet1')
require(pathToEnemySrc .. 'boss')

require(pathToPlSrc .. 'playerCollide') 
require(pathToPlSrc .. 'player')
require(pathToPlSrc .. 'bullet') 

Gamestate = require(pathToLibs .. 'hump/gamestate')

require(pathToOptionSrc .. 'menu')
require(pathToOptionSrc .. 'credits')
require(pathToOptionSrc .. 'Settings')
require(pathToOptionSrc .. 'gotIt')

require(pathToEndSrc .. 'Fin')
require(pathToEndSrc .. 'thankYou')

require 'lua/alice'
require 'lua/coins'
require 'lua/ingameMenu'

level = {}
for i=1,8 do 
	level[i] = require(pathToLvlSrc .. 'level' .. i) -- require all the levels in levels/ 
end
speech = {}
require('lua/speech')
ability = {}
for i=0,1 do
	ability[i] = require(pathToAbilSrc .. 'ability' .. i)
end
intro = {}
for i=1,2 do
	intro[i] = require(pathToIntroSrc .. 'intro' .. i)
end
function love.load()
  -- Pause boolean
  gameIsPaused = false
  
  -- Gamestate Switching
  Gamestate.registerEvents()
  Gamestate.switch(intro)

  -- icon
  local iconData = love.image.newImageData("assets/icon.png")
  love.window.setIcon(iconData)
  
  player_load()
  ingameMenu_init()

  -- Sound Effect Jumping and (gun is loaded in bullet.lua)
  wonSound, bounceSound = la.newSource('sfx/Endflag.ogg'), la.newSource('sfx/bounce3.ogg')
  local isBounceVol = .085
  bounceSound:setVolume(isBounceVol)
  --gunshot:setVolume(isGunVol)
end
function love.update(dt)
	collectgarbage()
end
function love.keyreleased(key)
	player_keyreleased(key)
	bullet_shoot(key)
end 
function love.focus(f)
  ingameMenu_focus(f)
end
function math.clamp(x, min, max) -- used with cam lib
    return x < min and min or (x > max and max or x)
end
