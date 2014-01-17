-- BTB 0.095B MIT License 

-- <Pool of Requirements>
love.graphics.setDefaultFilter("nearest", "nearest") --filter mode used when scaling images down, up
-- Simplification
require("playerCollide");
--Enemies
require("Enemies/EasyEnemy");
require("Enemies/Boss");
require("Enemies/FollowerEnemy");
require("Enemies/turret");
require("Enemies/turretShot");
require("Enemies/drakMallet1");
-- Player and Alice
require("player");
require("Alice");
-- "Objects"
require("bullet");
require("coins");
-- Gamestates (note Ver. 0.08A: gotIt.lua and death.lua are merged)
Gamestate = require("libsAndSnippets/hump/gamestate")
require("menu");
require("Credits");
require("Settings");
require("gotIt");
require("thankYou");
require("Fin");
-- Libraries and Snippets
require("libsAndSnippets/camera")
require("libsAndSnippets/BoundingBox") -- Collisions between Boxes
atl    = require("libsAndSnippets/ATL") -- Advanced Tiled Loader
entity = require("libsAndSnippets/atc") -- Advanced Tiled Collider
--Levels (bonus Lv. System [ON HIATUS]
level = {}
for i=1,8 do 
	level[i] = require("Levels/level" .. i);
end
speech = {}
require("speech");
ability = {}
for i=0,1 do
	ability[i] = require("abilities/ability" .. i);
end
intro = {}
for i=1,2 do
	intro[i] = require("Intro/intro" .. i);
end
function love.load()
  -- Pause boolean
  gameIsPaused = false;
  
  -- Gamestate Switching
  Gamestate.registerEvents();
  Gamestate.switch(intro);

  -- icon
  local iconData = love.image.newImageData("assets/icon.png");
  love.window.setIcon(iconData);
  
  player_load();

  -- Sound Effect Jumping and (gun is loaded in bullet.lua)
  wonSound, bounceSound = love.audio.newSource("sfx/Endflag.ogg"), love.audio.newSource("sfx/bounce3.ogg");
  bounceSound:setVolume(.085);
  gunshot:setVolume(.475);
end
function love.update(dt)
	collectgarbage();
end
function love.keyreleased(key)
	player_keyreleased(key);
	bullet_shoot(key);
end 
--function love.focus(f)
--  if not f then gameIsPaused = true;
--  else gameIsPaused = false; end
--end
function love.keypressed(k) 
  if k == 'p' then gameIsPaused = not gameIsPaused; end
end
function love.focus(f)
  if not f then
    gameIsPaused = true;
    else gameIsPaused = false;
  end
end
--used for camera and player
function math.clamp(x, min, max)
    return x < min and min or (x > max and max or x)
end
