-- Settings.lua
-- Gamestates which can be accessed through the menu

Settings = Gamestate.new()
local SettingsButton, fModeButton, audioMasterButton = {}, {}, {};
local c, a, fMode, audio = 0, 0, false, true; --counter enabling/disabling fullscreen and fullscreen boolean (on/off?)
local function SettingsButton_spawn(x,y,text,id)
	table.insert(SettingsButton, {x = x, y = y, text = text, id = id});
end
local function fModeButton_spawn(x, y, text, id) 
	table.insert(fModeButton, {x = x, y = y, text = text, id = id});
end
local function audioMasterButton_spawn(x, y, text, id)
	table.insert(audioMasterButton, {x = x, y = y, text = text, id = id});
end
function Settings:init()
	self.settingsBg = love.graphics.newImage("assets/bgSettings.jpg");
	
	-- row1 page1
	-- Imgs in table so that they can be deleted and inserted when needed (return to menu normally)
	LvlImg = {}
	for i=1,3 do 
		LvlImg[i] = love.graphics.newImage("assets/LvlImg" .. i .. ".png");
	end
	-- row2 page1
	LvlImg_2_ = {}
	for i=1,2 do 
		LvlImg_2_[i] = love.graphics.newImage("assets/LvlImg_2_" .. i .. ".png");
	end
	
	local font = love.graphics.newFont("fonts/PixAntiqua.ttf", 30);
	fontNew = font;

	-- Creates the clickable Buttons for the levels
	SettingsButton_spawn(50, 110, "Lv. 1", "lvl1"); SettingsButton_spawn(275, 110, "Lv. 2", "lvl2");
	SettingsButton_spawn(525, 110, "Lv. 3", "lvl3"); SettingsButton_spawn(275, 300, "Lv. 4", "lvl4");
	SettingsButton_spawn(525, 300, "Lv. 5", "lvl5"); 
	fModeButton_spawn(400, 482.5, "[   ]", "fModeTrue"); audioMasterButton_spawn(400, 525, "[ X ]", "audioFalse"); --id signs that audio is false if clicking on button
	
    -- we need to do that here otherwise the enemies and coins of the TutLvl would appear in the 
	-- Lv. chosen because the TutLv is the game gamestate
	for i=1,#EasyEnemy do 
		table.remove(EasyEnemy, ei)
	end
	for i=1,#FollowerEnemy do
		table.remove(FollowerEnemy, ei)
	end
	for i=1,#turret do
		table.remove(turret, ei)
	end
	for i=1,#coin do
		table.remove(coin,ci)
	end
end
function Settings:draw()
	love.graphics.draw(Settings.settingsBg, 0, 0)
	love.graphics.print("Fullscreen", 247.5, 485);
	love.graphics.print("Sfx", 247.5, 525);
	
	-- Draw the rows on with the Lv. Imgs on screen
	for i=1,#LvlImg do 
		-- we take i on x-axis to say which difference is between each element
		love.graphics.draw(LvlImg[i], ((150*i)-100)*i^.375,150, 0, 0.375, 0.375) 
	end
	-- Img will be drawn if there are >1 more elements 
	for i=1,#LvlImg_2_ do 
		love.graphics.draw(LvlImg_2_[i], ((150*i)+112)*i^.36, 350, 0, 0.375, 0.375)
	end
	-- Print Button with the related values from the table
	for i,v in ipairs(SettingsButton) do
		love.graphics.print(v.text,v.x,v.y, 0, 1.5, 1.5) -- 0 = rot, 2,2 = scaleX,scaleY
	end
	for fmi, fmv in ipairs(fModeButton) do
		love.graphics.print(fmv.text, fmv.x, fmv.y, 0, 1,1);
	end
	for ami, amv in ipairs(audioMasterButton) do
		love.graphics.print(amv.text, amv.x, amv.y, 0, 1, 1);
	end
	love.graphics.print("Press 'Enter' to go Back", 665, 580, 0, .75, .75)
end
function Settings:mousepressed(x, y)
	Settings:SettingsButton_click(x,y);
	Settings:fModeButton_click(x,y);
	Settings:audioMasterButton_click(x,y);
end
function Settings:SettingsButton_click(x,y)
	for i, v in ipairs(SettingsButton) do	
		if x > v.x and	-- Defines where you can click with the mouse to "activate" the button
			x < v.x + fontNew:getWidth(v.text)+120 and
			y > v.y and
			y < v.y + fontNew:getHeight(v.text)+87.5 then
			if v.id == "lvl1" then -- When clicked on Start, the gamestate switches
				Gamestate.switch(Lvl2)	
				change = 1 -- we have to set it here so that gotIt works properly
			end
			if v.id == "lvl2" then
				Gamestate.switch(Lvl3)
				change = 2
			end
			if v.id == "lvl3" then
				Gamestate.switch(Lvl4)
				change = 3
			end
			if v.id == "lvl4" then 
				Gamestate.switch(Lvl5)
				change = 4
			end
			if v.id == "lvl5" then 
				Gamestate.switch(Lvl6)
				change = 5
			end
		end	
	end
end
function Settings:fModeButton_click(x,y)
	for fmi, fmv in ipairs(fModeButton) do 
		if x > fmv.x and x < fmv.x + fontNew:getWidth(fmv.text) and
			y > fmv.y and y < fmv.y + fontNew:getHeight(fmv.text) then 
			if fmv.id == "fModeTrue" and c == 0 then --able to click between borders and enable fullscreen 
				fmv.text, fmv.id = "[ X ]", "fModeFalse";
				c = c + 1;
				local screenSettings = love.graphics.setMode( 800, 600, true, false, 0 ); --fullscreen(true)
				fMode = true;
			elseif fmv.id == "fModeFalse" and c == 1 then 
				fmv.text, fmv.id = "[   ]", "fModeTrue";
				c = 0; --set back to enable it any time again
				local screenSettings = love.graphics.setMode( 800, 600, false, false, 0 )
				fMode = false;
			end
		end
	end
end
function Settings:audioMasterButton_click(x,y) --same here just with audio on/off
	for ami, amv in ipairs(audioMasterButton) do
		if x > amv.x and x < amv.x + fontNew:getWidth(amv.text) and
			y > amv.y and y < amv.y + fontNew:getHeight(amv.text) then 
			if amv.id == "audioFalse" and a == 0 then --disable audio after clicking on button 
				amv.text, amv.id = "[   ]", "audioTrue"; --signs that with clicking another time you can enable audio again
				a = a + 1;
				local audioMaster = love.audio.setVolume(.0)
				audio = false;
			elseif amv.id == "audioTrue" and a == 1 then 
				amv.text, amv.id = "[ X ]", "audioFalse";
				local audioMaster = love.audio.setVolume(1.0) --1.0f is maxTimes volume for master
				a = 0;
			--	local audioMaster1 = audioMaster0;
				audio = true;
			end
		end
	end
end	
function Settings:keyreleased(k)
	if k == "return" then 
		Gamestate.switch(menu); menu.backgroundMusic:play();
		toSettings = toSettings - 1; --otherwise change would equal change when entering tutorial
	end
end