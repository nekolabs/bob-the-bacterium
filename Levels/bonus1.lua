-- bonus1.lua
-- This will be the first bonus level of the bonus level system 
-- It's not in development right now 

function bonus1:init()
	self.background = love.graphics.newImage("assets/bg.jpg")
	
	atl = require("libsAndSnippets/ATL")
	atlMap = atl.Loader.load("Maps/bonus1.tmx")
	entity = require("libsAndSnippets/atc")
	
	player.playerNrml = entity.new(151,551,55,79,atlMap,select(2,next(atlMap.layers)))
	
	-- coins here
	
	function player.playerNrml:isResolvable(side, gx, gy, tile)
	   local tp = tile.properties
	   
	   if tp.type == 'marsUntfSolid' then
			if side == 'bottom' then floorFound = true; vy = 0 end
			return true
		end
		if tp.type == 'marsUntfSolid' then 
			if side == "right" or side == "left" then floorFound = false; vy = 50 end
			return true 
		end
	end
	
	camera:setBounds(0, 0, atlMap.width*atlMap.tileWidth - displayW, atlMap.height*atlMap.tileHeight - displayH)
    atlMap:setDrawRange(0,0, atlMap.width*atlMap.tileWidth, atlMap.height*atlMap.tileHeight)	
end 
function bonus1:update(dt)
		camera:setPosition(math.floor(player.playerNrml.x - (displayW/ 2)), math.floor(player.playerNrml.y - displayH/ 2))
end
function bonus1:draw()
	camera:set()
	atlMap:draw()
    player.playerNrml:draw(headingFor)
	camera:unset()
end
