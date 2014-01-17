--bullet.lua
atl = require("libsAndSnippets/ATL")
atlMap = atl.Loader.load("Maps/level0.tmx")
  
bulletImg    = love.graphics.newImage("assets/bullet.png")
buW 	     = bulletImg:getWidth()
buH 	     = bulletImg:getHeight()

--Sound for gun
gunshot = love.audio.newSource("sfx/gunshot.ogg")
gunshot:setLooping(false)

shot = false;

bullet = {}

-- function has transfer parameters (xPos(bu),yPos(bu)) and direction(bu) and creates it on map. 
-- parameters're getting inserted in bullet table 
function createNewBullet(x,y,bulletDir)
	table.insert(bullet, { x=x, y=y, width=buW-2.5, height=buH-2.5, bulletDir = bulletDir, vxBu = 700 } )
	gunshot:play();
end

-- manipulation of bullet values (bv) in table (bullet indices bi) 
-- "anticlockwise" means left dir "clockwise" right dir 

function bullet_update(dt)
  for bi,bv in ipairs(bullet) do
    if bv.bulletDir == "clockwise" then  
      -- movement of the bullet to the right with velocity of Bu (overriding xPos(bu))
      bv.x = bv.x + math.abs(bv.vxBu*dt) 
				
     -- dont use too much mem: bullets're getting deleated if they cross the map (table.remove(t,i)) or if 
     -- the diff between the bullet and bobs max (or min) about 450px. the cause is that if bob stands  
     -- there and shoots around him like a gunslinger it wont use to cap. Bob's not fast enough to overtake
     -- the bullet
     if bv.x > atlMap.width*atlMap.tileWidth + (-1)*buW then
      for i=1,1 do 
	table.remove(bullet, i)
      end
     elseif bv.x > player.x + 450 + (-1)*buW then 
      for i=1,1 do
	table.remove(bullet,i)
      end 
     end
     elseif bv.bulletDir == "anticlockwise"  then
      bv.x = bv.x - math.abs(bv.vxBu*dt)
      if bv.x < player.x - 450 + buW then
        for i=1,1 do
          table.remove(bullet,i)
      end
     if bv.x < (atlMap.width*atlMap.tileWidth-atlMap.width*atlMap.tileWidth) + buW then 
      for i=1,1 do
	table.remove(bullet,i)
      end
     end
    end 
   end
 end   
end
function bullet_draw()
	for bi,bv in ipairs(bullet) do 
	    -- love.graphics.setColor(rgb) -> could use that for boss fight when it's dangerous
		-- the color changes or sth like that
		love.graphics.circle("fill", bv.x, bv.y, 5)
    end
end
-- is included in main.keyreleased. creates a new bullet and overrides it's position(x, -x) with velocity of bu.
-- shot is true if bob shoots (l or k)... only one dir at one time can be true so bob cant shoot to the left (k) if you
-- are releasing right (l)
function bullet_shoot(k)
	if not shot and k == "k" and ok then --isn't shooting and is alive on map
		player.facing = "right"
		shot = false;
	createNewBullet(player.x + pWidth, player.y + pHeight/2 - 2.5 , "clockwise")
	elseif not shot and k == "j" and ok then
		player.facing = "left" 
		shot = false;
		createNewBullet(player.x, player.y + pHeight/2 - 2.5, "anticlockwise")
	else 
		player.facing = "stand"
		shot = false 
	end 
end
