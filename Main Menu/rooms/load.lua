function love.load()
	g = love.graphics
	
	if love.filesystem.getInfo("Pong") then
		lines = {} 
		for line in love.filesystem.lines("Pong") do 
			table.insert(lines, line) 
		end 
		if lines[1] == "853" then
			love.window.setMode(853,640)
			size = 2
		elseif lines[1] == "1280" then
			love.window.setMode(1280,960)
			size = 3
		elseif lines[1] == "1706" then
			size = 4
			love.window.setMode(1706,1280)
		else
			size = 1
		end
		


	else
		love.window.setMode(853,640)
		size = 2 
		xsize = size * (4/3)
		speed = 100
		livemode = "single"
		borders = "yes"
	end
	
	if love.filesystem.getInfo("Snakey_Snake") then
		score = {} 
		for line in love.filesystem.lines("Snakey_snake") do 
			table.insert(score, line) 
		end 
	else
		score = {0,0,0,0,0}
	end
	love.filesystem.load("buttons.lua")()
	white_color = {0.98, 0.98, 0.98}
	switchroom("Mainmenu")
end
