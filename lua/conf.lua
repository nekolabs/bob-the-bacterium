-- conf.lua
function love.conf(t)
  t.identity = nil  -- no save directory
  t.version = "0.9.0" -- runs for löve 0.9.0 (baby inspector) 
  t.console = false -- no console (only ms windows)
  
  t.window.title = "Bob The Bacterium" 
  t.window.borderless = false -- no border visuals on window
  t.window.resizable = false -- don't resize window by hand
  t.window.fullscreen = false -- fullscreen is deactivated by default
  t.window.fullscreentype ="normal" -- enabling standard fullscreen mode  
  t.window.vsync = true -- enable vertical snychronisation 
  t.window.display = 1 -- monitor 1 is default monitor
  t.window.fsaa = 0

  t.modules.audio = true  
  t.modules.sound = true 
  t.modules.event = true 
  t.modules.graphics = true
  t.modules.image = true
  t.modules.joystick = false
  t.modules.math = true 
  t.modules.physics = false -- don't use physics module  
  t.modules.system = false -- no data is getting stored
  t.modules.mouse = true 
  t.modules.window = true
end
