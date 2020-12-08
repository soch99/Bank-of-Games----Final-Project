local push = require 'push'

WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

VIRTUAL_WIDTH = 400
VIRTUAL_HEIGHT = 400

function love.load()

    love.graphics.setDefaultFilter('nearest', 'nearest')
    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        vsync = false,
        resizable = true
})

    Window = love.window.setMode( 800, 400)
    love.window.setTitle('Snakey Snake')

    gridXCount = 40
    gridYCount = 20


    function Apple()
        local ApplePositions = {}

        for AppleX = 1, gridXCount do
            for AppleY = 1, gridYCount do
                local possible = true

                for segmentIndex, segment in ipairs(snakeSegments) do
                    if AppleX == segment.x and AppleY == segment.y then
                        possible = false
                    end
                end

                if possible then
                    table.insert(ApplePositions, {x = AppleX, y = AppleY})
                end
            end
        end

        foodPosition = ApplePositions[
            love.math.random(#ApplePositions)
        ]
    end

    function reset()
        snakeSegments = {
            {x = 3, y = 1},
            {x = 2, y = 1},
            {x = 1, y = 1},
        }
        directionQueue = {'right'}
        snakeAlive = true
        timer = 0
        Apple()
    end

    reset()
end

function love.update(dt)
    timer = timer + dt

    if snakeAlive then
        if timer >= 0.06 then
            timer = 0

            if #directionQueue > 1 then
                table.remove(directionQueue, 1)
            end

            local nextXPosition = snakeSegments[1].x
            local nextYPosition = snakeSegments[1].y

            if directionQueue[1] == 'right' then
                nextXPosition = nextXPosition + 1
                if nextXPosition > gridXCount then
                    nextXPosition = 1
                end
            elseif directionQueue[1] == 'left' then
                nextXPosition = nextXPosition - 1
                if nextXPosition < 1 then
                    nextXPosition = gridXCount
                end
            elseif directionQueue[1] == 'down' then
                nextYPosition = nextYPosition + 1
                if nextYPosition > gridYCount then
                    nextYPosition = 1
                end
            elseif directionQueue[1] == 'up' then
                nextYPosition = nextYPosition - 1
                if nextYPosition < 1 then
                    nextYPosition = gridYCount
                end
            end

            local canMove = true

            for segmentIndex, segment in ipairs(snakeSegments) do
                if segmentIndex ~= #snakeSegments
                and nextXPosition == segment.x
                and nextYPosition == segment.y then
                    canMove = false
                end
            end

            if canMove then
                table.insert(snakeSegments, 1, {
                    x = nextXPosition, y = nextYPosition
                })

                if snakeSegments[1].x == foodPosition.x
                and snakeSegments[1].y == foodPosition.y then
                    Apple()
                else
                    table.remove(snakeSegments)
                end
            else
                snakeAlive = false
            end
        end
    elseif timer >= 2 then
        reset()
    end
    
end

function love.keypressed(key)
    if key == 'right'
    and directionQueue[#directionQueue] ~= 'right'
    and directionQueue[#directionQueue] ~= 'left' then
        table.insert(directionQueue, 'right')

    elseif key == 'left'
    and directionQueue[#directionQueue] ~= 'left'
    and directionQueue[#directionQueue] ~= 'right' then
        table.insert(directionQueue, 'left')

    elseif key == 'up'
    and directionQueue[#directionQueue] ~= 'up'
    and directionQueue[#directionQueue] ~= 'down' then
        table.insert(directionQueue, 'up')

    elseif key == 'down'
    and directionQueue[#directionQueue] ~= 'down'
    and directionQueue[#directionQueue] ~= 'up' then
        table.insert(directionQueue, 'down')
    end

    if key == "escape" then
        love.event.quit()
    end
end

function love.draw()
    local cellSize = 20

    love.graphics.setColor(.28, .28, .28)
    love.graphics.rectangle('fill', 0, 0, gridXCount * cellSize, gridYCount * cellSize)

    

    local function drawCell(x, y)
        love.graphics.rectangle('fill', (x - 1) * cellSize, (y - 1) * cellSize, cellSize - 1, cellSize - 1)
    end

    for segmentIndex, segment in ipairs(snakeSegments) do
        if snakeAlive then
            love.graphics.setColor(.6, 1, .32)
        else
            love.graphics.setColor(.5, .5, .5)
            love.graphics.print("You Lose", 50, 50, 0, 5, 5)
        end
        drawCell(segment.x, segment.y)
    end

    love.graphics.setColor(1, .3, .3)
    drawCell(foodPosition.x, foodPosition.y)

    
end
