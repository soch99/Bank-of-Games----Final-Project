function love.load()
	love.window.setTitle("Menu")
	default_color.body = {0.66, 0.66, 0.66}
	default_color.txt = {1,1,1}
	default_color.htxt = {0.86, 0, 0}
	currb = 1 
	buttons = {}
	xsize = size*4/3
	button_font = love.graphics.newFont(32*size)
	
	options = {"Pong","Snakey Snake","Tic Tac Toe","End"}
	for i = 1, #options do 
	buttonf.new(i,60*xsize,60+(i*50-40/size)*size,200*xsize,40*size)
	buttonf.setxt(i,options[i],button_font)
	 buttons[i].click = {
			function() 
				buttons = {}
				switchroom(options[i])
			end
			}
	end
	logo_alpha = 0
end
function love.draw()
	g.setColor(0, 0.78, 0, logo_alpha)
	
	love.graphics.printf(string.upper("-- Bank of Games --"),0,10*size, 426*size,"center")
	buttonf.draw()
end
function love.update(dt)
	
	if logo_alpha < 0.86 then
		logo_alpha = logo_alpha + dt*0.8
	end
end

function love.keypressed(key,scancode)
	buttonf.key(key,scancode)
	if key == "1" then
		size = 1
		xsize = size * (4/3)
		love.window.setMode(426,320)
		switchroom("Mainmenu")
	elseif key == "2" then
		size = 2
		xsize = size * (4/3)
		love.window.setMode(853,640)
		switchroom("Mainmenu")
	elseif key == "3" then
		size = 3
		xsize = size * (4/3)
		love.window.setMode(1280,960)
		switchroom("Mainmenu")
	elseif key == "4" then
		size = 4
		xsize = size * (4/3)
		love.window.setMode(1706,1280)
		switchroom("Mainmenu")
	elseif key == "f1" then
		switchroom("Help")
	elseif key == "escape" then
		love.event.push('quit')
	end
end