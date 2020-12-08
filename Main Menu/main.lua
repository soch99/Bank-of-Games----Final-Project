function switchroom(room)
	
	love.update = nil
	love.draw = nil
	love.keypressed = nil
	
	love.filesystem.load("rooms/"..room..".lua")()
	
	love.load()
end
switchroom("load")




