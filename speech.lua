--speech.lua Trent's speech (you might experience some cpu peaks)

speech = Gamestate.new()

local anim8 = require("libsAndSnippets/anim8") -- lib is used for animating trent
local hitButton,lg = 1, love.graphics
local r, sc = 0,1.5 -- args for drawing next button

function speech:init()
	background 	   = love.graphics.newImage("assets/bg.jpg");
	trentImg 	   = love.graphics.newImage("assets/robot.png"); 
	local g  	   = anim8.newGrid(178, 320, trentImg:getWidth(), trentImg:getHeight());
	animTest	   = anim8.newAnimation(g('1-4',1), 0.15)

  nextButton,backButton = {},{}
	local font, fontNew = lg.newFont("fonts/PixAntiqua.ttf", 30), font;	
	
  function buttons_spawn(x,y,text,id)
		table.insert(backButton, {x=x,y=y,text=text,id=id}) 
    table.insert(nextButton, {x=x,y=y,text=text,id=id})
  end
	buttons_spawn(700,270,"->","next")
  buttons_spawn(600,270, "<-","back")
end
function speech:update(dt)
	animTest:update(dt);
	collectgarbage(); --constant use of mem (use of function seems to be necessary here? any suggestions?)
end
function speech:draw()
	lg.draw(background, 0, 0);
	animTest:draw(trentImg, 90, 0); 
 	
  lg.setNewFont("fonts/PixAntiqua.ttf", 21); 
  lg.print("Trent The Quaint", 100, 315);
  lg.setNewFont("fonts/PixAntiqua.ttf", 11.5);
  lg.print("Press 'Enter' to skip", 680, 580);
    
  lg.rectangle("line", 325, 82.5, 425, 195);
  lg.setNewFont("fonts/PixAntiqua.ttf", 20);
    
  local text = { -- speech of trent
  [[Hey!
You over there!]],
  [[Are you alright?
I heard your name was Bob...
Bob the Bacterium!]], 
  [[You were on a passenger ship to the
Mars. On The Curiosity to be exact! 
You and your lovely bacterioid girlfriend
Alice were passengers on that ship]],
  [[Unfortunately she got kidnapped by
Oscar The Bad Bacterium King and
his henchmen Mallory, Marvin and
Mallet when you were about 
to land on our great planet the Mars!]],	
  [[But hey! Don't look so fuzzy!
You still have the chance to
get your lovely bacterioid girlfriend back.
You only need to fight.
I'll instruct you!]],
[[ ]] -- empty string 
}  

  for i=1,#text do -- print text (string in table text is being printed when button is clicked) 
    if hitButton == i then lg.print(text[i], 340,86)
      if i >= #text then
        Gamestate.switch(Lvl1) 
      end
    end
  end
  for i,v in ipairs(backButton) do lg.print(v.text,v.x,v.y, r, sc, sc) end
  for i,v in ipairs(nextButton) do lg.print(v.text,v.x,v.y,r,sc,sc) end
end
function speech:button_click(x,y) -- click between borders of button to change gamestate  
  for i, v in ipairs(nextButton) do 
    if x > v.x and
	    x < v.x + fontNew:getWidth(v.text)+12.5 and
			y > v.y and
			y < v.y + fontNew:getHeight(v.text)+22.5 then
		  if v.id == 'next' then
			  hitButton = hitButton + 1;
      end
    end
  end
  for i, v in ipairs(backButton) do 
	  if x > v.x and
		  x < v.x + fontNew:getWidth(v.text)+12.5 and
			y > v.y and
			y < v.y + fontNew:getHeight(v.text)+22.5 then
			if v.id == 'back' and hitButton > 1 then
			  hitButton = hitButton - 1;
			end
	  end
   end
end
function speech:mousepressed(x, y) speech:button_click(x,y) end
function speech:keyreleased(k)
  if k == 'return' then
    Gamestate.switch(Lvl1)
    ok = true
	elseif k == 'right' then
    Gamestate.switch(speech) 
    hitButton = hitButton + 1 
  elseif k == 'left' and hitButton > 1 then 
      Gamestate.switch(speech)
      hitButton = hitButton - 1
  end
end
