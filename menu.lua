-- menu.lua  Start, Quit, Options and Credits Buttons

menu = Gamestate.new()
local ver, lg = "0.095B Curie", love.graphics 
function menu:init()
    self.menuBg, self.logo = love.graphics.newImage("assets/bg.jpg"), love.graphics.newImage("assets/logo.png");
	
	--Music
	self.backgroundMusic = love.audio.newSource("sfx/The_Famiclone.ogg");
	self.backgroundMusic:play();
  self.backgroundMusic:setVolume(0.5)
	self.backgroundMusic:setLooping(true);

	-- Use Font Pix Antiqua
	MenuButton = {}
	-- size of buttons is set in draw function
	local font = love.graphics.newFont("fonts/PixAntiqua.ttf", 30);
	fontNew = font;
	
	-- counts xTimes entered Settings. Now the length of global LvlImg isn't relevant when you don't want 
	-- to enter the Settings, but directly go to the Speech
	toSettings = 0;
	
	function MenuButton_spawn(x,y,text,id)
		table.insert(MenuButton, {x = x, y = y, text = text, id = id}); 
	end
	-- Creates the buttons (Start,Options, Credits, Quit)
	MenuButton_spawn(130, 139, "Start", "start"); MenuButton_spawn(130, 139 + 139/2, "Options", "options");
	MenuButton_spawn(130, 2*139, "Credits", "credits"); MenuButton_spawn(130, 2*139 + 139/2, "Quit", "quit");
end
function menu:draw()
	love.graphics.draw(menu.menuBg, 0, 0);
	love.graphics.draw(menu.logo, 127.5, 25);
	
	love.graphics.print(ver, lg.getWidth()/2 - 22.5, lg.getHeight()/(3/2.85), 0, .866, .866);
	
	-- Print Button with the related values from the table
	for i,v in ipairs(MenuButton) do
		love.graphics.print(v.text,v.x,v.y, 0, 1.5, 1.5); -- 0 = rot, 2,2 = scaleX,scaleY
	end
end
function menu:mousepressed(x, y)
	menu:MenuButton_click(x,y);
end
function menu:MenuButton_click(x,y)
	for i, v in ipairs(MenuButton) do
			if x > v.x and			-- Defines where you can click with the mouse to "activate" the button
			x < v.x + fontNew:getWidth(v.text) and
			y > v.y and
			y < v.y + fontNew:getHeight(v.text) then
				if v.id == "start" then  -- When clicked on Start, the gamestate switches
					Gamestate.switch(speech);
					menu.backgroundMusic:stop();
					menu.backgroundMusic = nil;
					Credits.creditsMusic = nil;
					menu.menuBg = nil;
					Credits.creditsBg = nil;
					Settings.settingsBg = nil;
					if toSettings > 0 then 
						for i=1,#LvlImg do
							table.remove(LvlImg, i);
						end
						for i=1,#LvlImg_2_ do 
							table.remove(LvlImg_2_, i);
						end
						for i=1,#SettingsButton do 
							table.remove(SettingsButton, text);
						end
					end
				end 
				if v.id == "options" then 
					Gamestate.switch(Settings);
					menu.backgroundMusic:stop();
					toSettings = toSettings + 1;
				end
				if v.id == "credits" then 
					Gamestate.switch(Credits);
					-- this way the music also starts again if we leave the credits and go back to them again
					menu.backgroundMusic:stop();
					Credits.creditsMusic:play();
				end
				if v.id == "quit" then
					love.event.push('quit');
					menu.backgroundMusic:stop();
				end
			end
		end
end
