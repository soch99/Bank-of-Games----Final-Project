local push = require 'push'

VIRTUAL_WIDTH = 400
VIRTUAL_HEIGHT = 400

WINDOW_WIDTH = 400
WINDOW_HEIGHT = 400

love.window.setTitle = "Tic Tac Toe"
love.window.width = 400
love.window.height = 400


local map = {
    {" ", " ", " "}, 
    {" ", " ", " "},
    {" ", " ", " "}
}

local solutions = {
    {{x = 1, y = 1}, {y = 2, x = 1}, {y = 3, x = 1}},
    {{y = 1, x = 3}, {y = 2, x = 3}, {y = 3, x = 3}},
    {{y = 1, x = 1}, {y = 1, x = 2}, {y = 1, x = 3}},
    {{y = 3, x = 1}, {y = 3, x = 2}, {y = 3, x =3}},
    {{y = 1, x = 1}, {y = 2, x = 2}, {y = 3, x = 3}},
    {{y = 1, x = 3}, {y = 2, x = 2}, {y = 3, x = 1}},
    {{y = 2, x = 1}, {y = 2, x = 2}, {y = 2, x = 3}}
}




local empty_image, o_image, x_image, scale
local turn = "x"
local text = "x turn"
local finish = false
function love.load()
    love.graphics.setDefaultFilter('nearest', 'nearest')
    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        vsync = false,
        resizable = true
})

    Window = love.window.setMode( 600, 700)
    

    scale = 4
    empty_image = love.graphics.newImage("empty.png")
    empty_image:setFilter("nearest")
    o_image = love.graphics.newImage("o.png")
    o_image:setFilter("nearest")
    x_image = love.graphics.newImage("x.png")
    x_image:setFilter("nearest")


end

function love.draw()
    love.graphics.print(text, 200, 0, 0, 3, 3, 3, 3)
    for y=1, #map do
        for x = 1, #map[y] do 
            local value = map[y][x]
            if value == " " then
                love.graphics.draw(empty_image, x * 32 * scale, y * 32 * scale, 0, scale, scale)
            elseif value == "x" then
                love.graphics.draw(x_image, x * 32 * scale, y * 32 * scale, 0, scale, scale)
            else
                love.graphics.draw(o_image, x * 32 * scale, y * 32 * scale, 0, scale, scale)
            end
        end
    end
end

function love.mousepressed(x, y, button)
    if not finish then
        if button == 1 then
            for yMap = 1, 3 do
                for xMap = 1, 3 do
                    if x > xMap * 32 * scale and x < (xMap + 1) * 32 * scale then
                        if y > yMap * 32 * scale and y < (yMap + 1) * 32 * scale then
                            if map[yMap][xMap] == " " then
                                map[yMap][xMap] = turn
                                if turn == "x" then turn = "o" else turn = "x" end
                                text = turn .. " turn"
                            end
                            checkWin()
                            return
                        end
                    end
                end
            end
        end
    else
        map = {
            {" ", " ", " "},
            {" ", " ", " "},
            {" ", " ", " "}
        }
        finish = false
        turn = "x"
        text = "x turn"
        
    end
end

function checkWin()
    for i = 1, #solutions do
        local item = solutions[i]
        if map[item[1].y][item[1].x] == map[item[2].y][item[2].x] then
            if map[item[3].y][item[3].x] == map[item[2].y][item[2].x] then
                if map[item[1].y][item[1].x] ~= " " then
                    text = map[item[1].y][item[1].x] .. " wins!"
                    finish = true
                end
            end
        end
    end
end
